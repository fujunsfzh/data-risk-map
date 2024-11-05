package com.shulian.safe.drm.module.system.enums.job;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 任务日志的状态枚举
 *
 * @author 系统源码
 */
@Getter
@AllArgsConstructor
public enum JobLogStatusEnum {

    RUNNING(0), // 运行中
    SUCCESS(1), // 成功
    FAILURE(2); // 失败

    /**
     * 状态
     */
    private final Integer status;

}
