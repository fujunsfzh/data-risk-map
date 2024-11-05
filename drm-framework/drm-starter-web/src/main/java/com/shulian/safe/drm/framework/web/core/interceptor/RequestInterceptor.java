package com.shulian.safe.drm.framework.web.core.interceptor;

import com.shulian.safe.drm.framework.common.contants.GlobalConstants;
import com.shulian.safe.drm.framework.common.context.RequestIdContext;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: WF
 * @date: 2024/9/11 16:29
 * @version: V1.0
 */
@Slf4j
public class RequestInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String requestId = request.getHeader(GlobalConstants.X_REQUEST_ID);

        // if (StringUtils.isBlank(requestId)) {
        //     requestId = IdUtil.fastUUID();
        // }
        // RequestIdContext.setRequestId(requestId);

        if (StringUtils.isNotBlank(requestId)) {
            RequestIdContext.setRequestId(requestId);
        }
        MDC.put(GlobalConstants.X_REQUEST_ID, requestId);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        RequestIdContext.remove();
    }
}