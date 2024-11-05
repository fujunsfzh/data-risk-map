package com.shulian.safe.drm.module.dmap.mapper.meta;

import com.shulian.safe.drm.framework.mybatis.core.mapper.BaseMapperX;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:39
 * @version: V1.0
 */
public interface MetaDatabaseMapper extends BaseMapperX<MetaDatabaseEntity> {

    //
    // @Select(value = "select db_type,db_host,db_port,count(1) ct from ds_meta_database ds" +
    //         " where ds.deleted = 0 and db_type = #{dbType}" +
    //         " GROUP BY db_host,db_port" +
    //         " order by  ct desc")
    // List<IndexDbTypeInfoDTO> queryDsCount(String dbType);
}
