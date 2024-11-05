package com.shulian.safe.drm.module.dmap.entity.scan;

import com.baomidou.mybatisplus.annotation.TableName;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
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
 * @date: 2024/9/12 16:16
 * @version: V1.0
 */
@TableName(value = "sc_task_instance")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "探查 - 任务实例")
public class ScTaskInstanceEntity extends BaseEntity {


    @Schema(description = "任务id", example = "100")
    private Long taskId;

    @Schema(description = "实例id", example = "386d95240c46bf78d7ea1658f2283c96")
    private String instanceId;

    @Schema(description = "任务执行状态 1：未执行，2：执行中，3：执行结束（成功）4，执行结束（失败）", example = "")
    private Integer exeStatus;

    @Schema(description = "发现ip数量", example = "256")
    private Integer ipCount;

    @Schema(description = "发现主机数量", example = "100")
    private Integer hostsCount;

    @Schema(description = "耗时/秒", example = "513.16")
    private String takeTime;
}

