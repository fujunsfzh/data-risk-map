package com.shulian.safe.drm.module.dmap.model.dialect;


import org.apache.commons.lang3.StringUtils;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * SQLServer 2005 数据库分页方言
 *
 * @author ZJW
 */
public class SQLServer2005Dialect implements IDialect {

    private static final Pattern ORDER_BY_PATTERN = Pattern.compile("\\((.)*order by(.)*\\)");

    private static final Pattern SELECT_PATTERN = Pattern.compile("(?i)select\\s+(distinct\\s+)?");

    public String getOrderByPart(String sql) {
        String order_by = "order by";
        int lastIndex = sql.toLowerCase().lastIndexOf(order_by);
        if (lastIndex == -1) {
            return "";
        }
        Matcher matcher = ORDER_BY_PATTERN.matcher(sql);
        if (!matcher.find()) {
            return sql.substring(lastIndex);
        }
        int end = matcher.end();
        return lastIndex < end ? "" : sql.substring(lastIndex);
    }

    @Override
    public String buildPaginationSql(String originalSql, long offset, long limit) {
        StringBuilder pagingBuilder = new StringBuilder();
        String orderby = getOrderByPart(originalSql);
        String distinctStr = "";
        String sqlPartString = originalSql;
        Matcher matcher = SELECT_PATTERN.matcher(originalSql);
        if (matcher.find()) {
            int index = matcher.end() - 1;
            if (matcher.group().toLowerCase().contains("distinct")) {
                distinctStr = "DISTINCT ";
            }
            sqlPartString = sqlPartString.substring(index);
        }
        pagingBuilder.append(sqlPartString);
        if (StringUtils.isBlank(orderby)) {
            orderby = "ORDER BY CURRENT_TIMESTAMP";
        }
        long firstParam = offset + 1;
        long secondParam = offset + limit;
        String sql = "WITH selectTemp AS (SELECT " + distinctStr + "TOP 100 PERCENT " +
            " ROW_NUMBER() OVER (" + orderby + ") as __row_number__, " + pagingBuilder +
            ") SELECT * FROM selectTemp WHERE __row_number__ BETWEEN " +
            //FIX#299：原因：mysql中limit 10(offset,size) 是从第10开始（不包含10）,；而这里用的BETWEEN是两边都包含，所以改为offset+1
            firstParam + " AND " + secondParam + " ORDER BY __row_number__";
        return sql;
    }
}
