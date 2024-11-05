package com.shulian.safe.drm.module.system.dal.mysql.demo.demo03;

import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.mybatis.core.mapper.BaseMapperX;
import com.shulian.safe.drm.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.shulian.safe.drm.module.system.dal.dataobject.demo.demo03.Demo03GradeDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 学生班级 Mapper
 *
 * @author 系统源码
 */
@Mapper
public interface Demo03GradeMapper extends BaseMapperX<Demo03GradeDO> {

    default PageResult<Demo03GradeDO> selectPage(PageParam reqVO, Long studentId) {
        return selectPage(reqVO, new LambdaQueryWrapperX<Demo03GradeDO>()
                .eq(Demo03GradeDO::getStudentId, studentId)
                .orderByDesc(Demo03GradeDO::getId));
    }

    default Demo03GradeDO selectByStudentId(Long studentId) {
        return selectOne(Demo03GradeDO::getStudentId, studentId);
    }

    default int deleteByStudentId(Long studentId) {
        return delete(Demo03GradeDO::getStudentId, studentId);
    }

}