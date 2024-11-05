package com.shulian.safe.drm.module.dmap.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 10:17
 * @version: V1.0
 */
@Data
@Schema(description = "资产视图-资产总数")
@AllArgsConstructor
@NoArgsConstructor
public class IndexTotalRetDTO implements Serializable {

    @Schema(description = "资产总数据量")
    private Long total;

    @Deprecated
    @Schema(description = "资产总数据量大小,暂时不用")
    private String size;
}
