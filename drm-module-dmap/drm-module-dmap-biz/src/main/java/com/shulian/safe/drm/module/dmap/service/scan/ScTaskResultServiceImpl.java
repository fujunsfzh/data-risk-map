package com.shulian.safe.drm.module.dmap.service.scan;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;
import com.shulian.safe.drm.module.dmap.mapper.scan.ScTaskResultMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;

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
public class ScTaskResultServiceImpl extends ServiceImpl<ScTaskResultMapper, ScTaskResultEntity> implements IScTaskResultService {


    /**
     * 分页查询
     *
     * @param taskId
     * @param instanceId
     * @param dsUrl
     * @param dsType
     * @param pageParam
     */
    public Page<ScTaskResultEntity> page(Long taskId, String instanceId, String dsUrl, String dsType, PageParam pageParam) {
        Page<ScTaskResultEntity> page = new Page(pageParam.getPageNo(), pageParam.getPageSize());

        LambdaQueryWrapper<ScTaskResultEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScTaskResultEntity::getDeleted, false);
        wrapper.eq(taskId != null, ScTaskResultEntity::getTaskId, taskId);
        wrapper.eq(instanceId != null, ScTaskResultEntity::getInstanceId, instanceId);
        wrapper.eq(StringUtils.isNotBlank(dsUrl), ScTaskResultEntity::getDsUrl, dsUrl);
        wrapper.eq(StringUtils.isNotBlank(dsType), ScTaskResultEntity::getDsType, dsType);
        wrapper.orderByDesc(ScTaskResultEntity::getId);
        return page(page, wrapper);
    }


    /**
     * 实例 id in 查询
     *
     * @param instanceIds
     * @return
     */
    public List<ScTaskResultEntity> queryByInstanceIds(List<String> instanceIds) {
        LambdaQueryWrapper<ScTaskResultEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScTaskResultEntity::getDeleted, false);
        wrapper.in(ScTaskResultEntity::getInstanceId, instanceIds);
        wrapper.orderByDesc(ScTaskResultEntity::getId);
        return baseMapper.selectList(wrapper);
    }

}
