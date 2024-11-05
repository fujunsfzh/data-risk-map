package com.shulian.safe.drm.module.dmap.dynamicds.datasource;

import lombok.Data;

/**
 * <p>
 * 数据源配置
 * </p>
 */
@Data
public class DataSourceConfig {

    /** 数据源id */
    private String databaseId;

    /** 数据库连接串 */
    private String connectUri;

    /** 用户名 */
    private String username;

    /** 密码 */
    private String password;

    /** 数据库连接驱动名 */
    private String driverClass;

    /** 初始连接池连接个数 */
    private int initialSize;

    /** 最大活动连接数 */
    private int maxtotal;

    /** 最大连接数 */
    private int maxIdle;

    /** 最小连接数 */
    private int minIdle;

    /** 获得连接的最大等待毫秒数 */
    private int maxWaitMillis;

    /** 指明连接是否被空闲连接回收器(如果有)进行检验.如果检测失败,则连接将被从池中去除. */
    private boolean testWhileIdle;

    /** 借出连接时不要测试，否则很影响性能 */
    private boolean testOnBorrow;

    /** 验证使用的SQL语句 */
    private String validationQuery;

    private int validationQueryTimeoutSeconds;

    /** 每n毫秒运行一次空闲连接回收器 */
    private long timeBetweenEvictionRunsMillis;

    /** 池中的连接空闲n毫秒后被回收 */
    private long minEvictableIdleTimeMillis;

    /** 在每次空闲连接回收器线程(如果有)运行时检查的连接数量 */
    private int numTestsPerEvictionRun;

}
