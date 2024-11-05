package com.shulian.safe.drm.framework.web.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;

@ConfigurationProperties(prefix = "drm.web")
@Validated
@Data
public class WebProperties {

    // @NotNull(message = "APP API 不能为空")
    // private Api appApi = new Api("/app-api", "**.controller.app.**");
    // @NotNull(message = "Admin API 不能为空")
    // private Api adminApi = new Api("/admin-api", "**.controller.admin.**");

    // fixme 去除启动校验
    // @NotNull(message = "Admin UI 不能为空")
    private Ui adminUi;

    /**
     * api 二级服务名称前缀,网关用于区分代理服务
     * system 服务在每个 api 中都添加了服务名前缀,dmap 开始抽取服务名在这里统一配置
     */
    private String secondServiceNamePrefix;

    public Api getAppApi() {
        String prefix = "/app-api";
        if (StringUtils.isNotBlank(secondServiceNamePrefix)) {
            prefix += "/" + secondServiceNamePrefix;
        }
        return new Api(prefix, "**.controller.app.**");
    }


    public Api getAdminApi() {
        String prefix = "/admin-api";
        if (StringUtils.isNotBlank(secondServiceNamePrefix)) {
            prefix += "/" + secondServiceNamePrefix;
        }
        return new Api(prefix, "**.controller.admin.**");
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Valid
    public static class Api {

        /**
         * API 前缀，实现所有 Controller 提供的 RESTFul API 的统一前缀
         * <p>
         * <p>
         * 意义：通过该前缀，避免 Swagger、Actuator 意外通过 Nginx 暴露出来给外部，带来安全性问题
         * 这样，Nginx 只需要配置转发到 /api/* 的所有接口即可。
         *
         * @see DrmWebAutoConfiguration#configurePathMatch(PathMatchConfigurer)
         */
        @NotEmpty(message = "API 前缀不能为空")
        private String prefix;

        /**
         * Controller 所在包的 Ant 路径规则
         * <p>
         * 主要目的是，给该 Controller 设置指定的 {@link #prefix}
         */
        @NotEmpty(message = "Controller 所在包不能为空")
        private String controller;

    }

    @Data
    @Valid
    public static class Ui {

        /**
         * 访问地址
         */
        private String url;

    }

}
