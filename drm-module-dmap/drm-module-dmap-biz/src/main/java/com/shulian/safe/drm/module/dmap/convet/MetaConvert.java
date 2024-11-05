package com.shulian.safe.drm.module.dmap.convet;

import com.shulian.safe.drm.module.dmap.dto.meta.MetaColumnRetDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseRetDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaTableRetDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaColumnEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaTableEntity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 16:25
 * @version: V1.0
 */

@Mapper
public interface MetaConvert {

    MetaConvert INSTANCE = Mappers.getMapper(MetaConvert.class);

    MetaDatabaseEntity convert(MetaDatabaseSaveReqDTO reqDTO);

    MetaDatabaseSaveReqDTO convertSaveDTO(MetaDatabaseEntity entity);

    MetaDatabaseRetDTO convert(MetaDatabaseEntity entity);

    MetaTableRetDTO convert(MetaTableEntity entity);

    MetaColumnRetDTO convert(MetaColumnEntity entity);
}
