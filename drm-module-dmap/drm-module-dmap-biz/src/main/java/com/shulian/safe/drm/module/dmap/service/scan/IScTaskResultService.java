package com.shulian.safe.drm.module.dmap.service.scan;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;

import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:29
 * @version: V1.0
 */
public interface IScTaskResultService extends IService<ScTaskResultEntity> {

    /**
     * 分页查询
     *
     * @param taskId
     * @param instanceId
     * @param dsUrl
     * @param dsType
     * @param pageParam
     */
    Page<ScTaskResultEntity> page(Long taskId, String instanceId, String dsUrl, String dsType, PageParam pageParam);


    /**
     * 实例 id in 查询
     *
     * @param instanceIds
     * @return
     */
    List<ScTaskResultEntity> queryByInstanceIds(List<String> instanceIds);
}
