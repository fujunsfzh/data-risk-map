package com.shulian.safe.drm.module.dmap.dto.mark;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/23 14:05
 * @version: V1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "推荐的标签DTO")
public class MarkAutoTagDTO implements Serializable {

    private static final long serialVersionUID = -1974095735804124225L;

    @Schema(description = "标签id", example = "100")
    private Long tagId;

    @Schema(description = "标签编码", example = "标签编码")
    private String tagCode;

    @Schema(description = "标签名称", example = "标签名称")
    private String tagName;

    @Schema(description = "命中率", example = "100")
    private BigDecimal ratio;
}
