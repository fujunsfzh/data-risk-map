package com.shulian.safe.drm.framework.web.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.ThreadPoolExecutor;

/**
 * 异步线程池
 */
@EnableAsync
@Configuration
public class ThreadPoolConfig {

    /**
     * 默认线程数
     */
    @Value("${feedback-thread-pool.corePoolSize:8}")
    private int corePoolSize;

    /**
     * 最大线程数
     */
    @Value("${feedback-thread-pool.maxPoolSize:32}")
    private int maxPoolSize;

    /**
     * 允许线程空闲时间 单位：秒
     */
    @Value("${feedback-thread-pool.keepAliveSeconds:60}")
    private int keepAliveSeconds;

    /**
     * 队列
     */
    @Value("${feedback-thread-pool.queueCapacity:128}")
    private int queueCapacity;

    /**
     * 线程池名前缀
     */
    private static final String THREAD_NAME_PREFIX = "feedBack-";

    /**
     * @return TaskExecutor
     */
    @Bean
    public TaskExecutor feedBackTaskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        // 设置核心线程数
        executor.setCorePoolSize(corePoolSize);
        // 设置最大线程数
        executor.setMaxPoolSize(maxPoolSize);
        // 设置队列容量
        executor.setQueueCapacity(queueCapacity);
        // 设置线程活跃时间（秒）
        executor.setKeepAliveSeconds(keepAliveSeconds);
        // 设置默认线程名称
        executor.setThreadNamePrefix(THREAD_NAME_PREFIX);
        // 设置拒绝策略
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
        // 等待所有任务结束后再关闭线程池
        executor.setWaitForTasksToCompleteOnShutdown(true);
        return executor;
    }
}
