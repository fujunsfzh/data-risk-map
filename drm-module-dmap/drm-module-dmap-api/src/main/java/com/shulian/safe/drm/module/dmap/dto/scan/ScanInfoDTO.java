package com.shulian.safe.drm.module.dmap.dto.scan;

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
 * @date: 2024/9/18 11:58
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "扫描结果")
public class ScanInfoDTO {

    @Schema(description = "主机")
    private String ip;

    @Schema(description = "端口")
    private String port;

    @Schema(description = "开放状态")
    private String openStatus;

    @Schema(description = "服务名称")
    private String serverName;
}
