package com.shulian.safe.drm.framework.mybatis.core.dataobject;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fhs.core.trans.vo.TransPojo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.JdbcType;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 和 DO 区别：去重逻辑删除；创建人和修改人修改为用户名；
 *
 * @company:
 * @author: WF
 * @date: 2024/9/12 14:48
 * @version: V1.0
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@JsonIgnoreProperties(value = "transMap") // 由于 Easy-Trans 会添加 transMap 属性，避免 Jackson 在 Spring Cache 反序列化报错
public class BaseEntity implements Serializable, TransPojo {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 自动填充，创建者；entity 使用登录用户名；BO 使用用户表 ID
     * <p>
     * 使用 String 类型的原因是，未来可能会存在非数值的情况，留好拓展性。
     */
    @Schema(description = "创建人", example = "zhangsan")
    @TableField(fill = FieldFill.INSERT, jdbcType = JdbcType.VARCHAR)
    private String creator;

    @Schema(description = "部门", example = " 001")
    @TableField(fill = FieldFill.INSERT)
    private Long deptId;

    /**
     * 自动填充，创建时间
     */
    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 自动填充，更新者；entity 使用登录用户名；BO 使用用户表 ID
     * <p>
     * 使用 String 类型的原因是，未来可能会存在非数值的情况，留好拓展性。
     */
    @Schema(description = "更新人", example = "zhangsan")
    @TableField(fill = FieldFill.INSERT_UPDATE, jdbcType = JdbcType.VARCHAR)
    private String updater;
    /**
     * 最后更新时间
     */
    @Schema(description = "更新时间", example = "2024-09-18 16:00:38")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    /**
     * 是否删除
     */
    private Boolean deleted;

}