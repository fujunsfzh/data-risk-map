package com.shulian.safe.drm.module.dmap;

import com.shulian.safe.drm.framework.common.enums.RpcConstants;

/**
 * API 相关的枚举
 *
 * @author 系统源码
 */
public class ApiConstants {

    /**
     * 服务名
     *
     * 注意，需要保证和 spring.application.name 保持一致
     */
    public static final String NAME = "dmap-server";

    public static final String PREFIX = RpcConstants.RPC_API_PREFIX +  "/dmap";

    public static final String VERSION = "1.0.0";

}
