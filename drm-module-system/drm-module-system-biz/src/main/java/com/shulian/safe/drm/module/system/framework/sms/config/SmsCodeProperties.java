package com.shulian.safe.drm.module.system.framework.sms.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

import java.time.Duration;

@ConfigurationProperties(prefix = "drm.sms-code")
@Validated
@Data
public class SmsCodeProperties {

    /**
     * 过期时间
     */
    // fixme 去除启动校验
    // @NotNull(message = "过期时间不能为空")
    private Duration expireTimes;
    /**
     * 短信发送频率
     */
    // fixme 去除启动校验
    // @NotNull(message = "短信发送频率不能为空")
    private Duration sendFrequency;
    /**
     * 每日发送最大数量
     */
    // fixme 去除启动校验
    // @NotNull(message = "每日发送最大数量不能为空")
    private Integer sendMaximumQuantityPerDay;
    /**
     * 验证码最小值
     */
    // fixme 去除启动校验
    // @NotNull(message = "验证码最小值不能为空")
    private Integer beginCode;
    /**
     * 验证码最大值
     */
    // fixme 去除启动校验
    // @NotNull(message = "验证码最大值不能为空")
    private Integer endCode;

}
