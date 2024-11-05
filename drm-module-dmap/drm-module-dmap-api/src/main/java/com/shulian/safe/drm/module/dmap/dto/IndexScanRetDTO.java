package com.shulian.safe.drm.module.dmap.dto;

import com.shulian.safe.drm.framework.common.core.KeyValue;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/29 14:31
 * @version: V1.0
 */
@Data
@Schema(description = "资产视图-任务扫描数据")
@AllArgsConstructor
@NoArgsConstructor
public class IndexScanRetDTO implements Serializable {

    @Schema(description = "总扫描的IP数")
    private Long ipCount;

    @Schema(description = "扫描数据服务数")
    private Long dataServiceCount;

    @Schema(description = "各个IP内的数据服务数")
    private List<KeyValue<String,String>> hostList;
}
