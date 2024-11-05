package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * XCloud 数据库分页语句组装实现
 */
public class XCloudDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        StringBuilder sql = new StringBuilder(originalSql).append(" LIMIT ");
        if (offset != 0L) {
            sql.append(" (" + offset + 1 + "," + offset + limit + ") ");
        } else {
            sql.append(limit);
        }
        return sql.toString();
    }
}
