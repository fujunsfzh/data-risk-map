package com.shulian.safe.drm.module.dmap.service.scan;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import com.mzt.logapi.context.LogRecordContext;
import com.mzt.logapi.service.impl.DiffParseFunction;
import com.mzt.logapi.starter.annotation.LogRecord;
import com.shulian.safe.drm.framework.common.exception.enums.ServiceErrorCodeRange;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.util.AssertUtil;
import com.shulian.safe.drm.framework.quartz.core.enums.JobDataKeyEnum;
import com.shulian.safe.drm.framework.quartz.core.util.CronUtils;
import com.shulian.safe.drm.module.dmap.LogRecordConstants;
import com.shulian.safe.drm.module.dmap.convet.MetaConvert;
import com.shulian.safe.drm.module.dmap.convet.ScTaskConvert;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskSaveRetDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskInstanceEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;
import com.shulian.safe.drm.module.dmap.mapper.scan.ScTaskMapper;
import com.shulian.safe.drm.module.dmap.service.scheduler.IQuartzService;
import com.shulian.safe.drm.module.dmap.service.scheduler.ScanTaskJob;
import com.shulian.safe.drm.module.dmap.util.NmapUtil;
import jodd.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:33
 * @version: V1.0
 */
@Slf4j
@Service
public class ScTaskServiceImpl extends ServiceImpl<ScTaskMapper, ScTaskEntity> implements IScTaskService {

    @Resource
    private IQuartzService quartzService;


    @Resource
    private IScTaskInstanceService scTaskInstanceIdService;

    @Resource
    private IScTaskResultService scTaskResultService;


    /**
     * 分页查询
     *
     * @param name
     * @param type
     * @param status
     * @param pageParam
     * @return
     */
    public Page<ScTaskEntity> page(String name, Integer type, Integer status, PageParam pageParam) {
        Page<ScTaskEntity> page = new Page<>(pageParam.getPageNo(), pageParam.getPageSize());
        LambdaQueryWrapper<ScTaskEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ScTaskEntity::getDeleted, false);
        queryWrapper.like(StringUtils.isNotBlank(name), ScTaskEntity::getName, name);
        queryWrapper.eq(type != null, ScTaskEntity::getType, type);
        queryWrapper.eq(status != null, ScTaskEntity::getStatus, status);
        queryWrapper.orderByDesc(ScTaskEntity::getId);

        Page<ScTaskEntity> pages = page(page, queryWrapper);

