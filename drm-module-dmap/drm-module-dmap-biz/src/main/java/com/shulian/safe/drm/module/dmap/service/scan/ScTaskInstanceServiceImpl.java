package com.shulian.safe.drm.module.dmap.service.scan;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.util.AssertUtil;
import com.shulian.safe.drm.module.dmap.dto.scan.ScanRetDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskInstanceEntity;
import com.shulian.safe.drm.module.dmap.mapper.scan.ScTaskInstanceMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

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
public class ScTaskInstanceServiceImpl
        extends ServiceImpl<ScTaskInstanceMapper, ScTaskInstanceEntity>
        implements IScTaskInstanceService {


    /**
     * 创建任务实例
     *
     * @param taskId
     * @return
     */
    public Long createByTaskId(Long taskId) {
        ScTaskInstanceEntity entity = new ScTaskInstanceEntity();
        entity.setTaskId(taskId);
        entity.setInstanceId(IdUtil.fastUUID());
        this.save(entity);
        return entity.getId();
    }

    //==============================================================================================

    /**
     * 更新任务实例
     *
     * @param id
     * @param exeStatus
     * @param scanRetDTO
     */
    public void updateByScanRet(Long id, Integer exeStatus, ScanRetDTO scanRetDTO) {
        ScTaskInstanceEntity entity = getById(id);
        AssertUtil.notNull(entity, "扫描任务实例不存在");

        entity.setExeStatus(exeStatus);
        if (scanRetDTO != null) {
            entity.setIpCount(scanRetDTO.getIpCount());
            entity.setHostsCount(scanRetDTO.getHostsCount());
            entity.setTakeTime(scanRetDTO.getTakeTime());
        }
        updateById(entity);
    }


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
    public Page<ScTaskInstanceEntity> page(Long taskId, Integer exeStatus, LocalDateTime startAt, LocalDateTime endAt, PageParam pageParam) {
        Page<ScTaskInstanceEntity> page = new Page<>(pageParam.getPageNo(), pageParam.getPageSize());

        LambdaQueryWrapper<ScTaskInstanceEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScTaskInstanceEntity::getDeleted, false);
        wrapper.eq(taskId != null, ScTaskInstanceEntity::getTaskId, taskId);
        wrapper.eq(exeStatus != null, ScTaskInstanceEntity::getExeStatus, exeStatus);
        wrapper.ge(startAt != null, ScTaskInstanceEntity::getCreator, startAt);
        wrapper.le(endAt != null, ScTaskInstanceEntity::getCreator, endAt);
        wrapper.orderByDesc(ScTaskInstanceEntity::getId);
        return page(page, wrapper);
    }


}
