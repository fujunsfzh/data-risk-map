package com.shulian.safe.drm.module.dmap.dynamicds.executor;

import lombok.Data;

/**
 * <p>
 *
 * </p>
 */
@Data
public class SqlInfo {

    /** 入库SQL */
    private String sql;

    /** 参数 */
    private Object[] params;

    /** 数据库连接地址 */
    private String databaseId;

    /** 构造方法 */
    public SqlInfo() {

    }

    /** 构造方法 */
    public SqlInfo(String sql, Object[] params, String databaseId) {
        this.sql = sql;
        this.params = params;
        this.databaseId = databaseId;
    }

}
