package com.shulian.safe.drm.framework.mq.redis.config;

import com.shulian.safe.drm.framework.mq.redis.core.RedisMQTemplate;
import com.shulian.safe.drm.framework.mq.redis.core.interceptor.RedisMessageInterceptor;
import com.shulian.safe.drm.framework.redis.config.DrmRedisAutoConfiguration;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.List;

/**
 * Redis 消息队列 Producer 配置类
 *
 * @author 系统源码
 */
@Slf4j
@AutoConfiguration(after = DrmRedisAutoConfiguration.class)
public class DrmRedisMQProducerAutoConfiguration {

    @Bean
    public RedisMQTemplate redisMQTemplate(StringRedisTemplate redisTemplate,
                                           List<RedisMessageInterceptor> interceptors) {
        RedisMQTemplate redisMQTemplate = new RedisMQTemplate(redisTemplate);
        // 添加拦截器
        interceptors.forEach(redisMQTemplate::addInterceptor);
        return redisMQTemplate;
    }

}
