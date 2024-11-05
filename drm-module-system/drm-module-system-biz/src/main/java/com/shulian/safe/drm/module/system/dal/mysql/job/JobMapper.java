package com.shulian.safe.drm.module.system.dal.mysql.job;

import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.mybatis.core.mapper.BaseMapperX;
import com.shulian.safe.drm.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.shulian.safe.drm.module.system.controller.admin.job.vo.job.JobPageReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.job.JobDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 定时任务 Mapper
 *
 * @author 系统源码
 */
@Mapper
public interface JobMapper extends BaseMapperX<JobDO> {

    default JobDO selectByHandlerName(String handlerName) {
        return selectOne(JobDO::getHandlerName, handlerName);
    }

    default PageResult<JobDO> selectPage(JobPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<JobDO>()
                .likeIfPresent(JobDO::getName, reqVO.getName())
                .eqIfPresent(JobDO::getStatus, reqVO.getStatus())
                .likeIfPresent(JobDO::getHandlerName, reqVO.getHandlerName())
        );
    }

}
