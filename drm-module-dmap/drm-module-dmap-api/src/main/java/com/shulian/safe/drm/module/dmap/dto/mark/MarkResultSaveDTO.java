package com.shulian.safe.drm.module.dmap.dto.mark;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/24 15:34
 * @version: V1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "打标结果保存DTO")
public class MarkResultSaveDTO implements Serializable {

    @NotNull
    @Schema(description = "任务主键", example = "100")
    private Long taskId;

    @NotNull
    @Schema(description = "数据表id", example = "100")
    private Long tableId;

    @NotEmpty
    private List<MarkAutoResultRetDTO> dataList;
}
