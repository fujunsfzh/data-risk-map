package com.shulian.safe.drm.module.dmap.service.scan;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.dto.scan.ScanRetDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskInstanceEntity;

import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/13 11:54
 * @version: V1.0
 */
public interface IScTaskInstanceService extends IService<ScTaskInstanceEntity> {

    /**
     * 根据任务配置创建任务实例
     *
     * @param taskId
     * @return
     */
    Long createByTaskId(Long taskId);


    /**
     * 更新实例结果
     *
     * @param id
     * @param exeStatus
     * @param scanRetDTO
     */
    void updateByScanRet(Long id, Integer exeStatus, ScanRetDTO scanRetDTO);


    /**
     * 分页查询
     *
     * @param taskId
     * @param exeStatus 任务执行状态 1：未执行，2：执行中，3：执行结束（成功）4，执行结束（失败）
     * @param startAt
     * @param endAt
     * @param pageParam
     * @return
     */
    Page<ScTaskInstanceEntity> page(Long taskId, Integer exeStatus, LocalDateTime startAt, LocalDateTime endAt, PageParam pageParam);

}
