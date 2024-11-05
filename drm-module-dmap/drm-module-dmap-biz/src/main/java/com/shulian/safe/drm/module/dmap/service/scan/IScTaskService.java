package com.shulian.safe.drm.module.dmap.service.scan;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskSaveReqDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:29
 * @version: V1.0
 */
public interface IScTaskService extends IService<ScTaskEntity> {


    // /**
    //  * 根据任务和时间查询扫描结果
    //  *
    //  * @param taskId    任务主键
    //  * @param startTime 实例开始时间
    //  * @param endTime   实例结束时间
    //  * @return
    //  */
    // List<ScTaskResultEntity> queryResultByTask(Long taskId, LocalDateTime startTime, LocalDateTime endTime);

    /**
     * 创建探查任务
     *
     * @param reqDTO
     * @return
     */
    Long create(ScTaskSaveReqDTO reqDTO);

    /**
     * 删除任务
     *
     * @param id
     */
    void deleteTask(Long id);


    /**
     * 执行一次
     *
     * @param taskId
     */
    void triggerJob(Long taskId);

    /**
     * 更新任务
     *
     * @param reqDTO
     */
    void updateTask(ScTaskSaveReqDTO reqDTO);

    /**
     * 更新任务状态
     *
     * @param id
     * @param status
     */
    void updateStatus(Long id, Integer status);


    /**
     * 任务的详细信息
     *
     * @param id
     * @return
     */
    ScTaskInfoDTO queryTask(Long id);

    /**
     * 分页查询
     *
     * @param name
     * @param type
     * @param status
     * @param pageParam
     * @return
     */
    Page<ScTaskEntity> page(String name,Integer type, Integer status, PageParam pageParam);
}
