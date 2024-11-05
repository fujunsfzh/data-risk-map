package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * ORACLE 新版数据库分页语句组装实现
 */
public class Oracle12cDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        String sql = originalSql + " OFFSET " + offset + " ROWS FETCH NEXT " + limit + " ROWS ONLY";
        return sql;
    }
}
