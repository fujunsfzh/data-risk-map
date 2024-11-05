package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.yulichang.wrapper.MPJLambdaWrapper;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.security.core.util.SecurityFrameworkUtils;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaColumnRetDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaColumnEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaTableEntity;
import com.shulian.safe.drm.module.dmap.mapper.meta.MetaColumnMapper;
import com.shulian.safe.drm.module.dmap.service.mark.IMarkDataSampleService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.annotation.Resources;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:46
 * @version: V1.0
 */
@Slf4j
@Service
public class MetaColumnServiceImpl extends ServiceImpl<MetaColumnMapper, MetaColumnEntity>
        implements IMetaColumnService {

    @Resource
    private IMarkDataSampleService dataSampleService;

    /**
     * 分页列表
     *
     * @param reqDTO
     * @param pageParam
     * @return
     */
    public PageResult<MetaColumnRetDTO> page(MetaColumnRetDTO reqDTO, PageParam pageParam) {
        return page(reqDTO, pageParam, false);
    }


    public PageResult<MetaColumnRetDTO> page(MetaColumnRetDTO reqDTO, PageParam pageParam, boolean sample) {
        MPJLambdaWrapper<MetaColumnEntity> queryWrapper = new MPJLambdaWrapper<MetaColumnEntity>()
                .selectAll(MetaColumnEntity.class)
                .select(MetaTableEntity::getTableName)
                .leftJoin(MetaTableEntity.class, MetaTableEntity::getId, MetaColumnEntity::getTableId)
                .selectAs(MetaDatabaseEntity::getName,"dbName")
                .leftJoin(MetaDatabaseEntity.class, MetaDatabaseEntity::getId, MetaTableEntity::getDbId);

        queryWrapper.eq(MetaColumnEntity::getDeleted, false);

        Long dbId = reqDTO.getDbId();
        queryWrapper.eq(dbId != null, MetaColumnEntity::getDbId, dbId);

        Long tableId = reqDTO.getTableId();
        queryWrapper.eq(tableId != null, MetaColumnEntity::getTableId, tableId);

        String tableName = reqDTO.getTableName();
        queryWrapper.like(StringUtils.isNotBlank(tableName), MetaColumnEntity::getTableName, tableName);

        queryWrapper.orderByDesc(MetaColumnEntity::getId);
        PageResult<MetaColumnRetDTO> pageResult = baseMapper.selectJoinPage(pageParam, MetaColumnRetDTO.class, queryWrapper);
        if (sample) {
            List<MetaColumnRetDTO> list = pageResult.getList();
            list.forEach(item -> {
                Long tId = item.getTableId();
                String colName = item.getColName();
                List<String> sampleList = dataSampleService.queryList(tId, colName);
                item.setSampleList(sampleList);
            });
        }
        return pageResult;
    }


    /**
     * 根据数据源ID删除
     *
     * @param dbId
     * @return
     */
    public Integer deleteLogicByDbId(Long dbId) {
        MetaColumnEntity update = new MetaColumnEntity();
        update.setDeleted(true);
        String userName = SecurityFrameworkUtils.getLoginUserName();
        update.setUpdater(userName);
        QueryWrapper<MetaColumnEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("db_id", dbId);
        return baseMapper.update(update, queryWrapper);
    }

    /**
     * 物理删除
     *
     * @param dbId
     * @return
     */
    public void deleteByDbId(Long dbId) {
        QueryWrapper<MetaColumnEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("db_id", dbId);
        remove(queryWrapper);
    }


    /**
     * 根据数据库 id 查询列数量
     *
     * @param dbIds
     * @return
     */
    public Long queryCountByDbId(List<Long> dbIds) {
        if (CollectionUtils.isEmpty(dbIds)) {
            return 0L;
        }
        LambdaQueryWrapper<MetaColumnEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaColumnEntity::getDeleted, false);
        queryWrapper.in(MetaColumnEntity::getDbId, dbIds);
        return baseMapper.selectCount(queryWrapper);
    }
}
