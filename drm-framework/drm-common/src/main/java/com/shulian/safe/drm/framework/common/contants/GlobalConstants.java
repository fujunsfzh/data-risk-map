package com.shulian.safe.drm.framework.common.contants;

public class GlobalConstants {


    // ========== 请求唯一标识 ==========
    public static final String X_REQUEST_ID = "x-request-id";


    // ========== 请求传值 ==========
    public static final String LOGIN_USER_HEADER = "login-user";
    public static final String LOGIN_USER_ID_ATTR = "login-user-id";
    public static final String LOGIN_USERNAME_ATTR = "login-user-name";
    public static final String LOGIN_USER_TYPE_ATTR = "login-user-type";
    public static final String LOGIN_USER_DEPT_ID_ATTR = "login-user-dept-id";

    // ========== 系统表的前缀，用于数据权限区分 ==========
    public static final String SYSTEM_TABLE_START = "system_";
    public static final String INFRA_TABLE_START = "infra_";
}
