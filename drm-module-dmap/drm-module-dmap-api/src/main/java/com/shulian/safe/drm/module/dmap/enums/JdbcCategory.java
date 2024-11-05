package com.shulian.safe.drm.module.dmap.enums;


/**
 * 使用jdbc连接的枚举
 *
 */
public enum JdbcCategory {

    MYSQL("mysql", "com.mysql.cj.jdbc.Driver", "jdbc:mysql://"),
    POSTGRESQL("postgresql", "org.postgresql.Driver", "jdbc:postgresql://"),
    TIDB("tidb", "com.mysql.cj.jdbc.Driver", "jdbc:mysql://"),
    SQLSERVER("sqlserver", "com.microsoft.sqlserver.jdbc.SQLServerDriver", "jdbc:sqlserver://"),
    ORACLE("oracle", "oracle.jdbc.driver.OracleDriver", "jdbc:oracle:thin:@//"),
    DM("dm", "dm.jdbc.driver.DmDriver", "jdbc:dm://"),
    CLICKHOUSE("clickhouse", "ru.yandex.clickhouse.ClickHouseDriver", "jdbc:clickhouse://"),
    HIVE("hive", "org.apache.hive.jdbc.HiveDriver", "jdbc:hive2://"),
    UNKNOWN("unknown", "", ""),
    ;

    private String key;
    private String driver;
    private String uri;

    JdbcCategory(String key, String driver, String uri) {
        this.key = key;
        this.driver = driver;
        this.uri = uri;
    }

    public String getKey() {
        return key;
    }

    public String getDriver() {
        return driver;
    }

    public String getUri() {
        return uri;
    }

    /**
     * 根据key查询
     *
     * @param key
     * @return
     */
    public static JdbcCategory findByKey(String key) {
        for (JdbcCategory category : JdbcCategory.values()) {
            if (category.key.equals(key)) {
                return category;
            }
        }
        return UNKNOWN;
    }

}