        return pages;
    }


    /**
     * 任务的详细信息
     *
     * @param id
     * @return
     */
    public ScTaskInfoDTO queryTask(Long id) {
        ScTaskEntity task = getById(id);
        AssertUtil.isFalse(task == null || task.getDeleted(), "任务不存在");

        ScTaskInfoDTO taskInfoDTO = ScTaskConvert.INSTANCE.convertInfo(task);
        Integer type = taskInfoDTO.getType();
        if (type == 2) {
            String cron = taskInfoDTO.getCron();
            List<LocalDateTime> nextFiveTime = CronUtils.getNextFiveTime(cron);
            taskInfoDTO.setNextFiveTime(nextFiveTime);
        }
        return taskInfoDTO;
    }


    @Override
    @LogRecord(type = LogRecordConstants.SCAN_TYPE,
            subType = LogRecordConstants.SCAN_DELETE_SUB_TYPE,
            bizNo = "{{#id}}",
            success = LogRecordConstants.SCAN_DELETE_SUCCESS)
    @Transactional(rollbackFor = Exception.class)
    public void deleteTask(Long id) {
        ScTaskEntity task = getById(id);
        AssertUtil.notNull(task, "任务不存在");

        // 记录操作日志
        LogRecordContext.putVariable("task", task);

        // 删除任务
        quartzService.deleteJob(task.getId().toString());
        // 删除数据
        task.setDeleted(true);
        updateById(task);
    }


    /**
     * 修改任务状态
     *
     * @param id     任务配置主键
     * @param status 任务状态 1-正常 2-暂停
     */
    @LogRecord(type = LogRecordConstants.SCAN_TYPE,
            subType = LogRecordConstants.SCAN_UPDATE_STATUS_SUB_TYPE,
            bizNo = "{{#id}}",
            success = LogRecordConstants.SCAN_UPDATE_STATUS_SUCCESS)
    @Override
    public void updateStatus(Long id, Integer status) {
        ScTaskEntity task = getById(id);
        AssertUtil.isFalse(task == null || task.getDeleted(), "任务不存在");
        Integer dbStatus = task.getStatus();
        if (status == 1) {
            if (Objects.equals(dbStatus, status)) {
                log.warn("taskId:{} 任务已处于正常状态，无需修改调度器", id);
            } else {
                // 放行
                quartzService.resume(task.getId().toString());
            }
        } else {
            // 暂停
            quartzService.pause(task.getId().toString());
        }

        // 任务状态修改
        task.setStatus(status);
        updateById(task);

        // 记录操作日志
        LogRecordContext.putVariable("task", task);
        LogRecordContext.putVariable("oldStatus", dbStatus);

        /*if (status == 1) {
            Integer dbStatus = task.getStatus();
            if (dbStatus != status) {
                // createScheduleJob(task);
                // 放行
                quartzService.resume(task.getId().toString());
            }
        } else {
            // 暂停，删除调度
            // quartzService.disable(task.getId().toString());
            // 暂停
            quartzService.pause(task.getId().toString());
        }*/
    }


    /**
     * 修改任务
     *
     * @param reqDTO
     */
    @Override
    @LogRecord(type = LogRecordConstants.SCAN_TYPE,
            subType = LogRecordConstants.SCAN_UPDATE_SUB_TYPE,
            bizNo = "{{#reqDTO.id}}",
            success = LogRecordConstants.SCAN_UPDATE_SUCCESS)
    @Transactional(rollbackFor = Exception.class)
    public void updateTask(ScTaskSaveReqDTO reqDTO) {
        // 数据校验
        checkData(reqDTO);
        Long taskId = reqDTO.getId();
        AssertUtil.notNull(taskId, "任务ID不能为空");

        ScTaskEntity task = getById(taskId);
        AssertUtil.notNull(task, "任务不存在");

        Integer status = task.getStatus();
        AssertUtil.isTrue(status == 1, "正常开启的任务才可修改");

        // 更新数据
        ScTaskEntity entity = ScTaskConvert.INSTANCE.convert(reqDTO);
        entity.setId(taskId);
        updateById(entity);

        entity = getById(taskId);

        // 更新调度任务
        // Map<String, String> params = Maps.newHashMap();
        // params.put(JobDataKeyEnum.JOB_ID.name(), taskId.toString());
        // params.put(JobDataKeyEnum.JOB_RETRY_COUNT.name(), entity.getRetryCount().toString());
        // params.put(JobDataKeyEnum.JOB_RETRY_INTERVAL.name(), entity.getRetryInterval().toString());
        // quartzService.updateScheduleJob(taskId.toString(), entity.getCron(), entity.getTriggerStartTime(), entity.getTriggerEndTime(), params());

        // 删除调度
        quartzService.deleteJob(taskId.toString());
        // 放行,重新添加任务
        createScheduleJob(entity);

        // 记录操作日志
        ScTaskSaveReqDTO diff = ScTaskConvert.INSTANCE.convertDiff(task);
        LogRecordContext.putVariable(DiffParseFunction.OLD_OBJECT, diff);
        LogRecordContext.putVariable("task", task);
    }

    /**
     * 创建任务
     *
     * @param reqDTO
     * @return
     */
    @Override
    @LogRecord(type = LogRecordConstants.SCAN_TYPE,
            subType = LogRecordConstants.SCAN_CREATE_SUB_TYPE,
            bizNo = "{{#pkId}}",
            success = LogRecordConstants.SCAN_CREATE_SUCCESS)
    @Transactional(rollbackFor = Exception.class)
    public Long create(ScTaskSaveReqDTO reqDTO) {
        // 数据校验
        checkData(reqDTO);
        // 保存数据
        ScTaskEntity entity = ScTaskConvert.INSTANCE.convert(reqDTO);
        entity.setId(null);
        // 给默认值
        entity.setStatus(1);
        baseMapper.insert(entity);
        // 创建任务
        createScheduleJob(entity);

        Long pkId = entity.getId();
        // 记录操作日志
        LogRecordContext.putVariable("pkId", pkId);

        return pkId;
    }


    /**
     * 执行一次
     *
     * @param taskId
     */
    @LogRecord(type = LogRecordConstants.SCAN_TYPE,
            subType = LogRecordConstants.SCAN_TRIGGER_SUB_TYPE,
            bizNo = "{{#taskId}}",
            success = LogRecordConstants.SCAN_TRIGGER_SUCCESS)
    public void triggerJob(Long taskId) {
        ScTaskEntity task = getById(taskId);
        AssertUtil.isFalse(task == null || task.getDeleted(), "任务不存在");
        AssertUtil.isTrue(task.getStatus() == 1, "正常开启的任务才可执行");

        // 记录操作日志
        LogRecordContext.putVariable("task", task);

        // 不同任务类型,手动执行一次任务
        Integer type = task.getType();
        Map<String, String> params = Maps.newHashMap();
        if (type == 1) {
            // 单次任务
            String jobId = taskId.toString();
            params.put(JobDataKeyEnum.JOB_ID.name(), jobId);
            params.put(JobDataKeyEnum.JOB_RETRY_COUNT.name(), task.getRetryCount().toString());
            params.put(JobDataKeyEnum.JOB_RETRY_INTERVAL.name(), task.getRetryInterval().toString());
            // 再次创建任务
            quartzService.executeJob(ScanTaskJob.class, jobId, params);
        } else if (type == 2) {
            // 周期任务
            String jobId = taskId.toString();
            params.put(JobDataKeyEnum.JOB_ID.name(), jobId);
            params.put(JobDataKeyEnum.JOB_RETRY_COUNT.name(), "0");
            params.put(JobDataKeyEnum.JOB_RETRY_INTERVAL.name(), "0");
            // 执行一次
            quartzService.triggerJob(jobId, params);
        }
    }

    /**
     * 创建任务
     *
     * @param entity
     */
    private void createScheduleJob(ScTaskEntity entity) {
        Long taskId = entity.getId();
        // 创建任务
        String jobId = taskId.toString();
        Map<String, String> params = Maps.newHashMap();
        params.put(JobDataKeyEnum.JOB_ID.name(), jobId);
        params.put(JobDataKeyEnum.JOB_RETRY_COUNT.name(), entity.getRetryCount().toString());
        params.put(JobDataKeyEnum.JOB_RETRY_INTERVAL.name(), entity.getRetryInterval().toString());

        Integer type = entity.getType();
        if (type == 1) {
            // 单次任务
            // jobId = taskId + "_" + LocalDateTime.now();
            quartzService.executeJob(ScanTaskJob.class, jobId, params);
        } else if (type == 2) {
            // 周期任务
            String cron = entity.getCron();
            LocalDateTime triggerStartTime = entity.getTriggerStartTime();
            LocalDateTime triggerEndTime = entity.getTriggerEndTime();
            quartzService.createScheduleJob(ScanTaskJob.class, jobId, cron, triggerStartTime, triggerEndTime, params);
        }
    }


    /**
     * 数据校验
     *
     * @param reqDTO
     */
    private void checkData(ScTaskSaveReqDTO reqDTO) {
        // 环境检测，放在这里或者服务启动后
        boolean checked = NmapUtil.checkExists();
        AssertUtil.isTrue(checked, ServiceErrorCodeRange.SCAN_NMAP_NOT_FOUND);

        Integer type = reqDTO.getType();
        // 周期任务校验表达式
        if (type == 2) {
            String cron = reqDTO.getCron();
            AssertUtil.isTrue(StringUtil.isNotBlank(cron), ServiceErrorCodeRange.SCAN_CRON_NOT_NULL);

            boolean valid = CronUtils.isValid(cron);
            AssertUtil.isTrue(valid, ServiceErrorCodeRange.SCAN_CRON_NOT_VALID);

            // 失效时间非空时，校验合法性
            LocalDateTime triggerEndTime = reqDTO.getTriggerEndTime();
            if (triggerEndTime != null) {
                //fixme 可能得必填
                LocalDateTime triggerStartTime = reqDTO.getTriggerStartTime();
                if (triggerStartTime != null) {
                    triggerStartTime = LocalDateTime.now();
                }
                LocalDateTime nextTime = CronUtils.getNextTime(triggerStartTime, cron);
                boolean after = triggerEndTime.isAfter(nextTime);
                AssertUtil.isTrue(after, "生效时间、失效时间与执行周期不符合！新增失败");
            }
        }
    }


    // /**
    //  * 根据任务和时间查询扫描结果
    //  *
    //  * @param taskId    任务主键
    //  * @param startTime 实例开始时间
    //  * @param endTime   实例结束时间
    //  * @return
    //  */
    // public List<ScTaskResultEntity> queryResultByTask(Long taskId, LocalDateTime startTime, LocalDateTime endTime) {
    //     Page<ScTaskInstanceEntity> page = scTaskInstanceIdService.page(taskId, null, startTime, endTime, new PageParam(PageParam.PAGE_NO, PageParam.PAGE_SIZE_NONE));
    //     List<ScTaskInstanceEntity> records = page.getRecords();
    //     List<String> collect = records.stream().map(ScTaskInstanceEntity::getInstanceId).collect(Collectors.toList());
    //
    //     return scTaskResultService.queryByInstanceIds(collect);
    // }
}
