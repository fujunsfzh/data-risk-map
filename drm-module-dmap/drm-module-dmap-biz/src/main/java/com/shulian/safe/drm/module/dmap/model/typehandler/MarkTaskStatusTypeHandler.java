package com.shulian.safe.drm.module.dmap.model.typehandler;

import com.shulian.safe.drm.module.dmap.enums.MarkTaskStatusEnum;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 打标任务状态枚举类型处理器
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/12 17:21
 * @version: V1.0
 */
@MappedJdbcTypes(JdbcType.INTEGER)
@MappedTypes(MarkTaskStatusEnum.class)
public class MarkTaskStatusTypeHandler extends BaseTypeHandler<MarkTaskStatusEnum> {
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, MarkTaskStatusEnum parameter, JdbcType jdbcType) throws SQLException {
        ps.setInt(i, parameter.getValue());
    }

    @Override
    public MarkTaskStatusEnum getNullableResult(ResultSet rs, String columnName) throws SQLException {
        int value = rs.getInt(columnName);
        MarkTaskStatusEnum instance = MarkTaskStatusEnum.getByValue(value);
        return instance;
    }

    @Override
    public MarkTaskStatusEnum getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        int value = rs.getInt(columnIndex);
        MarkTaskStatusEnum instance = MarkTaskStatusEnum.getByValue(value);
        return instance;
    }

    @Override
    public MarkTaskStatusEnum getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return null;
    }
}
