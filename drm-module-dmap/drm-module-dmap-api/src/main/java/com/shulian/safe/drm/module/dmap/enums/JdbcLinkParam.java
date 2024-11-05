package com.shulian.safe.drm.module.dmap.enums;

/**
 * jdbc连接参数配置
 */
public enum JdbcLinkParam {

    MYSQL("mysql", "?remarks=true&useInformationSchema=true&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false"),
    POSTGRESQL("postgresql", "?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false"),
    TIDB("tidb", "?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false"),
    SQLSERVER("sqlserver", ""),
    ORACLE("oracle", "?remarksReporting=true"),
    DM("dm", "?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false"),
    UNKNOWN("unknown", ""),
    ;

    private String key;
    private String param;

    JdbcLinkParam(String key, String driver) {
        this.key = key;
        this.param = driver;
    }

    public String getKey() {
        return key;
    }

    public String getParam() {
        return param;
    }

    /**
     * 根据key查询
     *
     * @param key
     * @return
     */
    public static JdbcLinkParam findByKey(String key) {
        for (JdbcLinkParam param : JdbcLinkParam.values()) {
            if (param.key.equals(key)) {
                return param;
            }
        }
        return UNKNOWN;
    }
}
