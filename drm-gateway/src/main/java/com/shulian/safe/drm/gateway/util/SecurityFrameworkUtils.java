package com.shulian.safe.drm.gateway.util;

import cn.hutool.core.map.MapUtil;
import com.shulian.safe.drm.framework.common.contants.GlobalConstants;
import com.shulian.safe.drm.framework.common.util.json.JsonUtils;
import com.shulian.safe.drm.gateway.filter.security.LoginUser;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ServerWebExchange;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 安全服务工具类
 * <p>
 * copy from drm-spring-boot-starter-security 的 SecurityFrameworkUtils 类
 *
 * @author 系统源码
 */
@Slf4j
public class SecurityFrameworkUtils {

    private static final String AUTHORIZATION_HEADER = "Authorization";

    private static final String AUTHORIZATION_BEARER = "Bearer";

    private SecurityFrameworkUtils() {
    }

    /**
     * 从请求中，获得认证 Token
     *
     * @param exchange 请求
     * @return 认证 Token
     */
    public static String obtainAuthorization(ServerWebExchange exchange) {
        String authorization = exchange.getRequest().getHeaders().getFirst(AUTHORIZATION_HEADER);
        if (!StringUtils.hasText(authorization)) {
            return null;
        }
        int index = authorization.indexOf(AUTHORIZATION_BEARER + " ");
        if (index == -1) { // 未找到
            return null;
        }
        return authorization.substring(index + 7).trim();
    }

    /**
     * 设置登录用户
     *
     * @param exchange 请求
     * @param user     用户
     */
    public static void setLoginUser(ServerWebExchange exchange, LoginUser user) {
        exchange.getAttributes().put(GlobalConstants.LOGIN_USER_ID_ATTR, user.getId());
        exchange.getAttributes().put(GlobalConstants.LOGIN_USER_TYPE_ATTR, user.getUserType());
        exchange.getAttributes().put(GlobalConstants.LOGIN_USERNAME_ATTR, user.getUserName());
        exchange.getAttributes().put(GlobalConstants.LOGIN_USER_DEPT_ID_ATTR, user.getDeptId());
    }

    /**
     * 移除请求头的用户
     *
     * @param exchange 请求
     * @return 请求
     */
    public static ServerWebExchange removeLoginUser(ServerWebExchange exchange) {
        // 如果不包含，直接返回
        if (!exchange.getRequest().getHeaders().containsKey(GlobalConstants.LOGIN_USER_HEADER)) {
            return exchange;
        }
        // 如果包含，则移除。参考 RemoveRequestHeaderGatewayFilterFactory 实现
        ServerHttpRequest request = exchange.getRequest().mutate()
                .headers(httpHeaders -> httpHeaders.remove(GlobalConstants.LOGIN_USER_HEADER)).build();
        return exchange.mutate().request(request).build();
    }

    /**
     * 获得登录用户的编号
     *
     * @param exchange 请求
     * @return 用户编号
     */
    public static Long getLoginUserId(ServerWebExchange exchange) {
        return MapUtil.getLong(exchange.getAttributes(), GlobalConstants.LOGIN_USER_ID_ATTR);
    }

    /**
     * 获得登录用户的类型
     *
     * @param exchange 请求
     * @return 用户类型
     */
    public static Integer getLoginUserType(ServerWebExchange exchange) {
        return MapUtil.getInt(exchange.getAttributes(), GlobalConstants.LOGIN_USER_TYPE_ATTR);
    }

    /**
     * 获得登录用户的类型
     *
     * @param exchange 请求
     * @return 用户类型
     */
    public static String getLoginUseName(ServerWebExchange exchange) {
        return MapUtil.getStr(exchange.getAttributes(), GlobalConstants.LOGIN_USERNAME_ATTR);
    }

    /**
     * 将 user 并设置到 login-user 的请求头，使用 json 存储值
     *
     * @param builder 请求
     * @param user    用户
     */
    @SneakyThrows
    public static void setLoginUserHeader(ServerHttpRequest.Builder builder, LoginUser user) {
        try {
            String userStr = JsonUtils.toJsonString(user);
            userStr = URLEncoder.encode(userStr, StandardCharsets.UTF_8.name()); // 编码，避免中文乱码
            builder.header(GlobalConstants.LOGIN_USER_HEADER, userStr);
        } catch (Exception ex) {
            log.error("[setLoginUserHeader][序列化 user({}) 发生异常]", user, ex);
            throw ex;
        }
    }

    /**
     * 设置请求 ID
     *
     * @param builder
     */
    public static void setRequestIdHeader(ServerHttpRequest.Builder builder, String requestId) {
        builder.header(GlobalConstants.X_REQUEST_ID, requestId);
    }

}
