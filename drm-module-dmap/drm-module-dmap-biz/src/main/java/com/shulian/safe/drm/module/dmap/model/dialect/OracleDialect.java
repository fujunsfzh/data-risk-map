package com.shulian.safe.drm.module.dmap.model.dialect;


/**
 * ORACLE 数据库 通用分页版本
 *
 * @author ZJW
 */
public class OracleDialect implements IDialect {

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        limit = (offset >= 1) ? (offset + limit) : limit;
        String sql = "SELECT * FROM ( SELECT TMP.*, ROWNUM ROW_ID FROM ( " +
                originalSql + " ) TMP WHERE ROWNUM <= " + limit + ") WHERE ROW_ID > " + offset;
        return sql;
    }
}
