package com.shulian.safe.drm.module.dmap.service.mark;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.module.dmap.entity.mark.MarkDataSampleEntity;

import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/18 11:21
 * @version: V1.0
 */
public interface IMarkDataSampleService extends IService<MarkDataSampleEntity> {

    /**
     * 查询样本数据
     *
     * @param tableId 表主键
     * @param colName 字段名称
     * @return
     */
    List<String> queryList(Long tableId, String colName);


}
