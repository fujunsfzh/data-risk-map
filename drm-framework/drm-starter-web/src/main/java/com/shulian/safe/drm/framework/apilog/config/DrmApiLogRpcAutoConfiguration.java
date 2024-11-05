package com.shulian.safe.drm.framework.apilog.config;

import com.shulian.safe.drm.module.system.api.logger.ApiAccessLogApi;
import com.shulian.safe.drm.module.system.api.logger.ApiErrorLogApi;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * API 日志使用到 Feign 的配置项
 *
 * @author 系统源码
 */
@AutoConfiguration
@EnableFeignClients(clients = {ApiAccessLogApi.class, // 主要是引入相关的 API 服务
        ApiErrorLogApi.class})
public class DrmApiLogRpcAutoConfiguration {
}
