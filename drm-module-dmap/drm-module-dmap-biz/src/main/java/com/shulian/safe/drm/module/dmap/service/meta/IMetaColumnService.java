package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaColumnRetDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaColumnEntity;

import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/24 10:02
 * @version: V1.0
 */
public interface IMetaColumnService extends IService<MetaColumnEntity> {
    /**
     * 分页列表
     *
     * @param reqDTO
     * @param pageParam
     * @return
     */
    PageResult<MetaColumnRetDTO> page(MetaColumnRetDTO reqDTO, PageParam pageParam, boolean sample);

    /**
     * 分页列表
     *
     * @param reqDTO
     * @param pageParam
     * @return
     */
    PageResult<MetaColumnRetDTO> page(MetaColumnRetDTO reqDTO, PageParam pageParam);

    /**
     * 根据数据源ID删除
     *
     * @param dbId
     * @return
     */
    Integer deleteLogicByDbId(Long dbId);


    /**
     * 物理删除
     *
     * @param dbId
     * @return
     */
    void deleteByDbId(Long dbId);


    /**
     * 根据数据库 id 查询列数量
     *
     * @param dbIds
     * @return
     */
    Long queryCountByDbId(List<Long> dbIds);
}
