package com.shulian.safe.drm.module.dmap.dynamicds.executor;

import com.google.common.collect.Lists;
import com.google.common.primitives.Ints;
import com.shulian.safe.drm.framework.common.exception.ServiceException;
import com.shulian.safe.drm.module.dmap.dynamicds.datasource.IDataSourceManager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 执行器
 * </p>
 *
 */
@Slf4j
@Component
public class BasicSqlExecutor implements ISqlExecutor {

    /** IDataSourceManager */
    @Autowired
    private IDataSourceManager dataSourceManager;


    @Override
    public Long updateSqlRetId(String databaseId, String sql, Object[] params) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);

        KeyHolder holder = new GeneratedKeyHolder();
        jdbcTemplate.update(con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            log.info("updateSql:{}", ps);
            return ps;
        }, holder);

        Number key = holder.getKey();
        return key == null ? null : key.longValue();
    }

    @Override
    public Integer updateSql(String databaseId, String sql, Object[] params) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        return jdbcTemplate.update(sql, params);
    }

    @Override
    public void updateSql(String databaseId, String sql) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        jdbcTemplate.update(sql);
    }

    @Override
    public void executeSql(String databaseId, String sql) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        jdbcTemplate.execute(sql);
    }

    @Override
    public Integer queryForInt(String databaseId, String sql, Object[] params) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        return jdbcTemplate.queryForObject(sql, params, Integer.class);
    }

    @Override
    public Map<String, Object> queryForMap(String databaseId, String sql, Object[] params) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        return jdbcTemplate.queryForMap(sql, params);
    }

    @Override
    public Map<String, Object> queryForOne(String databaseId, String sql, Object[] params) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, params);
        if (list.size() > 1) {
            throw new ServiceException(500, "Incorrect result size: expected 1 or empty, actual greater than 1");
        }
        if (list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    @Override
    public <T> T queryForOne(String databaseId, String sql, Object[] params, Class<T> elementType) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        List<T> list = jdbcTemplate.query(sql, params, new BeanPropertyRowMapper<T>(elementType));
        if (list.size() > 1) {
            throw new ServiceException(500,"Incorrect result size: expected 1 or empty, actual greater than 1");
        }
        if (list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    @Override
    public <T> List<T> queryForList(String databaseId, String sql, Object[] params, Class<T> elementType) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        List<T> list = jdbcTemplate.query(sql, params, new BeanPropertyRowMapper<T>(elementType));
        return list;
    }

    @Override
    public <T> List<T> queryForList(String databaseId, String sql, Map<String, Object> params, Class<T> elementType) {
        NamedParameterJdbcTemplate namedJdbcTemplate = dataSourceManager.getNamedParameterJdbcTemplate(databaseId);
        List<T> list = namedJdbcTemplate.query(sql, params, new BeanPropertyRowMapper<T>(elementType));
        return list;
    }

    @Override
    public <T> List<T> query(String databaseId, String sql, RowMapper<T> rowMapper) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        List<T> list = jdbcTemplate.query(sql, rowMapper);
        return list;
    }

    @Override
    public <T> List<T> queryForList(String databaseId, String sql, Class<T> elementType) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        List<T> list = jdbcTemplate.queryForList(sql, elementType);
        return list;
    }

    @Override
    public List<Map<String, Object>> queryForList(String databaseId, String sql, Object[] params) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, params);
        return list;
    }


    @Override
    public List<Integer> batchUpdate(String databaseId, String sql, List<Object[]> paramsList) {
        JdbcTemplate jdbcTemplate = dataSourceManager.getJdbcTemplate(databaseId);
        int[] ints = jdbcTemplate.batchUpdate(sql, paramsList);
        List<Integer> ret = Lists.newArrayList(Ints.asList(ints));
        return ret;
    }
}