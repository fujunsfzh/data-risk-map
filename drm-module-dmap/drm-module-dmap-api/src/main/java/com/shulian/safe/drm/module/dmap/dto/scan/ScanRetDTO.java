package com.shulian.safe.drm.module.dmap.dto.scan;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: WF
 * @date: 2024/7/31 18:31
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "扫描概况")
public class ScanRetDTO implements Serializable {

    private static final long serialVersionUID = -4136112900909006201L;

    /**
     * 扫描的 ip 数
     */
    @Schema(description = "扫描的 ip 数")
    private Integer ipCount;
    /**
     * 扫描的主机数
     */
    @Schema(description = "扫描的主机数")
    private Integer hostsCount;
    /**
     * 扫描耗时
     */
    @Schema(description = "扫描耗时")
    private String takeTime;

    @Schema(description = "扫描结果")
    private List<ScanInfoDTO> scanInfoList;

    public List<ScanInfoDTO> getScanInfoList() {
        return scanInfoList == null ? new ArrayList<>() : scanInfoList;
    }
}
