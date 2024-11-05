package com.shulian.safe.drm.module.dmap.dto;

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
 * @date: 2024/9/27 14:53
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "数据库类型详情")
public class IndexDbTypeInfoDTO implements Serializable {

    @Schema(description = "数据库类型")
    private String type;

    @Schema(description = "数据库主机")
    private String dbHost;

    @Schema(description = "数据库端口")
    private Integer dbPort;

    @Schema(description = "数据库个数")
    private Long dbCount;

    @Schema(description = "数据表个数")
    private Long tbCount;

    @Schema(description = "字段个数")
    private Long coCount;

}
