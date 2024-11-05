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
 * @date: 2024/10/23 14:09
 * @version: V1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "打标数据样本DTO")
public class MarkDataSampleDTO implements Serializable {

    private static final long serialVersionUID = -1974095735804124225L;

    @Schema(description = "样本主键",example = " 100")
    private Long id;

    @Schema(description = "数据样本",example = "数据样本")
    private String dataSample;
}
