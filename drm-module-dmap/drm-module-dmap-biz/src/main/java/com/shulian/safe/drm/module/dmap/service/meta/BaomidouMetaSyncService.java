package com.shulian.safe.drm.module.dmap.service.meta;

import cn.hutool.db.handler.NumberHandler;
import cn.hutool.db.sql.SqlExecutor;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.builder.ConfigBuilder;
import com.baomidou.mybatisplus.generator.config.po.TableField;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.query.SQLQuery;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.shulian.safe.drm.framework.mybatis.core.type.EncryptTypeHandler;
import com.shulian.safe.drm.framework.mybatis.core.util.JdbcUtils;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.model.MetaColumn;
import com.shulian.safe.drm.module.dmap.model.MetaTable;
import com.shulian.safe.drm.module.dmap.model.dialect.DialectFactory;
import com.shulian.safe.drm.module.dmap.model.dialect.IDialect;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * baomidou 同步元数据
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/24 10:41
 * @version: V1.0
 */
@Slf4j
@Service
public class BaomidouMetaSyncService implements IMetaSyncService {

    /**
     * 根据数据源配置ID,查询元数据
     *
     * @param dataBase
     */
    @Override
    public List<MetaTable> getTableList(MetaDatabaseEntity dataBase) {
        return getTableList(dataBase, true);
    }


    public List<MetaTable> getTableList(MetaDatabaseEntity dataBase, boolean isQueryCount) {
        // 查元数据
        List<TableInfo> tableList = getTableList0(dataBase, true);
        // 查数据量
        Map<String, Long> countMap = Maps.newHashMap();
        if (isQueryCount) {
            countMap = queryTableCount(dataBase, tableList);
        }
        // 解析
        return convert(tableList, countMap);
    }

    /**
     * 解析
     *
     * @param tableList
     * @return
     */
    private List<MetaTable> convert(List<TableInfo> tableList, Map<String, Long> countMap) {
        // 返回体
        List<MetaTable> ret = Lists.newArrayList();
        tableList.forEach(e -> {
            // 取表
            List<TableField> fields = e.getFields();
            // 遍历字段
            List<MetaColumn> metaColumns = fields.stream().map(t -> {
                MetaColumn column = new MetaColumn();
                column.setName(t.getName())
                        .setDataType(t.getMetaInfo().getJdbcType().name())
                        .setLength(t.getMetaInfo().getLength())
                        .setScale(t.getMetaInfo().getScale())
                        .setNullable(t.getMetaInfo().isNullable())
                        .setDefaultValue(t.getMetaInfo().getDefaultValue())
                        .setPrimaryKey(t.isKeyFlag())
                        .setKeyIdentityFlag(t.isKeyIdentityFlag())
                        .setRemarks(t.getComment());
                return column;
            }).collect(Collectors.toList());

            MetaTable metaTable = new MetaTable();
            String tableName = e.getName();
            Long count = countMap.get(tableName);
            metaTable.setName(tableName)
                    .setTableType(e.getTableType())
                    .setRemarks(e.getComment())
                    .setHavePrimaryKey(e.isHavePrimaryKey())
                    .setCount(count)
                    .setColumns(metaColumns);
            ret.add(metaTable);
        });
        return ret;
    }

    private Map<String, Long> queryTableCount(MetaDatabaseEntity dataBase, List<TableInfo> tableList) {
        String dbConnUri = dataBase.getDbConnUri();
        String dbUser = dataBase.getDbUser();
        String dbPwd = dataBase.getDbPwd();
        // 解密明文
        String decryptPwd = EncryptTypeHandler.decrypt(dbPwd);
        DbType dbType = JdbcUtils.getDbType(dbConnUri);
        IDialect dialect = DialectFactory.getDialect(dbType);

        Map<String, Long> ret = new HashMap<>(tableList.size());

        Properties props = new Properties();
        props.setProperty("user", dbUser);
        props.setProperty("password", decryptPwd);
        // 设置连接超时时间
        props.setProperty("connectTimeout", String.valueOf(3 * 1000));
        // 获取连接
        try (Connection connection = DriverManager.getConnection(dbConnUri, props)) {
            log.info("{} 数据源，开始查询表数据量", dbConnUri);
            for (TableInfo tableInfo : tableList) {
                String tableName = tableInfo.getName();
                try {
                    // 构建语句
                    String querySql = dialect.buildCountSql(tableName);
                    log.info("{} 表数据量查询语句：{}", tableName, querySql);

                    Number query = SqlExecutor.query(connection, querySql, new NumberHandler());
                    ret.put(tableName, query.longValue());
                    log.info("{} 表数据量：{}", tableName, query);
                } catch (Exception e) {
                    log.error("dbConnUri:{},tableName:{},查询数据量异常：", dbConnUri, tableName, e);
                }
            }
        } catch (SQLException e) {
            log.error("dbConnUri:{},查询数据量异常：", dbConnUri, e);
        }
        return ret;
    }

    /**
     * 根据数据源配置ID,查询元数据
     *
     * @param dataBase
     */
    public List<TableInfo> getTableList0(MetaDatabaseEntity dataBase, boolean skipView) {
        String dbConnUri = dataBase.getDbConnUri();
        String dbUser = dataBase.getDbUser();
        String dbPwd = dataBase.getDbPwd();
        // 解密明文
        String decryptPwd = EncryptTypeHandler.decrypt(dbPwd);
        DbType dbType = JdbcUtils.getDbType(dbConnUri);

        // 使用 MyBatis Plus Generator 解析表结构
        DataSourceConfig.Builder dataSourceConfigBuilder = new DataSourceConfig.Builder(dbConnUri, dbUser, decryptPwd);
        // 忽略视图，业务上一般用不到
        StrategyConfig.Builder strategyConfigBuilder = new StrategyConfig.Builder();
        if (skipView) {
            strategyConfigBuilder.enableSkipView();
        }
        if (Objects.equals(dbType, DbType.SQL_SERVER)) {
            // 特殊：SQLServer jdbc 非标准，参见 https://github.com/baomidou/mybatis-plus/issues/5419
            dataSourceConfigBuilder.databaseQueryClass(SQLQuery.class);
            // 移除 ORACLE 相关的系统表
            strategyConfigBuilder.addExclude("IMPDP_[\\S\\s]+|ALL_[\\S\\s]+|HS_[\\S\\\\s]+");
            strategyConfigBuilder.addExclude("[\\S\\s]+\\$[\\S\\s]+|[\\S\\s]+\\$"); // 表里不能有 $，一般有都是系统的表
        } else if (Objects.equals(dbType, DbType.DM)) {
            // ## 是系统表
            strategyConfigBuilder.addExclude("##[\\S\\s]+");
        }

        DataSourceConfig dataSourceConfig = dataSourceConfigBuilder.build();
        StrategyConfig strategyConfig = strategyConfigBuilder.build();
        // java 属性 只使用 LocalDateTime 类型，不使用 LocalDate
        // GlobalConfig globalConfig = new GlobalConfig.Builder().dateType(DateType.TIME_PACK).build();
        // ConfigBuilder builder = new ConfigBuilder(null, dataSourceConfig, strategyConfig,null, globalConfig, null);
        ConfigBuilder builder = new ConfigBuilder(null, dataSourceConfig, strategyConfig, null, null, null);

        // 按照名字排序
        List<TableInfo> tables = builder.getTableInfoList();
        tables.sort(Comparator.comparing(TableInfo::getName));
        return tables;
    }
}
