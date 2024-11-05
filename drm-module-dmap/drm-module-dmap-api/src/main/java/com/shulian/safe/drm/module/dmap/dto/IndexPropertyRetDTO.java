package com.shulian.safe.drm.module.dmap.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 10:46
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "资产分布")
public class IndexPropertyRetDTO implements java.io.Serializable {

    @Schema(description = "数据源数量")
    private Long dsCount;

    @Schema(description = "数据库数量")
    private Long dbCount;

    @Schema(description = "数据表数量")
    private Long tbCount;

    @Schema(description = "字段数量")
    private Long coCount;
}
