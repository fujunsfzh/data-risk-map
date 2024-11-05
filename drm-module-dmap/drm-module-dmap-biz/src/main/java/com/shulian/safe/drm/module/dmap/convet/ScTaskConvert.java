package com.shulian.safe.drm.module.dmap.convet;

import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskSaveRetDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskEntity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:29
 * @version: V1.0
 */
@Mapper
public interface ScTaskConvert {

    ScTaskConvert INSTANCE = Mappers.getMapper(ScTaskConvert.class);

    ScTaskEntity convert(ScTaskSaveReqDTO reqDTO);

    ScTaskSaveRetDTO convert(ScTaskEntity entity);

    ScTaskSaveReqDTO convertDiff(ScTaskEntity entity);

    ScTaskInfoDTO convertInfo(ScTaskEntity entity);

}
