package com.shulian.safe.drm.module.system.framework.file.config;

import com.shulian.safe.drm.module.system.framework.file.core.client.FileClientFactory;
import com.shulian.safe.drm.module.system.framework.file.core.client.FileClientFactoryImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 文件配置类
 *
 * @author 系统源码
 */
@Configuration(proxyBeanMethods = false)
public class DrmFileAutoConfiguration {

    @Bean
    public FileClientFactory fileClientFactory() {
        return new FileClientFactoryImpl();
    }

}
