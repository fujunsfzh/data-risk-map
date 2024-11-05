package com.shulian.safe.drm.module.system.dal.mysql.notice;

import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.mybatis.core.mapper.BaseMapperX;
import com.shulian.safe.drm.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.shulian.safe.drm.module.system.controller.admin.notice.vo.NoticePageReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.notice.NoticeDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper extends BaseMapperX<NoticeDO> {

    default PageResult<NoticeDO> selectPage(NoticePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<NoticeDO>()
                .likeIfPresent(NoticeDO::getTitle, reqVO.getTitle())
                .eqIfPresent(NoticeDO::getStatus, reqVO.getStatus())
                .orderByDesc(NoticeDO::getId));
    }

}
