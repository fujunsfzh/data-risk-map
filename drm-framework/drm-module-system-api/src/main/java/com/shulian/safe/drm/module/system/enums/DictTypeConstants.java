package com.shulian.safe.drm.module.system.enums;

/**
 * System 字典类型的枚举类
 *
 * @author 系统源码
 */
public interface DictTypeConstants {

    String USER_TYPE = "user_type"; // 用户类型
    String COMMON_STATUS = "common_status"; // 系统状态

    // ========== SYSTEM 模块 ==========

    String USER_SEX = "system_user_sex"; // 用户性别

    String LOGIN_TYPE = "system_login_type"; // 登录日志的类型
    String LOGIN_RESULT = "system_login_result"; // 登录结果

    String ERROR_CODE_TYPE = "system_error_code_type"; // 错误码的类型枚举

    String SMS_CHANNEL_CODE = "system_sms_channel_code"; // 短信渠道编码
    String SMS_TEMPLATE_TYPE = "system_sms_template_type"; // 短信模板类型
    String SMS_SEND_STATUS = "system_sms_send_status"; // 短信发送状态
    String SMS_RECEIVE_STATUS = "system_sms_receive_status"; // 短信接收状态



    String JOB_STATUS = "infra_job_status"; // 定时任务状态的枚举
    String JOB_LOG_STATUS = "infra_job_log_status"; // 定时任务日志状态的枚举

    String API_ERROR_LOG_PROCESS_STATUS = "infra_api_error_log_process_status"; // API 错误日志的处理状态的枚举

    String CONFIG_TYPE = "infra_config_type"; // 参数配置类型
    String BOOLEAN_STRING = "infra_boolean_string"; // Boolean 是否类型

    String OPERATE_TYPE = "infra_operate_type"; // 操作类型

}
