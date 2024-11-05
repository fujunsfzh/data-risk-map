package com.shulian.safe.drm.module.dmap.model.dialect;

/**
 * Postgre 数据库分页语句组装实现
 * @author ZJW
 */
public class PostgreDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        StringBuilder sql = new StringBuilder(originalSql).append(" LIMIT ").append(limit);
        if (offset > 0) {
            sql.append(" OFFSET ").append(offset);
        }
        return sql.toString();
    }
}
