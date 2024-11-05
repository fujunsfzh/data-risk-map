package com.shulian.safe.drm.module.dmap.dto.mark;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/23 14:00
 * @version: V1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "打标待确认结果返回DTO")
public class MarkAutoResultRetDTO implements Serializable {

    // @Schema(description = "result表主键", example = "100")
    // private Long id;
    //
    // @Schema(description = "auto表主键", example = "100")
    // private Long autoId;

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

    @Schema(description = "字段名称", example = "字段名称")
    private String colNameZh;

    @Schema(description = "列类型", example = "varchar")
    private String dataType;

    @Schema(description = "列长度", example = "100")
    private Integer dataLength;

    @Schema(description = "标签", example = "100")
    private Long tagId;

    @Schema(description = "推荐标签", example = "[]")
    private List<MarkAutoTagDTO> markTagList;

    @Schema(description = "数据样本", example = "[]")
    private List<MarkDataSampleDTO> markDataSampleList;
}
