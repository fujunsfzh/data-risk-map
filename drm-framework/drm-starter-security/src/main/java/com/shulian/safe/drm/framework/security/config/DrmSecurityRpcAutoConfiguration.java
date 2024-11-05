package com.shulian.safe.drm.framework.security.config;

import com.shulian.safe.drm.framework.security.core.rpc.LoginUserRequestInterceptor;
import com.shulian.safe.drm.module.system.api.oauth2.OAuth2TokenApi;
import com.shulian.safe.drm.module.system.api.permission.PermissionApi;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;

/**
 * Security 使用到 Feign 的配置项
 *
 * @author 系统源码
 */
@AutoConfiguration
@EnableFeignClients(clients = {OAuth2TokenApi.class, // 主要是引入相关的 API 服务
        PermissionApi.class})
public class DrmSecurityRpcAutoConfiguration {

    @Bean
    public LoginUserRequestInterceptor loginUserRequestInterceptor() {
        return new LoginUserRequestInterceptor();
    }

}
