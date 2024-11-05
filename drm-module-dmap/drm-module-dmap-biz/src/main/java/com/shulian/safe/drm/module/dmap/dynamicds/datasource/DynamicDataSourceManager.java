package com.shulian.safe.drm.module.dmap.dynamicds.datasource;

import com.shulian.safe.drm.framework.common.exception.ServiceException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

import java.sql.SQLException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * <p>
 * 动态数据源管理实现
 * 数据源没有实现移除功能
 * </p>
 */
@Slf4j
@Component
public class DynamicDataSourceManager implements IDataSourceManager {

    /**
     * 存放DataSource
     */
    private static final Map<String, BasicDataSource> DATA_SOURCE_MAP = new ConcurrentHashMap<>();

    /***/
    private Lock lock = new ReentrantLock();

    @Override
    public BasicDataSource getDataSource(DataSourceConfig dataSourceConfig) {
        BasicDataSource dataSource = getDataSource(dataSourceConfig.getDatabaseId());
        if (dataSource == null) {
            dataSource = createDataSource(dataSourceConfig);
        }
        log.info("获取数据源成功: {}", dataSourceConfig.getDatabaseId());
        return dataSource;
    }

    /**
     * 获取集群ID对应的数据源
     *
     * @param databaseId 数据库集群ID
     * @return BasicDataSource
     */
    private BasicDataSource getDataSource(String databaseId) {
        return DATA_SOURCE_MAP.get(databaseId);
    }

    /**
     * 创建数据源
     *
     * @param dataSourceConfig DataSourceConfig
     * @return BasicDataSource
     */
    @Override
    public BasicDataSource createDataSource(DataSourceConfig dataSourceConfig) {
        BasicDataSource dataSource = getDataSource(dataSourceConfig.getDatabaseId());
        if (dataSource != null) {
            log.info("已存在数据源: {}", dataSourceConfig.getDatabaseId());
            return dataSource;
        }

        lock.lock();
        try {
            dataSource = getDataSource(dataSourceConfig.getDatabaseId());
            if (dataSource != null) {
                log.info("已存在数据源: {}", dataSourceConfig.getDatabaseId());
                return dataSource;
            }
            dataSource = new BasicDataSource();
            dataSource.setDriverClassName(dataSourceConfig.getDriverClass());
            dataSource.setUrl(dataSourceConfig.getConnectUri());
            dataSource.setUsername(dataSourceConfig.getUsername());
            dataSource.setPassword(dataSourceConfig.getPassword());
            dataSource.setInitialSize(dataSourceConfig.getInitialSize());
            dataSource.setMaxTotal(dataSourceConfig.getMaxtotal());
            dataSource.setMaxIdle(dataSourceConfig.getMaxIdle());
            dataSource.setMaxWaitMillis(dataSourceConfig.getMaxWaitMillis());
            dataSource.setMinIdle(dataSourceConfig.getMinIdle());
            DATA_SOURCE_MAP.put(dataSourceConfig.getDatabaseId(), dataSource);
            log.info("创建数据源成功: {}", dataSourceConfig.getDatabaseId());
            return dataSource;
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void releaseDataSource(String databaseId) {
        BasicDataSource dataSource = getDataSource(databaseId);
        if (dataSource == null) {
            throw new ServiceException(500, "数据源:" + databaseId + "不存在");
        }
        try {
            dataSource.close();
        } catch (SQLException e) {
            log.error("数据源关闭异常", e);
            throw new RuntimeException(e);
        }
        DATA_SOURCE_MAP.remove(databaseId);
        log.info("数据源释放成功: {}", databaseId);
    }

    @Override
    public JdbcTemplate getJdbcTemplate(String databaseId) {
        BasicDataSource dataSource = getDataSource(databaseId);
        if (dataSource == null) {
            throw new ServiceException(500, "数据源:" + databaseId + "不存在");
        }
        return new JdbcTemplate(dataSource);
    }


    @Override
    public NamedParameterJdbcTemplate getNamedParameterJdbcTemplate(String uniqName) {
        BasicDataSource dataSource = getDataSource(uniqName);
        if (dataSource == null) {
            throw new ServiceException(500, "数据源:" + uniqName + "不存在");
        }
        return new NamedParameterJdbcTemplate(dataSource);
    }

}
