package com.shulian.safe.drm.module.system.dal.mysql.demo.demo01;

import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.mybatis.core.mapper.BaseMapperX;
import com.shulian.safe.drm.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.shulian.safe.drm.module.system.controller.admin.demo.demo01.vo.Demo01ContactPageReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.demo.demo01.Demo01ContactDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 示例联系人 Mapper
 *
 * @author 系统源码
 */
@Mapper
public interface Demo01ContactMapper extends BaseMapperX<Demo01ContactDO> {

    default PageResult<Demo01ContactDO> selectPage(Demo01ContactPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<Demo01ContactDO>()
                .likeIfPresent(Demo01ContactDO::getName, reqVO.getName())
                .eqIfPresent(Demo01ContactDO::getSex, reqVO.getSex())
                .betweenIfPresent(Demo01ContactDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(Demo01ContactDO::getId));
    }

}