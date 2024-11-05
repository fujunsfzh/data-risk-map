package com.shulian.safe.drm.module.system.api.config;

import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.module.system.dal.dataobject.config.ConfigDO;
import com.shulian.safe.drm.module.system.service.config.ConfigService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

import static com.shulian.safe.drm.framework.common.pojo.CommonResult.success;

@RestController // 提供 RESTful API 接口，给 Feign 调用
@Validated
public class ConfigApiImpl implements ConfigApi {

    @Resource
    private ConfigService configService;

    @Override
    public CommonResult<String> getConfigValueByKey(String key) {
        ConfigDO config = configService.getConfigByKey(key);
        return success(config != null ? config.getValue() : null);
    }

}
