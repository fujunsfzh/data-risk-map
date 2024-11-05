package com.shulian.safe.drm.module.dmap.service.scheduler;

import com.google.common.collect.Sets;
import com.shulian.safe.drm.framework.common.exception.ServiceException;
import com.shulian.safe.drm.framework.common.util.date.DateUtils;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.quartz.listeners.JobListenerSupport;
import org.quartz.listeners.SchedulerListenerSupport;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/14 14:47
 * @version: V1.0
 */
@Slf4j
@Service
public class QuartzServiceImpl implements IQuartzService, InitializingBean {

    @Resource
    private Scheduler scheduler;

    @Override
    public void afterPropertiesSet() throws Exception {
        // 调度器监听
        scheduler.getListenerManager().addSchedulerListener(new SchedulerListenerSupport() {
            // 启动事件
            public void schedulerStarted() {
                log.info("scheduler started");
            }

            // 错误事件
            public void schedulerError(SchedulerException cause) {
                log.error("Scheduler error", cause);
            }
        });
        // 作业监听器
        scheduler.getListenerManager().addJobListener(new JobListenerSupport() {
            // 监听器名称
            public String getName() {
                return "listener custom";
            }

            // 在作业执行前记录一条信息日志，包含作业的名称。
            public void jobToBeExecuted(JobExecutionContext context) {
                log.info("任务号：{}", context.getJobDetail().getKey().getName());
            }
        });
    }


    @SneakyThrows
    @Override
    public void pause(String jobName) {
        // 暂停任务
        scheduler.pauseJob(JobKey.jobKey(jobName));
    }

    @SneakyThrows
    @Override
    public void resume(String jobName) {
        // 恢复任务
        scheduler.resumeJob(JobKey.jobKey(jobName));
        scheduler.resumeTrigger(new TriggerKey(jobName));
    }

    @SneakyThrows
    @Override
    public void deleteJob(String jobName) {
        // 暂停、移除、删除
        scheduler.pauseTrigger(TriggerKey.triggerKey(jobName));
        scheduler.unscheduleJob(TriggerKey.triggerKey(jobName));
        scheduler.deleteJob(JobKey.jobKey(jobName));
    }

    @SneakyThrows
    @Override
    public void pauseAll() {
        // 暂停全部
        scheduler.pauseAll();
    }

    @SneakyThrows
    @Override
    public void resumeAll() {
        // 恢复全部
        scheduler.resumeAll();
    }

    @SneakyThrows
    @Override
    public void clear() {
        // 移除全部任务
        scheduler.clear();
    }

    @Override
    public void disable(String jobName) {

    }

    @SneakyThrows
    @Override
    public boolean getJobStatus(String jobName) {
        return scheduler.checkExists(JobKey.jobKey(jobName));
    }

    /**
     * 创建执行一次的任务
     *
     * @param jobClass 任务的实现类
     * @param jobName  任务标识
     * @param params   任务参数
     */
    @SneakyThrows
    @Override
    public void executeJob(Class<? extends Job> jobClass, String jobName, Map<String, String> params) {
        Trigger trigger = TriggerBuilder.newTrigger().withIdentity(jobName).startNow().build();
        if (params != null) {
            trigger.getJobDataMap().putAll(params);
        }
        JobBuilder jobBuilder = JobBuilder.newJob(jobClass).withIdentity(jobName);
        JobDetail jobDetail = jobBuilder.build();
        // 第三个参数true表示如果作业已经存在，则覆盖原有的作业。
        scheduler.scheduleJob(jobDetail, Sets.newHashSet(trigger), true);
    }


    /**
     * 已存在的任务手动执行一次
     *
     * @param jobName
     * @param params
     */
    @SneakyThrows
    public void triggerJob(String jobName, Map<String, String> params) {
        // 检查调度器是否已经启动
        if (!scheduler.isStarted()) {
            scheduler.start();
        }

        // 检查并获取触发器的状态
        TriggerKey triggerKey = new TriggerKey(jobName);
        Trigger.TriggerState triggerState = scheduler.getTriggerState(triggerKey);
        // 非正常状态
        if (triggerState != Trigger.TriggerState.NORMAL) {
            log.warn("jobId:{} 作业调度处于非正常状态，当前状态: {}", jobName, triggerState);
            throw new ServiceException(500, String.format("作业调度处于非正常状态,当前状态[%s]", triggerState));
        }

        JobDataMap jobDataMap = new JobDataMap();
        if (params != null) {
            jobDataMap.putAll(params);
        }
        scheduler.triggerJob(new JobKey(jobName), jobDataMap);
    }

    /**
     * 创建周期调度任务
     *
     * @param jobClass         任务的实现类
     * @param jobName          任务的表示
     * @param cron             任务的周期表达式
     * @param triggerStartTime 任务生效时间
     * @param triggerEndTime   任务的失效时间
     * @param params           任务参数
     */
    @SneakyThrows
    @Override
    public void createScheduleJob(Class<? extends Job> jobClass, String jobName, String cron, LocalDateTime triggerStartTime, LocalDateTime triggerEndTime, Map<String, String> params) {
        // 1. 构建调度信息
        TriggerBuilder<Trigger> triggerBuilder = TriggerBuilder.newTrigger()
                .withIdentity(jobName)
                .withSchedule((ScheduleBuilder) CronScheduleBuilder.cronSchedule(cron));
        if (triggerStartTime == null) {
            triggerBuilder.startAt(DateUtils.of(triggerStartTime));
        }
        if (triggerEndTime == null) {
            triggerBuilder.endAt(DateUtils.of(triggerEndTime));
        }
        Trigger trigger = triggerBuilder.build();
        if (params != null) {
            trigger.getJobDataMap().putAll(params);
        }
        // 2. 构建任务信息
        JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(jobName).build();
        // 第三个参数true表示如果作业已经存在，则覆盖原有的作业。
        scheduler.scheduleJob(jobDetail, Sets.newHashSet(trigger), true);
    }


    /**
     * 更新调度
     *
     * @param jobName
     * @param cron
     * @param triggerStartTime
     * @param triggerEndTime
     * @param params
     */
    @SneakyThrows
    public void updateScheduleJob(String jobName, String cron, LocalDateTime triggerStartTime, LocalDateTime triggerEndTime, Map<String, String> params) {
        TriggerKey triggerKey = TriggerKey.triggerKey(jobName);
        Trigger trigger = scheduler.getTrigger(triggerKey);

        // 表达式调度构建器
        ScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cron);
        // 按新的cronExpression表达式重新构建trigger
        TriggerBuilder<Trigger> triggerBuilder = trigger.getTriggerBuilder().withIdentity(jobName).withSchedule(scheduleBuilder);
        if (triggerStartTime == null) {
            triggerBuilder.startAt(DateUtils.of(triggerStartTime));
        }
        if (triggerEndTime == null) {
            triggerBuilder.endAt(DateUtils.of(triggerEndTime));
        }
        //修改map
        if (params != null) {
            trigger.getJobDataMap().putAll(params);
        }
        // 按新的trigger重新设置job执行
        scheduler.rescheduleJob(triggerKey, trigger);
    }

}
