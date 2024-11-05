package com.shulian.safe.drm.module.dmap.dynamicds.datasource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

/**
 * <p>
 * 数据源管理接口
 * </p>
 */
public interface IDataSourceManager {

    /**
     * 获取数据源
     *
     * @param dataSourceConfig 数据源配置信息
     * @return BasicDataSource
     */
    BasicDataSource getDataSource(DataSourceConfig dataSourceConfig);

    /**
     * 创建数据源
     *
     * @param dataSourceConfig DataSourceConfig
     * @return BasicDataSource
     */
    BasicDataSource createDataSource(DataSourceConfig dataSourceConfig);

    /**
     * 释放数据源
     *
     * @param databaseId 数据库集群id
     */
    void releaseDataSource(String databaseId);

    /**
     * 获取JdbcTemplate
     *
     * @param databaseId 数据库集群id
     * @return JdbcTemplate
     */
    JdbcTemplate getJdbcTemplate(String databaseId);

    /**
     * 获取NamedParameterJdbcTemplate
     *
     * @param uniqName 数据源唯一名称
     * @return NamedParameterJdbcTemplate
     */
    NamedParameterJdbcTemplate getNamedParameterJdbcTemplate(String uniqName);

}
