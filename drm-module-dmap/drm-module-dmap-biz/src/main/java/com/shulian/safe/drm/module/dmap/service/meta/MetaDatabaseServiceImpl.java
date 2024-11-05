package com.shulian.safe.drm.module.dmap.service.meta;

import cn.hutool.extra.spring.SpringUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import com.mzt.logapi.context.LogRecordContext;
import com.mzt.logapi.service.impl.DiffParseFunction;
import com.mzt.logapi.starter.annotation.LogRecord;
import com.shulian.safe.drm.framework.common.exception.ServiceException;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.util.AssertUtil;
import com.shulian.safe.drm.framework.common.util.date.LocalDateTimeUtils;
import com.shulian.safe.drm.framework.mybatis.core.type.EncryptTypeHandler;
import com.shulian.safe.drm.framework.mybatis.core.util.JdbcUtils;
import com.shulian.safe.drm.framework.security.core.util.SecurityFrameworkUtils;
import com.shulian.safe.drm.module.dmap.LogRecordConstants;
import com.shulian.safe.drm.module.dmap.convet.MetaConvert;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseRetDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaSchemaReqDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.enums.JdbcCategory;
import com.shulian.safe.drm.module.dmap.enums.JdbcLinkParam;
import com.shulian.safe.drm.module.dmap.enums.SysDbTypeEnum;
import com.shulian.safe.drm.module.dmap.mapper.meta.MetaDatabaseMapper;
import com.shulian.safe.drm.module.dmap.model.DsCreateTypeEnum;
import com.shulian.safe.drm.module.dmap.model.MetaTable;
import com.shulian.safe.drm.module.system.enums.ErrorCodeConstants;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.util.Lists;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.net.URLDecoder;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:44
 * @version: V1.0
 */
@Slf4j
@Service
public class MetaDatabaseServiceImpl extends ServiceImpl<MetaDatabaseMapper, MetaDatabaseEntity> implements IMetaDatabaseService {

    @Resource(name = "baomidouMetaSyncService")
    private IMetaSyncService metaSyncService;

    @Resource
    private IMetaTableService metaTableService;


    /**
     * 分页查询
     *
     * @return
     */
    @Override
    public Page<MetaDatabaseRetDTO> page(MetaDatabaseRetDTO reqDTO, PageParam pageParam) {
        LambdaQueryWrapper<MetaDatabaseEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaDatabaseEntity::getDeleted, false);

        String name = reqDTO.getName();
        if (StringUtils.isNotBlank(name)) {
            name = URLDecoder.decode(name);
        }
        queryWrapper.like(StringUtils.isNotBlank(name), MetaDatabaseEntity::getName, name);

        String dbType = reqDTO.getDbType();
        queryWrapper.eq(StringUtils.isNotBlank(dbType), MetaDatabaseEntity::getDbType, dbType);

        String dbHost = reqDTO.getDbHost();
        queryWrapper.eq(StringUtils.isNotBlank(dbHost), MetaDatabaseEntity::getDbHost, dbHost);

        Integer dbPort = reqDTO.getDbPort();
        queryWrapper.eq(dbPort != null, MetaDatabaseEntity::getDbPort, dbPort);

        String dbName = reqDTO.getDbName();
        if (StringUtils.isNotBlank(dbName)) {
            dbName = URLDecoder.decode(dbName);
        }
        queryWrapper.like(StringUtils.isNotBlank(dbName), MetaDatabaseEntity::getDbName, dbName);

        String appName = reqDTO.getAppName();
        if (StringUtils.isNotBlank(appName)) {
            appName = URLDecoder.decode(appName);
        }
        queryWrapper.like(StringUtils.isNotBlank(appName), MetaDatabaseEntity::getAppName, appName);

        String appEnv = reqDTO.getAppEnv();
        queryWrapper.eq(StringUtils.isNotBlank(appEnv), MetaDatabaseEntity::getAppEnv, appEnv);

        String appContact = reqDTO.getAppContact();
        queryWrapper.like(StringUtils.isNotBlank(appContact), MetaDatabaseEntity::getAppContact, appContact);

