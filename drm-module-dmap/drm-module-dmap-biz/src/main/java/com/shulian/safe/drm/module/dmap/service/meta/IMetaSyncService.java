package com.shulian.safe.drm.module.dmap.service.meta;

import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.model.MetaTable;

import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/24 10:03
 * @version: V1.0
 */
public interface IMetaSyncService {

    /**
     * 根据数据源配置ID,查询元数据
     *
     * @param dataBase
     */
    List<MetaTable> getTableList(MetaDatabaseEntity dataBase);
}
