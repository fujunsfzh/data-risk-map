package com.shulian.safe.drm.module.dmap.config;

import org.springframework.context.annotation.Configuration;

@Configuration
public class RocketMQEnhanceConfig {

    /**
     * 解决RocketMQ Jackson不支持Java时间类型配置
     * 源码参考：{@link org.apache.rocketmq.spring.autoconfigure.MessageConverterConfiguration}
     */
    // @Bean
    // @Primary
    // public RocketMQMessageConverter enhanceRocketMQMessageConverter(){
    //     RocketMQMessageConverter converter = new RocketMQMessageConverter();
    //     CompositeMessageConverter compositeMessageConverter = (CompositeMessageConverter) converter.getMessageConverter();
    //     List<MessageConverter> messageConverterList = compositeMessageConverter.getConverters();
    //     for (MessageConverter messageConverter : messageConverterList) {
    //         if(messageConverter instanceof MappingJackson2MessageConverter){
    //             MappingJackson2MessageConverter jackson2MessageConverter = (MappingJackson2MessageConverter) messageConverter;
    //             ObjectMapper objectMapper = jackson2MessageConverter.getObjectMapper();
    //             objectMapper.registerModules(new JavaTimeModule());
    //         }
    //     }
    //     return converter;
    // }
}
