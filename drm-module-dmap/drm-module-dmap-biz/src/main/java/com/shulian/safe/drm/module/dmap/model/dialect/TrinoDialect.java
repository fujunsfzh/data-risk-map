package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * Trino 阿里云
 */
public class TrinoDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        StringBuilder sql = new StringBuilder(originalSql).append(" LIMIT ").append(limit);
        if (offset > 0L) {
            sql.append(" OFFSET ").append(offset);
        }
        return sql.toString();
    }
}
