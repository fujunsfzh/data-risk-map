package com.shulian.safe.drm.module.dmap.dynamicds.executor;

import org.springframework.jdbc.core.RowMapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * SQL执行器
 * </p>
 */
public interface ISqlExecutor {

    /**
     * 执行SQL(insert,update,delete)
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     */
    Long updateSqlRetId(String databaseId, String sql, Object[] params);

    /**
     * 执行SQL(insert,update,delete)
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     */
    Integer updateSql(String databaseId, String sql, Object[] params);

    /**
     * 执行SQL(insert,update,delete)
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     */
    void updateSql(String databaseId, String sql);

    /**
     * 执行SQL(DDL)
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     */
    void executeSql(String databaseId, String sql);

    /**
     * 执行SQL
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     */
    Integer queryForInt(String databaseId, String sql, Object[] params);

    /**
     * 执行SQL
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     */
    Map<String, Object> queryForMap(String databaseId, String sql, Object[] params);

    /**
     * 执行SQL, 查询唯一一条结果, 没有返回null, 大于一条抛异常
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     * @return Map<String, Object>
     */
    Map<String, Object> queryForOne(String databaseId, String sql, Object[] params);

    /**
     * 执行SQL, 查询唯一一条结果, 没有返回null, 大于一条抛异常
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     * @return T
     */
    <T> T queryForOne(String databaseId, String sql, Object[] params, Class<T> elementType);

    /**
     * 执行SQL, list
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     * @return List
     */
    <T> List<T> queryForList(String databaseId, String sql, Object[] params, Class<T> elementType);

    /**
     * 执行SQL, list
     *
     * @param databaseId  数据集群ID
     * @param sql         SQL
     * @param params      参数
     * @param elementType 返回类型
     * @return List
     */
    <T> List<T> queryForList(String databaseId, String sql, Map<String, Object> params, Class<T> elementType);

    /**
     * 执行SQL, list
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param rowMapper  参数
     * @return List
     */
    <T> List<T> query(String databaseId, String sql, RowMapper<T> rowMapper);

    /**
     * 执行SQL, list<Map<String,object>>
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param params     参数
     * @return List
     */
    List<Map<String, Object>> queryForList(String databaseId, String sql, Object[] params);


    /**
     * 执行SQL, list<基本类型>
     *
     * @param databaseId  数据集群ID
     * @param sql         SQL
     * @param elementType 基本类型
     * @param <T>
     * @return
     */
    <T> List<T> queryForList(String databaseId, String sql, Class<T> elementType);

    /**
     * 批量操作
     *
     * @param databaseId 数据集群ID
     * @param sql        SQL
     * @param paramsList 参数
     * @return
     */
    List<Integer> batchUpdate(String databaseId, String sql, List<Object[]> paramsList);


}