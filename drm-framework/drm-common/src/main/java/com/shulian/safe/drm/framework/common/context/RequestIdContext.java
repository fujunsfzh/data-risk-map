package com.shulian.safe.drm.framework.common.context;

import com.alibaba.ttl.TransmittableThreadLocal;
import org.apache.commons.lang3.StringUtils;

import java.util.UUID;

public class RequestIdContext {

    /**
     * ThreadLocal
     */
    // private static final ThreadLocal<String> THREAD_LOCAL_REQUEST_ID = new ThreadLocal<>();
    private static final ThreadLocal<String> THREAD_LOCAL_REQUEST_ID = new TransmittableThreadLocal<>();

    /**
     * 获取requestId
     *
     * @return requestId
     */
    public static String getRequestId() {
        String requestId = THREAD_LOCAL_REQUEST_ID.get();
        if (StringUtils.isEmpty(requestId)) {
            requestId = UUID.randomUUID().toString();
            THREAD_LOCAL_REQUEST_ID.set(requestId);
        }
        return requestId;
    }

    /**
     * 保存requestId
     *
     * @param requestId requestId
     */
    public static void setRequestId(String requestId) {
        THREAD_LOCAL_REQUEST_ID.set(requestId);
    }

    /**
     * 清楚requestId
     */
    public static void remove() {
        THREAD_LOCAL_REQUEST_ID.remove();
    }

}
