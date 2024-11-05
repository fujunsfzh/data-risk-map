package com.shulian.safe.drm.module.system.dal.mysql.codegen;

import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.mybatis.core.mapper.BaseMapperX;
import com.shulian.safe.drm.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.shulian.safe.drm.module.system.controller.admin.codegen.vo.table.CodegenTablePageReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.codegen.CodegenTableDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CodegenTableMapper extends BaseMapperX<CodegenTableDO> {

    default CodegenTableDO selectByTableNameAndDataSourceConfigId(String tableName, Long dataSourceConfigId) {
        return selectOne(CodegenTableDO::getTableName, tableName,
                CodegenTableDO::getDataSourceConfigId, dataSourceConfigId);
    }

    default PageResult<CodegenTableDO> selectPage(CodegenTablePageReqVO pageReqVO) {
        return selectPage(pageReqVO, new LambdaQueryWrapperX<CodegenTableDO>()
                .likeIfPresent(CodegenTableDO::getTableName, pageReqVO.getTableName())
                .likeIfPresent(CodegenTableDO::getTableComment, pageReqVO.getTableComment())
                .likeIfPresent(CodegenTableDO::getClassName, pageReqVO.getClassName())
                .betweenIfPresent(CodegenTableDO::getCreateTime, pageReqVO.getCreateTime())
                .orderByDesc(CodegenTableDO::getUpdateTime)
        );
    }

    default List<CodegenTableDO> selectListByDataSourceConfigId(Long dataSourceConfigId) {
        return selectList(CodegenTableDO::getDataSourceConfigId, dataSourceConfigId);
    }

    default List<CodegenTableDO> selectListByTemplateTypeAndMasterTableId(Integer templateType, Long masterTableId) {
        return selectList(CodegenTableDO::getTemplateType, templateType,
                CodegenTableDO::getMasterTableId, masterTableId);
    }

}
