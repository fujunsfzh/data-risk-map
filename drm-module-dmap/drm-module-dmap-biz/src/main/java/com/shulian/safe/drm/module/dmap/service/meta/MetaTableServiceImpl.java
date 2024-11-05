package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.yulichang.wrapper.MPJLambdaWrapper;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.common.util.date.LocalDateTimeUtils;
import com.shulian.safe.drm.framework.security.core.util.SecurityFrameworkUtils;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaTableRetDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaColumnEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaTableEntity;
import com.shulian.safe.drm.module.dmap.mapper.meta.MetaTableMapper;
import com.shulian.safe.drm.module.dmap.model.MetaColumn;
import com.shulian.safe.drm.module.dmap.model.MetaTable;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.util.Lists;
import org.springframework.dao.DeadlockLoserDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:45
 * @version: V1.0
 */
@Slf4j
@Service
public class MetaTableServiceImpl extends ServiceImpl<MetaTableMapper, MetaTableEntity>
        implements IMetaTableService {

    @Resource
    private IMetaColumnService metaColumnService;

    /**
     * 分页列表
     *
     * @param reqDTO
     * @param pageParam
     * @return
     */
    public PageResult<MetaTableRetDTO> page(MetaTableRetDTO reqDTO, PageParam pageParam) {
        MPJLambdaWrapper<MetaTableEntity> queryWrapper = new MPJLambdaWrapper<MetaTableEntity>()
                .selectAll(MetaTableEntity.class)
                .selectAs(MetaDatabaseEntity::getName,"dbName")
                .leftJoin(MetaDatabaseEntity.class, MetaDatabaseEntity::getId, MetaTableEntity::getDbId);
        queryWrapper.eq(MetaTableEntity::getDeleted, false);

        Long dbId = reqDTO.getDbId();
        queryWrapper.eq(dbId != null, MetaTableEntity::getDbId, dbId);

        Integer type = reqDTO.getType();
        queryWrapper.eq(type != null, MetaTableEntity::getType, type);

        String tableName = reqDTO.getTableName();
        queryWrapper.like(StringUtils.isNotBlank(tableName), MetaTableEntity::getTableName, tableName);

        String tableNameZh = reqDTO.getTableNameZh();
        queryWrapper.like(StringUtils.isNotBlank(tableNameZh), MetaTableEntity::getTableNameZh, tableNameZh);

        queryWrapper.orderByDesc(MetaTableEntity::getId);
        PageResult<MetaTableRetDTO> result = baseMapper.selectJoinPage(pageParam, MetaTableRetDTO.class, queryWrapper);
        return result;
    }


    /**
     * 待优化
     * <p>
     * 死锁后，数据库里查看不到死锁详情，添加了死锁重试
     * <p>
     * org.springframework.dao.DeadlockLoserDataAccessException:
     * ### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MySQLTransactionRollbackException: Deadlock found when trying to get lock; try restarting transaction
     * ### The error may exist in com/shulian/safe/drm/module/dmap/mapper/meta/MetaTableMapper.java (best guess)
     * ### The error may involve com.shulian.safe.drm.module.dmap.mapper.meta.MetaTableMapper.insert-Inline
     * ### The error occurred while setting parameters
     * ### SQL: INSERT INTO ds_meta_table  ( db_id, type, table_name, table_name_zh, count, version, creator, dept_id, create_time, updater, update_time )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )
     * ### Cause: com.mysql.cj.jdbc.exceptions.MySQLTransactionRollbackException: Deadlock found when trying to get lock; try restarting transaction
     * ; Deadlock found when trying to get lock; try restarting transaction; nested exception is com.mysql.cj.jdbc.exceptions.MySQLTransactionRollbackException: Deadlock found when trying to get lock; try restarting transaction
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void syncTable(Long dbId, List<MetaTable> tables) {
        int maxRetries = 3;
        int attempt = 0;

        while (attempt < maxRetries) {
            try {
                // 执行插入操作
                doSyncTable(dbId, tables);
                // 如果成功，退出循环
                break;
            } catch (DeadlockLoserDataAccessException e) {
                attempt++;
                if (attempt >= maxRetries) {
                    // 超过最大重试次数，抛出异常
                    throw e;
                }
                // 等待一段时间后再重试
                try {
                    // 等待100毫秒
                    int nextInt = ThreadLocalRandom.current().nextInt(100, 300);
                    Thread.sleep(nextInt);
                } catch (InterruptedException ie) {
                    // 处理被中断的情况
                    Thread.currentThread().interrupt();
                }
            }
        }
    }

    public void doSyncTable(Long dbId, List<MetaTable> tables) {
        // 查询最大版本号
        // Integer maxVersion = queryMaxVersion(dbId);
        // Integer newVersion = maxVersion + 1;

        String newVersion = LocalDateTimeUtils.formatVersion();

        // 删除表，删除列
        deleteLogicByDbId(dbId);

        // 当前用户
        String userName = SecurityFrameworkUtils.getLoginUserName();
        Long deptId = SecurityFrameworkUtils.getLoginUserDeptId();

        // 重新添加
        List<MetaColumnEntity> columnsList = Lists.newArrayList();
        for (MetaTable e : tables) {
            // 重新同步表
            MetaTableEntity table = new MetaTableEntity();

            String tableName = e.getName();
            table.setDbId(dbId)
                    .setTableName(tableName)
                    .setTableNameZh(e.getRemarks())
                    // 表和视图
                    .setType("VIEW".equals(e.getTableType()) ? 2 : 1)
                    .setCount(e.getCount())
                    .setVersion(newVersion);
            table.setCreator(userName);
            table.setDeptId(deptId);
            table.setUpdater(userName);

            // fixme
            // Deadlock found when trying to get lock
            save(table);

            // 重新同步列
            Long tableId = table.getId();
            List<MetaColumn> columns = e.getColumns();
            List<MetaColumnEntity> collect = columns.stream().map(c -> {
                MetaColumnEntity column = new MetaColumnEntity();
                column.setDbId(dbId)
                        .setTableId(tableId)
                        .setTableName(tableName)
                        .setColName(c.getName())
                        .setColNameZh(c.getRemarks())
                        .setDataType(c.getDataType())
                        .setDataLength(c.getLength())
                        .setDataScale(c.getScale())
                        .setNullable(c.getNullable())
                        .setDefaultValue(c.getDefaultValue())
                        .setPrimaryKey(c.getPrimaryKey())
                        .setKeyIdentityFlag(c.getKeyIdentityFlag())
                        .setForeignKey(c.getForeignKey())
                        .setVersion(newVersion);
                column.setCreator(userName);
                column.setDeptId(deptId);
                column.setUpdater(userName);
                return column;
            }).collect(Collectors.toList());

            columnsList.addAll(collect);
        }
        if (CollectionUtils.isNotEmpty(columnsList)) {
            metaColumnService.saveBatch(columnsList);
        }
    }

    /**
     * 查询最大版本号
     *
     * @param dbId
     * @return
     */
    private Integer queryMaxVersion(Long dbId) {
        QueryWrapper<MetaTableEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("MAX(version) as max_version")
                .eq("deleted", 0)
                .eq("db_id", dbId);
        MetaTableEntity metaTableEntity = baseMapper.selectOne(queryWrapper);
        if (metaTableEntity == null) {
            return 0;
        }
        return metaTableEntity.getMaxVersion();
    }

    /**
     * 根据数据源 Id，逻辑删除表/列
     *
     * @param dbId
     * @return
     */
    public void deleteLogicByDbId(Long dbId) {
        MetaTableEntity update = new MetaTableEntity();
        update.setDeleted(true);
        String userName = SecurityFrameworkUtils.getLoginUserName();
        update.setUpdater(userName);
        QueryWrapper<MetaTableEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("db_id", dbId);
        baseMapper.update(update, queryWrapper);

        // 删除字段
        metaColumnService.deleteLogicByDbId(dbId);
    }

    /**
     * 物理删除表列
     *
     * @param dbId
     */
    public void deleteByDbId(Long dbId) {
        // 删除表
        QueryWrapper<MetaTableEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("db_id", dbId);
        remove(queryWrapper);

        // 删除字段
        metaColumnService.deleteByDbId(dbId);
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    /**
     * 查询 资产总数据量
     *
     * @return
     */
    public Long queryIndexTotal() {
        LambdaQueryWrapper<MetaTableEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaTableEntity::getDeleted, false);
        List<MetaTableEntity> list = baseMapper.selectList(queryWrapper);
        return list.stream().mapToLong(MetaTableEntity::getCount).sum();
    }

    /**
     * 根据数据库 id 查询表数量
     *
     * @param dbIds
     * @return
     */
    @Override
    public Long queryCountByDbId(List<Long> dbIds) {
        if (CollectionUtils.isEmpty(dbIds)) {
            return 0L;
        }
        LambdaQueryWrapper<MetaTableEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaTableEntity::getDeleted, false);
        queryWrapper.in(MetaTableEntity::getDbId, dbIds);
        return baseMapper.selectCount(queryWrapper);
    }


}
