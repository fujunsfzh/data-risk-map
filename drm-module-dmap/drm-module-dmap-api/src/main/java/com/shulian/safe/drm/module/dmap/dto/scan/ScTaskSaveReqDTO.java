package com.shulian.safe.drm.module.dmap.dto.scan;

import com.mzt.logapi.starter.annotation.DiffLogField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:41
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "探查任务创建/修改 DTO")
public class ScTaskSaveReqDTO implements Serializable {

    private static final long serialVersionUID = -4449726597250458810L;

    @Schema(description = "主键", example = "100")
    private Long id;

    @Schema(description = "任务名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "探查开发网段")
    @NotBlank(message = "任务名称不可为空")
    @DiffLogField(name = "任务名称")
    private String name;

    @Schema(description = "ip", requiredMode = Schema.RequiredMode.REQUIRED, example = "10.0.3.1/24")
    @NotBlank(message = "探查范围不可为空")
    @DiffLogField(name = "探查范围")
    private String ip;

    // @Schema(description = "端口", requiredMode = Schema.RequiredMode.REQUIRED, example = "80,443,3306-3310")
    // @NotBlank(message = "探查端口不可为空")
    @Schema(description = "探查端口", example = "80,443,3306-3310")
    @DiffLogField(name = "探查端口")
    private String port;

    @Schema(description = "执行模式 1-单次，2-cron", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotNull(message = "探查模式不可为空")
    @DiffLogField(name = "执行模式")
    private Integer type;

    @Schema(description = "cron表达式", example = "0/5 * * * * ?")
    @DiffLogField(name = "cron表达式")
    private String cron;

    @Schema(description = "任务状态 1：正常，2：暂停", example = "")
    @DiffLogField(name = "任务状态")
    private Integer status;

    @Schema(description = "周期任务生效时间", example = "2024-09-12 16:20:00")
    @DiffLogField(name = "周期任务生效时间")
    private LocalDateTime triggerStartTime;

    @Schema(description = "周期任务失效时间", example = "2025-09-12 16:20:00")
    @DiffLogField(name = "周期任务失效时间")
    private LocalDateTime triggerEndTime;

    @Schema(description = "重试最大次数", example = "1")
    @NotNull(message = "重试最大次数不可为空")
    @DiffLogField(name = "重试最大次数")
    private Integer retryCount;

    @Schema(description = "重试间隔/秒", example = "10")
    @NotNull(message = "重试间隔不可为空")
    @DiffLogField(name = "重试间隔")
    private Integer retryInterval;

}
