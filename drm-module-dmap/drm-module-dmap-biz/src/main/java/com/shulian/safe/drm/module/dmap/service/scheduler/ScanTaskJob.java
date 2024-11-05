package com.shulian.safe.drm.module.dmap.service.scheduler;

import cn.hutool.core.thread.ThreadUtil;
import com.shulian.safe.drm.framework.common.util.AssertUtil;
import com.shulian.safe.drm.framework.quartz.core.enums.JobDataKeyEnum;
import com.shulian.safe.drm.module.dmap.dto.scan.ScanInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScanRetDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskInstanceEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskInstanceService;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskResultService;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskService;
import com.shulian.safe.drm.module.dmap.util.NmapUtil;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.scheduling.quartz.QuartzJobBean;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/14 15:37
 * @version: V1.0
 */
@DisallowConcurrentExecution
@PersistJobDataAfterExecution
@Slf4j
public class ScanTaskJob extends QuartzJobBean {

    @Resource
    private IScTaskService scTaskService;

    @Resource
    private IScTaskInstanceService scTaskInstanceIdService;

    @Resource
    private IScTaskResultService scTaskResultService;

    @Override
    protected void executeInternal(JobExecutionContext executionContext) throws JobExecutionException {
        // 第几次执行，用于区分是不是重试执行。如果是重试执行，则 index 大于 1
        int refireCount = executionContext.getRefireCount();

        // 任务参数
        JobDataMap mergedJobDataMap = executionContext.getMergedJobDataMap();
        long taskId = mergedJobDataMap.getLongValue(JobDataKeyEnum.JOB_ID.name());

        // 重试参数
        int retryCount = 0;
        int retryInterval = 0;
        try {
            retryCount = mergedJobDataMap.getIntValue(JobDataKeyEnum.JOB_RETRY_COUNT.name());
            retryInterval = mergedJobDataMap.getInt(JobDataKeyEnum.JOB_RETRY_INTERVAL.name());
        } catch (Exception e) {
            log.warn("taskId:{},获取任务重试参数异常,忽略重试", taskId, e);
        }

        // 创建任务实例,返回实例主键
        Long instancePk = scTaskInstanceIdService.createByTaskId(taskId);
        // 反查实例
        ScTaskInstanceEntity instanceIdEntity = scTaskInstanceIdService.getById(instancePk);
        String instanceId = instanceIdEntity.getInstanceId();

        ScanRetDTO scanRet = null;
        int exeStatus = 3;
        try {
            scanRet = doRun(taskId, instancePk, instanceId);
        } catch (Exception e) {
            // 处理异常
            exeStatus = 4;
            log.error("taskId:{},instanceId:{},执行任务失败", taskId, instanceId, e);

            // 第四步，处理有异常的情况
            handleException(e, refireCount, retryCount, retryInterval);
        }

        // 更新实例执行状态
        scTaskInstanceIdService.updateByScanRet(instancePk, exeStatus, scanRet);

        // 记录执行结果
        if (scanRet != null && !scanRet.getScanInfoList().isEmpty()) {
            List<ScanInfoDTO> scanInfoList = scanRet.getScanInfoList();

            /**
             *   取创建时间
             *   任务结果的创建时间，取任务实例的创建时间
             *   在数据统计时，按实例的创建时间算。
             */
            LocalDateTime instanceCreateTime = instanceIdEntity.getCreateTime();

            List<ScTaskResultEntity> list = scanInfoList.stream().map(e -> {
                ScTaskResultEntity entity = new ScTaskResultEntity();
                entity.setTaskId(taskId);
                entity.setInstanceId(instanceId);
                entity.setDsUrl(e.getIp());
                entity.setDsPort(e.getPort());
                entity.setDsType(e.getServerName());
                // 用实例的创建时间
                entity.setCreateTime(instanceCreateTime);
                return entity;
            }).collect(Collectors.toList());

            scTaskResultService.saveBatch(list);
        }
    }


    /**
     * 执行扫描任务，返回 nmap 扫描结果
     *
     * @param taskId     任务主键
     * @param instancePk 实例主键
     * @param instanceId 实例 UUID
     * @return
     */
    private ScanRetDTO doRun(Long taskId, Long instancePk, String instanceId) {
        ScTaskEntity task = scTaskService.getById(taskId);
        AssertUtil.notNull(task, "扫描任务不存在");

        // 更新实例执行状态 运行中
        ScTaskInstanceEntity entity = new ScTaskInstanceEntity();
        entity.setExeStatus(2).setId(instancePk);
        scTaskInstanceIdService.updateById(entity);

        // 执行任务
        String ip = task.getIp();
        String port = task.getPort();
        ScanRetDTO scanRet = NmapUtil.scan(instanceId, ip, port);
        return scanRet;
    }


    /**
     * 任务重试
     *
     * @param exception
     * @param refireCount
     * @param retryCount
     * @param retryInterval
     * @throws JobExecutionException
     */
    private void handleException(Throwable exception,
                                 int refireCount, int retryCount, int retryInterval) throws JobExecutionException {
        // 如果有异常，则进行重试
        if (exception == null) {
            return;
        }
        // 情况一：如果到达重试上限，则直接抛出异常即可
        if (refireCount >= retryCount) {
            throw new JobExecutionException(exception);
        }

        // 情况二：如果未到达重试上限，则 sleep 一定间隔时间，然后重试
        // 这里使用 sleep 来实现，主要还是希望实现比较简单。因为，同一时间，不会存在大量失败的 Job。
        if (retryInterval > 0) {
            ThreadUtil.sleep(retryInterval);
        }
        // 第二个参数，refireImmediately = true，表示立即重试
        throw new JobExecutionException(exception, true);
    }


}
