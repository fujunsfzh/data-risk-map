package com.shulian.safe.drm.module.dmap.entity.scan;

import com.baomidou.mybatisplus.annotation.TableName;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:16
 * @version: V1.0
 */
@TableName(value = "sc_task")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "探查 - 任务实体")
public class ScTaskEntity extends BaseEntity {

    @Schema(description = "name", requiredMode = Schema.RequiredMode.REQUIRED, example = "探查开发网段")
    private String name;

    @Schema(description = "ip", example = "10.0.3.1/24")
    private String ip;

    @Schema(description = "端口", example = "80,443,3306-3310")
    private String port;

    @Schema(description = "执行模式 1-单次，2-cron", example = "2")
    private Integer type;

    @Schema(description = "cron表达式", example = "0/5 * * * * ?")
    private String cron;

    @Schema(description = "任务状态 1：正常，2：暂停", example = "")
    private Integer status;

    @Schema(description = "周期任务生效时间", example = "2024-09-12 16:20:00")
    private LocalDateTime triggerStartTime;

    @Schema(description = "周期任务生效时间", example = "2025-09-12 16:20:00")
    private LocalDateTime triggerEndTime;

    @Schema(description = "重试次数", example = "1")
    private Integer retryCount;

    @Schema(description = "重试间隔/秒", example = "10")
    private Integer retryInterval;


    //===============================================================

}

