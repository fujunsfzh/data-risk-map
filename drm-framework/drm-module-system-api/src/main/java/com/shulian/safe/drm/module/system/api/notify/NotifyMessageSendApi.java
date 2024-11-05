package com.shulian.safe.drm.module.system.api.notify;

import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.module.system.api.notify.dto.NotifySendSingleToUserReqDTO;
import com.shulian.safe.drm.module.system.enums.ApiConstants;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@FeignClient(name = ApiConstants.NAME) // TODO 芋艿：fallbackFactory =
@Tag(name = "RPC 服务 - 站内信发送")
public interface NotifyMessageSendApi {

    String PREFIX = ApiConstants.PREFIX + "/notify/send";

    @PostMapping(PREFIX + "/send-single-admin")
    @Operation(summary = "发送单条站内信给 Admin 用户")
    CommonResult<Long> sendSingleMessageToAdmin(@Valid @RequestBody NotifySendSingleToUserReqDTO reqDTO);

    @PostMapping(PREFIX + "/send-single-member")
    @Operation(summary = "发送单条站内信给 Member 用户")
    CommonResult<Long> sendSingleMessageToMember(@Valid @RequestBody NotifySendSingleToUserReqDTO reqDTO);

}
