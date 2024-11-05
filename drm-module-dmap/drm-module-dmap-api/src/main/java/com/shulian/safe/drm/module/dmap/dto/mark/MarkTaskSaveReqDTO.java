package com.shulian.safe.drm.module.dmap.dto.mark;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.io.Serializable;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/12 16:08
 * @version: V1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "打标任务保存DTO")
public class MarkTaskSaveReqDTO implements Serializable {

    private static final long serialVersionUID = 4266034565246596892L;

    @Schema(description = "主键", example = "100")
    private Long id;

    @NonNull
    @Min(1)
    @Max(2)
    @Schema(description = "1-敏感扫描 2-分类分级", example = "1")
    private Integer taskType;

    @NonNull
    @Schema(description = "数据源id", example = "100")
    private Long dbId;

    @NonNull
    @Schema(description = "标签组id 敏感扫描用", example = "100")
    private Long tagGroupId;

    @NonNull
    @Schema(description = "行业Id 分类分级用", example = "100")
    private Long industrialId;

    @NonNull
    @Schema(description = "抽取行数 -1-全量，其他抽取指定行数", example = "200")
    private Long scanNum;
}
