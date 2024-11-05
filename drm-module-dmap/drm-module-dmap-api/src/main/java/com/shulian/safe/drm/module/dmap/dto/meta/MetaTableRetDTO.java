package com.shulian.safe.drm.module.dmap.dto.meta;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/26 11:01
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "数据表返回实体")
public class MetaTableRetDTO implements Serializable {

    @Schema(description = "数据源Id", example = "123")
    private Long dbId;

    @Schema(description = "数据源名称", example = "数据源名称")
    private String dbName;

    @Schema(description = "表类型 1-表，2-视图", example = "1")
    private Integer type;

    @Schema(description = "表名", example = "user_info")
    private String tableName;

    @Schema(description = "表中文名", example = "用户表")
    private String tableNameZh;

    @Schema(description = "数据条数", example = "1234")
    private Long count;

    @Schema(description = "版本号", example = "1")
    private String version;

    @Schema(description = "主键", example = "123")
    private Long id;

    @Schema(description = "创建人", example = "zhangsan")
    private String creator;

    @Schema(description = "部门", example = " 001")
    private Long deptId;

    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    private LocalDateTime createTime;

    @Schema(description = "更新人", example = "zhangsan")
    private String updater;

    @Schema(description = "更新时间", example = "2024-09-18 16:00:38")
    private LocalDateTime updateTime;
}
