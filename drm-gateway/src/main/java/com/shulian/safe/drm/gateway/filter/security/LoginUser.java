package com.shulian.safe.drm.gateway.filter.security;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 登录用户信息
 *
 * copy from drm-spring-boot-starter-security 的 LoginUser 类
 *
 * @author 系统源码
 */
@Data
public class LoginUser {

    /**
     * 用户编号
     */
    private Long id;
    /**
     * 用户类型
     */
    private Integer userType;

    /**
     * 在 info 里有，提到外层方便获取
     */
    private String userName;
    /**
     * 在 info 里有，提到外层方便获取
     */
    private Long deptId;

    /**
     * 额外的用户信息 {"nickname":"admin","deptId":"103","username":"系统源码"}
     */
    private Map<String, String> info;
    /**
     * 租户编号
     */
    private Long tenantId;
    /**
     * 授权范围
     */
    private List<String> scopes;
    /**
     * 过期时间
     */
    private LocalDateTime expiresTime;

}
