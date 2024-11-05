package com.shulian.safe.drm.module.dmap.entity.meta;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:30
 * @version: V1.0
 */
@TableName(value = "ds_meta_table")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "资产-数据表实体")
public class MetaTableEntity extends BaseEntity {

    @Schema(description = "数据源Id", example = "123")
    private Long dbId;

    @Schema(description = "表类型 1-表，2-视图", example = "1")
    private Integer type;

    @Schema(description = "表名", example = "user_info")
    private String tableName;

    @Schema(description = "表中文名", example = "用户表")
    private String tableNameZh;

    @Schema(description = "数据条数", example = "1234")
    private  Long count;

    @Schema(description = "版本号", example = "1")
    private String version;

    @TableField(exist = false)
    private Integer maxVersion;
}
