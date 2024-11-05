package com.shulian.safe.drm.module.dmap.dto.scan;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/18 15:58
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "探查任务详情DTO")
public class ScTaskInfoDTO {

    private Long id;

    @Schema(description = "name", requiredMode = Schema.RequiredMode.REQUIRED, example = "探查开发网段任务")
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


    @Schema(description = "创建人", example = "zhangsan")
    private String creator;

    @Schema(description = "部门", example = " 001")
    private Long deptId;

    /**
     * 自动填充，创建时间
     */
    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    private LocalDateTime createTime;

    /**
     * 自动填充，更新者；entity 使用登录用户名；BO 使用用户表 ID
     * <p>
     * 使用 String 类型的原因是，未来可能会存在非数值的情况，留好拓展性。
     */
    @Schema(description = "更新人", example = "zhangsan")
    private String updater;
    /**
     * 最后更新时间
     */
    @Schema(description = "更新时间", example = "2024-09-18 16:00:38")
    private LocalDateTime updateTime;

    @Schema(description = "后续五次的执行时间", example = "[]")
    private List<LocalDateTime> nextFiveTime;

    public List<LocalDateTime> getNextFiveTime() {
        return nextFiveTime != null ? nextFiveTime : new ArrayList<>();
    }
}
