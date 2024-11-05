package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseRetDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaSchemaReqDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;

import java.util.List;
import java.util.Set;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 17:44
 * @version: V1.0
 */
public interface IMetaDatabaseService extends IService<MetaDatabaseEntity> {

    /**
     * 查询支持的数据源类型
     *
     * @return
     */
    List<String> querySupportedDbType();


    /**
     * 查询数据库下的所有库
     *
     * @param reqDTO
     * @return
     */
    Set<String> querySchemas(MetaSchemaReqDTO reqDTO);

    /**
     * 分页查询
     *
     * @return
     */
    Page<MetaDatabaseRetDTO> page(MetaDatabaseRetDTO reqDTO, PageParam pageParam);

    /**
     * 根据数据源类型查询数据源
     *
     * @param dbType
     * @return
     */
    List<MetaDatabaseRetDTO> queryByDbType(String dbType);

    /**
     * 查询详情
     *
     * @param dbId
     * @return
     */
    MetaDatabaseEntity queryInfo(Long dbId);

    /**
     * 删除数据源
     */
    void delete(Long dbId);

    /**
     * 保存数据源
     *
     * @param reqDTO
     * @return
     */
    Long createDb(MetaDatabaseSaveReqDTO reqDTO);

    /**
     * 修改数据源
     */
    void updateDB(MetaDatabaseSaveReqDTO reqDTO);


    /**
     * 同步元数据
     *
     * @param dbIds
     */
    void metaSync(List<Long> dbIds);

    /**
     * 校验数据源联通性
     *
     * @param databaseId 数据源主键
     */
    boolean validateConnection(Long databaseId);
}
