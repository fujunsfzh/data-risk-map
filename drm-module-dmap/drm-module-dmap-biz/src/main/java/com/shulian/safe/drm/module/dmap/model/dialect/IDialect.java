package com.shulian.safe.drm.module.dmap.model.dialect;

/**
 * 数据库方言
 *
 * @author ZJW
 */
public interface IDialect {

    /**
     * 组装分页语句
     *
     * @param originalSql 原始语句
     * @param offset      偏移量
     * @param limit       界限
     * @return 分页模型
     */
    String buildPaginationSql(String originalSql, long offset, long limit);

    /**
     * 数据库本身是否支持分页查询方式
     * 如果数据库不支持的话，则不进行数据库分页
     *
     * @return true：支持当前的分页查询方式
     */
    default boolean supportsPagination() {
        return true;
    }

    /**
     * 构建查询语句
     *
     * @param tableName 表名称
     * @return
     */
    default String buildAllSql(String tableName) {
        return "select * from " + tableName;
    }

    /**
     * 构建查询语句
     *
     * @param tableName 表名称
     * @param column    列
     * @return
     */
    default String buildColumnsSql(String tableName, String column) {
        return "select " + column + " from " + tableName;
    }


    /**
     * 构建查询总量语句
     *
     * @param tableName 表名称
     * @return
     */
    default String buildCountSql(String tableName) {
        return "select count(*) as total from " + tableName;
    }

}
