package com.shulian.safe.drm.module.dmap.dynamicds.datasource;

import com.shulian.safe.drm.framework.mybatis.core.type.EncryptTypeHandler;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.enums.JdbcCategory;

/**
 * <p>
 * 数据源配置工厂
 * </p>
 */
public class DataSourceConfigFactory {

    /**
     * 数据库连接驱动名
     */
    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";

    /**
     * 初始连接池连接个数
     */
    // private static final int INITIAL_SIZE = 50;
    private static final int INITIAL_SIZE = 10;

    /**
     * 最大连接数
     */
    // private static final int MAX_TOTAL = 100;
    private static final int MAX_TOTAL = 50;

    /**
     * 最大空闲连接数
     */
    private static final int MAX_IDLE = 100;

    /**
     * 最小空闲连接数
     */
    private static final int MIN_IDLE = 100;

    /**
     * 获得连接的最大等待毫秒数
     */
    private static final int MAX_WAIT_MILLIS = 10000;

    /**
     * mysql jdbc前缀
     */
    private static final String JDBC_MYSQL = "jdbc:mysql://";

    /**
     * mysql jdbc连接参数
     */
    private static final String MYSQL_CONNECTION_PARAMS = "?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=GMT%2B8";

    private static final boolean TEST_WHILE_IDLE = true;

    private static final boolean TEST_WHILE_BORROW = false;

    private static final String VALIDATION_QUERY = "select 1";

    private static final int VALIDATION_QUERY_TIMEOUT_SECONDS = 5;

    private static final int TIME_BETWEEN_EVICTION_RUNS_MILLIS = 10000;

    // minEvictableIdleTimeMillis
    private static final int MIN_EVICTABLE_IDLE_TIME_MILLIS = 20000;

    // numTestsPerEvictionRun
    private static final int NUM_TESTS_PER_EVICTION_RUN = 3;

    /**
     * 创建DataSourceConfig
     *
     * @return DataSourceConfig
     */
    public static DataSourceConfig create(MetaDatabaseEntity database) {
        String databaseId = database.getId().toString();
        String dbConnUri = database.getDbConnUri();
        String dbUser = database.getDbUser();
        String dbPwd = EncryptTypeHandler.decrypt(database.getDbPwd());

        // 连接类型
        String dbType = database.getDbType();
        JdbcCategory jdbcCategory = JdbcCategory.findByKey(dbType);
        String driver = jdbcCategory.getDriver();

        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setDatabaseId(databaseId);
        dataSourceConfig.setConnectUri(dbConnUri);
        dataSourceConfig.setUsername(dbUser);
        dataSourceConfig.setPassword(dbPwd);
        dataSourceConfig.setDriverClass(driver);

        dataSourceConfig.setInitialSize(INITIAL_SIZE);
        dataSourceConfig.setMaxtotal(MAX_TOTAL);
        dataSourceConfig.setMaxIdle(MAX_IDLE);
        dataSourceConfig.setMaxIdle(MIN_IDLE);
        dataSourceConfig.setMaxWaitMillis(MAX_WAIT_MILLIS);

        dataSourceConfig.setTestWhileIdle(TEST_WHILE_IDLE);
        dataSourceConfig.setValidationQuery(VALIDATION_QUERY);
        dataSourceConfig.setTestOnBorrow(TEST_WHILE_BORROW);
        dataSourceConfig.setValidationQueryTimeoutSeconds(VALIDATION_QUERY_TIMEOUT_SECONDS);
        dataSourceConfig.setTimeBetweenEvictionRunsMillis(TIME_BETWEEN_EVICTION_RUNS_MILLIS);
        dataSourceConfig.setMinEvictableIdleTimeMillis(MIN_EVICTABLE_IDLE_TIME_MILLIS);
        dataSourceConfig.setNumTestsPerEvictionRun(NUM_TESTS_PER_EVICTION_RUN);

        return dataSourceConfig;
    }

}
