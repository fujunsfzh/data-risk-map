package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * GBase 8s V8.8 南大通用
 * 通用分页版本
 * @author ZJW
 */
public class GBase8sDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        StringBuilder sql = new StringBuilder(originalSql)
                .insert(6, " SKIP " + offset + " FIRST " + limit);
        return sql.toString();
    }
}
