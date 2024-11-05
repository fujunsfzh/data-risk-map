package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaHisEntity;

import java.time.LocalDate;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 16:57
 * @version: V1.0
 */
public interface IMetaHisService extends IService<MetaHisEntity> {

    /**
     * 统计资产数据
     *
     * @param date 资产归属日期
     */
    void statistical(LocalDate bizDate);
}
