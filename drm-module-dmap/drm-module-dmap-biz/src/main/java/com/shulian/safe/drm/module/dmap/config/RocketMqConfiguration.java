package com.shulian.safe.drm.module.dmap.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/12 18:09
 * @version: V1.0
 */
@Component
@Configuration
@Data
public class RocketMqConfiguration {

    /**
     * 数据打标识别的 tipic
     */
    @Value("${rocketmq.producer.mark-scan-topic}")
    private String markScanTopic;

    @Value("${rocketmq.consumer.group}")
    private String consumerGroup;

    @Value("${rocketmq.consumer.mark-scan-topic}")
    private String consumerMarkTopic;

}
