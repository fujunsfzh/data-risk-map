package com.shulian.safe.drm.module.dmap.config;

import com.shulian.safe.drm.framework.security.config.AuthorizeRequestsCustomizer;
import com.shulian.safe.drm.module.system.enums.ApiConstants;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;

/**
 * 业务模块的 Security 配置
 */
@Configuration(proxyBeanMethods = false, value = "dmapSecurityConfiguration")
public class SecurityConfiguration {

    @Bean("dmapAuthorizeRequestsCustomizer")
    public AuthorizeRequestsCustomizer authorizeRequestsCustomizer() {
        return new AuthorizeRequestsCustomizer() {

            @Override
            public void customize(ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry) {
                // Swagger 接口文档
                registry.antMatchers("/v3/api-docs/**").permitAll()
                        .antMatchers("/webjars/**").permitAll()
                        .antMatchers("/swagger-ui").permitAll()
                        .antMatchers("/swagger-ui/**").permitAll();

                // // Spring Boot Actuator 的安全配置
                // registry.antMatchers("/actuator").permitAll()
                //         .antMatchers("/actuator/**").permitAll();

                // Druid 监控
                registry.antMatchers("/druid/**").permitAll();

                // RPC 服务的安全配置
                registry.antMatchers(ApiConstants.PREFIX + "/**").permitAll();
            }

        };
    }

}
