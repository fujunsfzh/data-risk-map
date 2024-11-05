package com.shulian.safe.drm.framework.web.core.util;

import cn.hutool.core.util.NumberUtil;
import com.shulian.safe.drm.framework.common.contants.GlobalConstants;
import com.shulian.safe.drm.framework.common.enums.RpcConstants;
import com.shulian.safe.drm.framework.common.enums.TerminalEnum;
import com.shulian.safe.drm.framework.common.enums.UserTypeEnum;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.web.config.WebProperties;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

/**
 * 专属于 web 包的工具类
 *
 * @author 系统源码
 */
public class WebFrameworkUtils {

    private static final String REQUEST_ATTRIBUTE_COMMON_RESULT = "common_result";

    public static final String HEADER_TENANT_ID = "tenant-id";

    /**
     * 终端的 Header
     *
     * @see com.shulian.safe.drm.framework.common.enums.TerminalEnum
     */
    public static final String HEADER_TERMINAL = "terminal";

    private static WebProperties properties;

    public WebFrameworkUtils(WebProperties webProperties) {
        WebFrameworkUtils.properties = webProperties;
    }

    /**
     * 获得租户编号，从 header 中
     * 考虑到其它 framework 组件也会使用到租户编号，所以不得不放在 WebFrameworkUtils 统一提供
     *
     * @param request 请求
     * @return 租户编号
     */
    public static Long getTenantId(HttpServletRequest request) {
        String tenantId = request.getHeader(HEADER_TENANT_ID);
        return NumberUtil.isNumber(tenantId) ? Long.valueOf(tenantId) : null;
    }

    public static void setLoinUserDeptId(ServletRequest request, Long deptId) {
        request.setAttribute(GlobalConstants.LOGIN_USER_DEPT_ID_ATTR, deptId);
    }

    public static void setLoginUserId(ServletRequest request, Long userId) {
        request.setAttribute(GlobalConstants.LOGIN_USER_ID_ATTR, userId);
    }

    public static void setLoginUserName(ServletRequest request, String userName) {
        request.setAttribute(GlobalConstants.LOGIN_USERNAME_ATTR, userName);
    }

    /**
     * 设置用户类型
     *
     * @param request  请求
     * @param userType 用户类型
     */
    public static void setLoginUserType(ServletRequest request, Integer userType) {
        request.setAttribute(GlobalConstants.LOGIN_USER_TYPE_ATTR, userType);
    }

    /**
     * 获得当前用户的编号，从请求中
     * 注意：该方法仅限于 framework 框架使用！！！
     *
     * @param request 请求
     * @return 用户编号
     */
    public static Long getLoginUserId(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        return (Long) request.getAttribute(GlobalConstants.LOGIN_USER_ID_ATTR);
    }

    /**
     * 获得当前用户的类型
     * 注意：该方法仅限于 web 相关的 framework 组件使用！！！
     *
     * @param request 请求
     * @return 用户编号
     */
    public static Integer getLoginUserType(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        // 1. 优先，从 Attribute 中获取
        Integer userType = (Integer) request.getAttribute(GlobalConstants.LOGIN_USER_TYPE_ATTR);
        if (userType != null) {
            return userType;
        }
        // 2. 其次，基于 URL 前缀的约定
        if (request.getServletPath().startsWith(properties.getAdminApi().getPrefix())) {
            return UserTypeEnum.ADMIN.getValue();
        }
        if (request.getServletPath().startsWith(properties.getAppApi().getPrefix())) {
            return UserTypeEnum.MEMBER.getValue();
        }
        return null;
    }

    public static Integer getLoginUserType() {
        HttpServletRequest request = getRequest();
        return getLoginUserType(request);
    }

    public static Long getLoginUserId() {
        HttpServletRequest request = getRequest();
        return getLoginUserId(request);
    }

    public static String getLoginUserName() {
        HttpServletRequest request = getRequest();
        return getLoginUserName(request);
    }

    public static String getLoginUserName(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        return (String) request.getAttribute(GlobalConstants.LOGIN_USERNAME_ATTR);
    }

    public static Long getLoginUserDeptId() {
        HttpServletRequest request = getRequest();
        return getLoginUserDeptId(request);
    }

    public static Long getLoginUserDeptId(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        return (Long) request.getAttribute(GlobalConstants.LOGIN_USER_DEPT_ID_ATTR);
    }

    public static Integer getTerminal() {
        HttpServletRequest request = getRequest();
        if (request == null) {
            return TerminalEnum.UNKNOWN.getTerminal();
        }
        String terminalValue = request.getHeader(HEADER_TERMINAL);
        return NumberUtil.parseInt(terminalValue, TerminalEnum.UNKNOWN.getTerminal());
    }

    public static void setCommonResult(ServletRequest request, CommonResult<?> result) {
        request.setAttribute(REQUEST_ATTRIBUTE_COMMON_RESULT, result);
    }

    public static CommonResult<?> getCommonResult(ServletRequest request) {
        return (CommonResult<?>) request.getAttribute(REQUEST_ATTRIBUTE_COMMON_RESULT);
    }

    public static HttpServletRequest getRequest() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (!(requestAttributes instanceof ServletRequestAttributes)) {
            return null;
        }
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) requestAttributes;
        return servletRequestAttributes.getRequest();
    }

    /**
     * 判断是否为 RPC 请求
     *
     * @param request 请求
     * @return 是否为 RPC 请求
     */
    public static boolean isRpcRequest(HttpServletRequest request) {
        return request.getRequestURI().startsWith(RpcConstants.RPC_API_PREFIX);
    }

    /**
     * 判断是否为 RPC 请求
     * <p>
     * 约定大于配置，只要以 Api 结尾，都认为是 RPC 接口
     *
     * @param className 类名
     * @return 是否为 RPC 请求
     */
    public static boolean isRpcRequest(String className) {
        return className.endsWith("Api");
    }

}
