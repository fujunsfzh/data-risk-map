package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaTableRetDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaTableEntity;
import com.shulian.safe.drm.module.dmap.model.MetaTable;

import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/24 10:02
 * @version: V1.0
 */
public interface IMetaTableService extends IService<MetaTableEntity> {

    /**
     * 分页列表
     *
     * @param reqDTO
     * @param pageParam
     * @return
     */
    PageResult<MetaTableRetDTO> page(MetaTableRetDTO reqDTO, PageParam pageParam);

    /**
     * 同步数据表
     *
     * @param dbId
     * @param tables
     */
    void syncTable(Long dbId, List<MetaTable> tables);


    /**
     * 根据数据源 Id，逻辑删除数据表
     *
     * @param dbId
     * @return
     */
    void deleteLogicByDbId(Long dbId);

    /**
     * 物理删除表列
     *
     * @param dbId
     */
    void deleteByDbId(Long dbId);


    /**
     * 查询 资产总数据量
     *
     * @return
     */
    Long queryIndexTotal();

    /**
     * 根据数据库 id 查询列数量
     *
     * @param dbIds
     * @return
     */
    Long queryCountByDbId(List<Long> dbIds);
}
