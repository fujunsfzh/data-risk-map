package com.shulian.safe.drm.module.system.service.sms;

import com.shulian.safe.drm.framework.common.exception.ServiceException;
import com.shulian.safe.drm.module.system.api.sms.dto.code.SmsCodeSendReqDTO;
import com.shulian.safe.drm.module.system.api.sms.dto.code.SmsCodeUseReqDTO;
import com.shulian.safe.drm.module.system.api.sms.dto.code.SmsCodeValidateReqDTO;

import javax.validation.Valid;

/**
 * 短信验证码 Service 接口
 *
 * @author 系统源码
 */
public interface SmsCodeService {

    /**
     * 创建短信验证码，并进行发送
     *
     * @param reqDTO 发送请求
     */
    void sendSmsCode(@Valid SmsCodeSendReqDTO reqDTO);

    /**
     * 验证短信验证码，并进行使用
     * 如果正确，则将验证码标记成已使用
     * 如果错误，则抛出 {@link ServiceException} 异常
     *
     * @param reqDTO 使用请求
     */
    void useSmsCode(@Valid SmsCodeUseReqDTO reqDTO);

    /**
     * 检查验证码是否有效
     *
     * @param reqDTO 校验请求
     */
    void validateSmsCode(@Valid SmsCodeValidateReqDTO reqDTO);

}
