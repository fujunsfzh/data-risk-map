package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * DB2 数据库方言
 *
 */
public class DB2Dialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        long firstParam = offset + 1;
        long secondParam = offset + limit;
        String sql = "SELECT * FROM (SELECT TMP_PAGE.*,ROWNUMBER() OVER() AS ROW_ID FROM ( " + originalSql +
            " ) AS TMP_PAGE) TMP_PAGE WHERE ROW_ID BETWEEN " + firstParam + " AND " + secondParam;
        return sql;
    }
}
