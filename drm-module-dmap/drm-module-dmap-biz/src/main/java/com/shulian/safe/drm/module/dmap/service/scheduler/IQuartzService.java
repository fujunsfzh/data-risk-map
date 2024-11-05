package com.shulian.safe.drm.module.dmap.service.scheduler;

import org.quartz.Job;

import java.time.LocalDateTime;
import java.util.Map;


/**
 * 定制任务服务
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/13 18:35
 * @version: V1.0
 */

public interface IQuartzService {

    /**
     * 暂停任务
     */
    void pause(String jobName);

    /**
     * 恢复任务
     */
    void resume(String jobName);


    /**
     * 删除任务
     */
    void deleteJob(String jobName);

    /**
     * 暂停全部任务
     */
    void pauseAll();

    /**
     * 恢复全部任务
     */
    void resumeAll();

    /**
     * 清除所有任务
     */
    void clear();


    /**
     * 暂停（删除,恢复时在开新任务）
     *
     * @param jobName
     */
    void disable(String jobName);


    /**
     * 查询任务的状态
     *
     * @param jobName
     * @return true-存在
     */
    boolean getJobStatus(String jobName);

    /**
     * 创建执行一次的任务
     *
     * @param jobClass 任务的实现类
     * @param jobName  任务标识
     * @param params   任务参数
     */
    void executeJob(Class<? extends Job> jobClass, String jobName, Map<String, String> params);

    /**
     * 已存在的任务手动执行一次
     *
     * @param jobName
     * @param params
     */
    void triggerJob(String jobName, Map<String, String> params);

    /**
     * 创建计划任务
     *
     * @param jobClass         任务的实现类
     * @param jobName          任务的表示
     * @param cron             任务的周期表达式
     * @param triggerStartTime 任务生效时间
     * @param triggerEndTime   任务的失效时间
     * @param params           任务参数
     */
    void createScheduleJob(Class<? extends Job> jobClass,
                           String jobName,
                           String cron,
                           LocalDateTime triggerStartTime,
                           LocalDateTime triggerEndTime,
                           Map<String, String> params);


    /**
     * 更新调度
     *
     * @param jobName
     * @param cron
     * @param triggerStartTime
     * @param triggerEndTime
     * @param params
     */
    void updateScheduleJob(String jobName,
                           String cron,
                           LocalDateTime triggerStartTime,
                           LocalDateTime triggerEndTime,
                           Map<String, String> params);
}