        Integer status = reqDTO.getStatus();
        queryWrapper.eq(status != null, MetaDatabaseEntity::getStatus, status);

        queryWrapper.orderByDesc(MetaDatabaseEntity::getId);
        Page<MetaDatabaseEntity> pages = page(new Page<>(pageParam.getPageNo(), pageParam.getPageSize()), queryWrapper);

        List<MetaDatabaseEntity> records = pages.getRecords();
        List<MetaDatabaseRetDTO> list = records.stream().map(e -> {
            MetaDatabaseRetDTO dto = MetaConvert.INSTANCE.convert(e);
            return dto;
        }).collect(Collectors.toList());

        Page<MetaDatabaseRetDTO> pageResult = new Page<>();
        pageResult.setTotal(pages.getTotal());
        pageResult.setTotal(pages.getTotal());
        pageResult.setRecords(list);
        return pageResult;
    }


    /**
     * 根据数据源类型查询数据源
     *
     * @param dbType
     * @return
     */
    public List<MetaDatabaseRetDTO> queryByDbType(String dbType) {
        MetaDatabaseRetDTO reqDTO = new MetaDatabaseRetDTO();
        reqDTO.setDbType(dbType);
        PageParam pageParam = new PageParam(1, -1);
        Page<MetaDatabaseRetDTO> page = this.page(reqDTO, pageParam);
        return page.getRecords();
    }


    /**
     * 查询详情
     *
     * @param dbId
     * @return
     */
    public MetaDatabaseEntity queryInfo(Long dbId) {
        MetaDatabaseEntity entity = getById(dbId);
        AssertUtil.isFalse(entity == null || entity.getDeleted(), "数据源已不存在");
        return entity;
    }


    /**
     * 删除数据源
     */
    // @Transactional(rollbackFor = Exception.class)
    // public void delete(Long dbId) {
    //     MetaDatabaseEntity entity = getById(dbId);
    //     AssertUtil.isFalse(entity == null || entity.getDeleted(), "数据源已不存在");
    //     // 物理删除数据源
    //     removeById(dbId);
    //     // 物理删除表列
    //     metaTableService.deleteByDbId(dbId);
    // }

    /**
     * 删除数据源
     */
    @LogRecord(type = LogRecordConstants.META_TYPE,
            subType = LogRecordConstants.META_DELETE_SUB_TYPE,
            bizNo = "{{#dbId}}",
            success = LogRecordConstants.META_DELETE_SUCCESS)
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(Long dbId) {
        MetaDatabaseEntity entity = getById(dbId);
        AssertUtil.isFalse(entity == null || entity.getDeleted(), "数据源已不存在");
        // 删除数据源
        MetaDatabaseEntity update = new MetaDatabaseEntity();
        update.setId(dbId);
        update.setDeleted(true);
        baseMapper.updateById(update);
        // 删除表列
        metaTableService.deleteLogicByDbId(dbId);

        // 记录操作日志上下文
        LogRecordContext.putVariable("database", entity);
    }

    /**
     * 修改数据源
     */
    @Override
    @LogRecord(type = LogRecordConstants.META_TYPE,
            subType = LogRecordConstants.META_UPDATE_SUB_TYPE,
            bizNo = "{{#reqDTO.id}}",
            success = LogRecordConstants.META_UPDATE_SUCCESS
    )
    public void updateDB(MetaDatabaseSaveReqDTO reqDTO) {
        Long dbId = reqDTO.getId();
        AssertUtil.notNull(dbId, "数据源主键不能为空");
        checkData(reqDTO);

        // 拼接连接字符串
        String dbType = reqDTO.getDbType();
        String dbHost = reqDTO.getDbHost();
        Integer port = reqDTO.getDbPort();
        Integer dboType = reqDTO.getDboType();
        String dbName = reqDTO.getDbNameList().get(0);
        String connectionStr = genConnectionStr(dbType, dbHost, port, dbName, dboType);
        // 转实体保存
        MetaDatabaseEntity update = MetaConvert.INSTANCE.convert(reqDTO);
        // 库名不允许修改
        // update.setDbName(dbName);
        // +扩展参数
        String extParams = reqDTO.getExtParams();
        if (StringUtils.isNotBlank(extParams)) {
            connectionStr = connectionStr + "&" + extParams;
        }
        update.setDbConnUri(connectionStr);

        // 密码加密保存
        String encrypt = EncryptTypeHandler.encrypt(update.getDbPwd());
        update.setDbPwd(encrypt);
        updateByIdVersion(update);

        // 同步库表元数据
        metaSync(Lists.newArrayList(dbId));
    }

    private void updateByIdVersion(MetaDatabaseEntity update) {
        MetaDatabaseEntity entity = getById(update.getId());
        // Integer version = entity.getVersion();
        // update.setVersion(version + 1);
        String version = entity.getVersion();
        update.setVersion(LocalDateTimeUtils.formatVersion());

        LambdaQueryWrapper<MetaDatabaseEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MetaDatabaseEntity::getDeleted, false);
        wrapper.eq(MetaDatabaseEntity::getId, update.getId());
        wrapper.eq(MetaDatabaseEntity::getVersion, version);
        update(update, wrapper);

        // 记录操作日志上下文
        MetaDatabaseSaveReqDTO diff = MetaConvert.INSTANCE.convertSaveDTO(entity);
        LogRecordContext.putVariable(DiffParseFunction.OLD_OBJECT, diff);
        LogRecordContext.putVariable("database", entity);
    }

    /**
     * 保存数据源
     *
     * @param reqDTO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    @LogRecord(type = LogRecordConstants.META_TYPE,
            subType = LogRecordConstants.META_CREATE_SUB_TYPE,
            bizNo = "{{#dbIds}}",
            success = LogRecordConstants.META_CREATE_SUCCESS)
    public Long createDb(MetaDatabaseSaveReqDTO reqDTO) {
        // 校验入参
        reqDTO.setId(null);
        checkData(reqDTO);

        String dbType = reqDTO.getDbType();
        String dbHost = reqDTO.getDbHost();
        Integer port = reqDTO.getDbPort();
        Integer dboType = reqDTO.getDboType();

        List<String> dbNameList = reqDTO.getDbNameList();
        // 资产探查后，批量添加
        // boolean scan = dbNameList.size() > 1;
        List<Long> dbIdList = Lists.newArrayList();
        dbNameList.forEach(dbName -> {
            // 拼接连接字符串
            String connectionStr = genConnectionStr(dbType, dbHost, port, dbName, dboType);
            MetaDatabaseEntity entity = MetaConvert.INSTANCE.convert(reqDTO);
            // 库名
            entity.setDbName(dbName);
            // +扩展参数
            String extParams = reqDTO.getExtParams();
            if (StringUtils.isNotBlank(extParams)) {
                connectionStr = connectionStr + "&" + extParams;
            }
            entity.setDbConnUri(connectionStr);
            // 密码加密
            String encrypt = EncryptTypeHandler.encrypt(entity.getDbPwd());
            entity.setDbPwd(encrypt);
            // 创建方式: 手动
            // entity.setCreateType(scan ? DsCreateTypeEnum.SCAN.getValue() : DsCreateTypeEnum.MANUAL.getValue());
            entity.setCreateType(DsCreateTypeEnum.MANUAL.getValue());
            // 版本号
            entity.setVersion(LocalDateTimeUtils.formatVersion());
            // 入库
            save(entity);
            Long dbId = entity.getId();
            dbIdList.add(dbId);
        });

        LogRecordContext.putVariable("dbIds", dbIdList);

        // 同步库表元数据
        metaSync(dbIdList);
        return (long) dbIdList.size();
    }


    /**
     * 获得自身的代理对象，解决 AOP 生效问题
     *
     * @return 自己
     */
    private MetaDatabaseServiceImpl getSelf() {
        return SpringUtil.getBean(getClass());
    }


    /**
     * 同步元数据
     *
     * @param dbIds
     */
    @LogRecord(type = LogRecordConstants.META_TYPE,
            subType = LogRecordConstants.META_SYNC_SUB_TYPE,
            bizNo = "{{#dbIds}}",
            success = LogRecordConstants.META_SYNC_SUCCESS)
    @Override
    public void metaSync(List<Long> dbIds) {
        Map<Long, MetaDatabaseEntity> map = Maps.newHashMap();
        for (Long dbId : dbIds) {
            MetaDatabaseEntity database = getById(dbId);
            AssertUtil.notNull(database, "数据源不存在");
            AssertUtil.isFalse(database.getStatus() == 2, String.format("数据源[%s]已在同步中,请稍后再试", dbId));

            // 校验数据源是否连通
            String dbType = database.getDbType();
            String dbHost = database.getDbHost();
            Integer port = database.getDbPort();
            String dbName = database.getDbName();
            Integer dboType = database.getDboType();
            String dbUser = database.getDbUser();
            String dbPwd = database.getDbPwd();
            // 解密明文
            dbPwd = EncryptTypeHandler.decrypt(dbPwd);
            String connectionStr = genConnectionStr(dbType, dbHost, port, dbName, dboType);
            validateConnection(connectionStr, dbUser, dbPwd, true);

            map.put(dbId, database);
        }
        for (Long dbId : dbIds) {
            MetaDatabaseEntity database = map.get(dbId);
            // 异步执行
            getSelf().metaAsyncFeedBack(database);
        }
    }

    /**
     * 异步处理
     *
     * @param database
     */
    @Async("feedBackTaskExecutor")
    public void metaAsyncFeedBack(MetaDatabaseEntity database) {
        Long dbId = database.getId();
        // 同步中
        int status = 2;
        database.setStatus(status);
        updateStatus(dbId, status);
        try {
            List<MetaTable> tableList = metaSyncService.getTableList(database);
            metaTableService.syncTable(dbId, tableList);
            status = 3;
        } catch (Exception e) {
            status = 4;
            log.error("连接:[{}],同步元数据时发生异常", database.getDbConnUri(), e);
        }
        updateStatus(dbId, status);
        log.info("数据源同步完成,id -> {}", dbId);
    }


    private void updateStatus(Long id, Integer status) {
        MetaDatabaseEntity update = new MetaDatabaseEntity();
        update.setStatus(status);
        String userName = SecurityFrameworkUtils.getLoginUserName();
        update.setUpdater(userName);
        LambdaQueryWrapper<MetaDatabaseEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MetaDatabaseEntity::getId, id);
        wrapper.eq(MetaDatabaseEntity::getDeleted, false);
        baseMapper.update(update, wrapper);

    }


    /**
     * 查询支持的数据源类型
     *
     * @return
     */
    public List<String> querySupportedDbType() {
        SysDbTypeEnum[] values = SysDbTypeEnum.values();
        List<String> collect = Arrays.stream(values).filter(e -> !e.getDb().equals(SysDbTypeEnum.OTHER.getDb()))
                .map(SysDbTypeEnum::getDb)
                .collect(Collectors.toList());
        return collect;
    }

    /**
     * 校验数据
     *
     * @param reqDTO
     */
    private void checkData(MetaDatabaseSaveReqDTO reqDTO) {
        String dbType = reqDTO.getDbType();
        SysDbTypeEnum sysDbTypeEnum = SysDbTypeEnum.getSysDbTypeEnum(dbType);
        AssertUtil.notNull(sysDbTypeEnum, "数据源类型错误");

        Integer dboType = reqDTO.getDboType();
        if (sysDbTypeEnum.getDb().equals(SysDbTypeEnum.ORACLE.getDb())) {
            AssertUtil.notNull((dboType), "oracle数据库连接方式不能为空");
        }

        Long dbId = reqDTO.getId();
        if (dbId != null) {
            MetaDatabaseEntity entity = getById(dbId);
            AssertUtil.isFalse(entity == null || entity.getDeleted(), "数据源已不存在");
        }

        // 校验是否已存在
        List<String> dbNameList = reqDTO.getDbNameList();
        dbNameList.forEach(dbName -> {
            String dbHost = reqDTO.getDbHost();
            Integer port = reqDTO.getDbPort();
            String dbUser = reqDTO.getDbUser();
            String dbPwd = reqDTO.getDbPwd();

            Long count = query(dbId, dbName, dbHost, port);
            AssertUtil.isTrue(count == 0, String.format("%s:%s/%s 数据源已存在", dbHost, port, dbName));

            // 校验数据源是否连通
            String connectionStr = genConnectionStr(dbType, dbHost, port, dbName, dboType);
            validateConnection(connectionStr, dbUser, dbPwd, true);
        });
    }

    /**
     * 查询数据源
     *
     * @return
     */
    private Long query(Long dbId, String dbName, String dbHost, Integer dbPort) {
        LambdaQueryWrapper<MetaDatabaseEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaDatabaseEntity::getDeleted, false);
        queryWrapper.eq(MetaDatabaseEntity::getDbHost, dbHost);
        queryWrapper.eq(MetaDatabaseEntity::getDbPort, dbPort);
        queryWrapper.eq(MetaDatabaseEntity::getDbName, dbName);
        queryWrapper.ne(dbId != null, MetaDatabaseEntity::getId, dbId);

        return baseMapper.selectCount(queryWrapper);
    }


    // private String genConnectionStr(MetaDatabaseSaveReqDTO reqDTO) {
    //     return genConnectionStr(
    //             reqDTO.getDbType(),
    //             reqDTO.getDbHost(),
    //             reqDTO.getDbPort(),
    //             reqDTO.getDbName(),
    //             reqDTO.getDboType()
    //     );
    // }


    /**
     * 校验数据源联通性
     *
     * @param databaseId 数据源主键
     */
    public boolean validateConnection(Long databaseId) {
        MetaDatabaseEntity database = getById(databaseId);

        String dbUser = database.getDbUser();
        String dbPwd = database.getDbPwd();
        String decrypt = EncryptTypeHandler.decrypt(dbPwd);
        String dbConnUri = database.getDbConnUri();
        return validateConnection(dbConnUri, dbUser, decrypt, false);
    }

    /**
     * 测试连通性
     *
     * @param connectionStr 连接字符串
     * @param userName      用户名
     * @param password      密码
     * @param assertFlag    断言标识
     */
    private boolean validateConnection(String connectionStr, String userName, String password, boolean assertFlag) {
        log.info("测试数据源连通性,连接串 -> {}", connectionStr);
        boolean success = JdbcUtils.isConnectionOK(connectionStr, userName, password);
        if (assertFlag) {
            AssertUtil.isTrue(success, ErrorCodeConstants.DATA_SOURCE_CONFIG_NOT_OK);
        }
        return success;
    }


    /**
     * 生成连接字符串
     *
     * @param dbType   数据库类型
     * @param host     主机
     * @param port     端口
     * @param database 数据库
     * @param dboType  oracle 连接类型 1-SERVICE_NAME，2-SID
     * @return
     */
    public String genConnectionStr(String dbType, String host, Integer port, String database, Integer dboType) {
        SysDbTypeEnum sysDbTypeEnum = SysDbTypeEnum.getSysDbTypeEnum(dbType);

        String connectionStr = "";
        switch (Objects.requireNonNull(sysDbTypeEnum)) {
            case MYSQL:
                // jdbc:mysql://<host>:<port>/<database>
                connectionStr = JdbcCategory.MYSQL.getUri() + host + ":" + port + "/" + database;
                connectionStr += JdbcLinkParam.MYSQL.getParam();
                break;
            case MARIADB:
                connectionStr = JdbcCategory.MYSQL.getUri() + host + ":" + port + "/" + database;
                connectionStr += JdbcLinkParam.MYSQL.getParam();
                break;
            case ORACLE:
                // 1-SERVICE_NAME，2-SID
                if (dboType != null && dboType == 1) {
                    // jdbc:oracle:thine:@<host>:<port>/<ServiceName>
                    connectionStr = "jdbc:oracle:thin:@//" + host + ":" + port + "/" + database;
                } else {
                    // jdbc:oracle:thine:@<host>:<port>:<SID>
                    connectionStr = "jdbc:oracle:thin:@//" + host + ":" + port + ":" + database;
                }
                connectionStr += JdbcLinkParam.ORACLE.getParam();
                break;
            case POSTGRE_SQL:
                connectionStr = JdbcCategory.POSTGRESQL.getUri() + host + ":" + port + "/" + database;
                connectionStr += JdbcLinkParam.POSTGRESQL.getParam();
                break;
            case SQL_SERVER:
                // jdbc:sqlserver://<host>:<port>;database=<database>
                // connectionStr = JdbcCategory.SQLSERVER.getUri() + host + ":" + port + ";database=" + database;
                connectionStr = JdbcCategory.SQLSERVER.getUri() + host + ":" + port + ";databaseName=" + database;
                connectionStr += JdbcLinkParam.SQLSERVER.getParam();
                break;
            case DM:
                connectionStr = JdbcCategory.DM.getUri() + host + ":" + port + "/" + database;
                connectionStr += JdbcLinkParam.DM.getParam();
                break;
            default:
                throw new IllegalArgumentException("不支持该类型的数据库");
        }
        return connectionStr;
    }


    /**
     * 查询账号下的 schemas
     *
     * @param reqDTO
     * @return
     */
    @Override
    public Set<String> querySchemas(MetaSchemaReqDTO reqDTO) {
        String dbType = reqDTO.getDbType();
        String dbName = reqDTO.getDbName();
        dbName = StringUtils.isNotBlank(dbName) ? dbName : "";

        String dbConnUri = genConnectionStr(
                dbType,
                reqDTO.getDbHost(),
                reqDTO.getDbPort(),
                dbName,
                reqDTO.getDboType()
        );
        String dbUser = reqDTO.getDbUser();
        String dbPwd = reqDTO.getDbPwd();

        Set<String> catalogNames = new HashSet<>();

        java.util.Properties props = new Properties();
        props.setProperty("user", dbUser);
        props.setProperty("password", dbPwd);
        // 设置连接超时时间
        props.setProperty("connectTimeout", String.valueOf(10 * 1000));
        // 打开链接
        try (Connection connection = DriverManager.getConnection(dbConnUri, props)) {
            ResultSet catalogsResults = null;
            DatabaseMetaData metaData = connection.getMetaData();
            SysDbTypeEnum sysDbTypeEnum = SysDbTypeEnum.getSysDbTypeEnum(dbType);
            // 类 oracle 数据库类型
            if (sysDbTypeEnum.oracleSameType()) {
                catalogsResults = metaData.getSchemas();
            } else {
                catalogsResults = metaData.getCatalogs();
            }
            int numCatalogs = 0;
            List<String> metaDataCatalogNames = readResultsVector(catalogsResults);
            for (String catalogName : metaDataCatalogNames) {
                numCatalogs = numCatalogs + 1;
                catalogNames.add(catalogName);
            }
        } catch (SQLException e) {
            log.error("dbConnUri:{},查询schemas异常", dbConnUri, e);
            throw new ServiceException(ErrorCodeConstants.DATA_SOURCE_CONFIG_NOT_OK);
        }
        log.info("dbConnUri:{},schemas 数据为：{}", dbConnUri, catalogNames);
        return catalogNames;
    }


    public static List<String> readResultsVector(final ResultSet results) throws SQLException {
        final List<String> values = new ArrayList<>();
        if (results == null) {
            return values;
        }
        try {
            while (results.next()) {
                String value = results.getString(1);
                if (!results.wasNull() && StringUtils.isNotBlank(value)) {
                    String val = value.trim();
                    values.add(val);
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            results.close();
        }
        return values;
    }

}
