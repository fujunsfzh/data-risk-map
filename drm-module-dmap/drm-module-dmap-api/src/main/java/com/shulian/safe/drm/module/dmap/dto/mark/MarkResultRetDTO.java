package com.shulian.safe.drm.module.dmap.dto.mark;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/24 14:50
 * @version: V1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "打标结果返回DTO")
public class MarkResultRetDTO implements Serializable {

    private static final long serialVersionUID = -5636676307662768797L;

    private Long id;

    @Schema(description = "任务主键", example = "100")
    private Long taskId;

    @Schema(description = "数据源id", example = "100")
    private Long dbId;

    @Schema(description = "数据源名称", example = "数据源名称")
    private String dbName;

    @Schema(description = "数据表主键", example = "100")
    private Long tableId;

    @Schema(description = "数据表名称", example = "数据表名称")
    private String tableName;

    @Schema(description = "字段主键", example = "100")
    private Long colId;

    @Schema(description = "字段名称", example = "字段名称")
    private String colName;

    @Schema(description = "标签id", example = "100")
    private Long tagId;

    @Schema(description = "标签名称", example = "标签名称")
    private String tagName;

    @Schema(description = "版本", example = "100")
    private String version;
}
