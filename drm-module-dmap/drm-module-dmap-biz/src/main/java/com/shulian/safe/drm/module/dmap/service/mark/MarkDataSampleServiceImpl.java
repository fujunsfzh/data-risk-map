package com.shulian.safe.drm.module.dmap.service.mark;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shulian.safe.drm.module.dmap.entity.mark.MarkDataSampleEntity;
import com.shulian.safe.drm.module.dmap.mapper.mark.IMarkDataSampleMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/18 11:22
 * @version: V1.0
 */
@Slf4j
@Service
public class MarkDataSampleServiceImpl extends ServiceImpl<IMarkDataSampleMapper, MarkDataSampleEntity> implements IMarkDataSampleService {


    /**
     * 查询样本数据
     *
     * @param tableId 表主键
     * @param colName 字段名称
     * @return
     */
    public List<String> queryList(Long tableId, String colName) {
        LambdaQueryWrapper<MarkDataSampleEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.select(MarkDataSampleEntity::getDataSample)
                .eq(MarkDataSampleEntity::getTableId, tableId)
                .eq(MarkDataSampleEntity::getColName, colName)
                .eq(MarkDataSampleEntity::getDeleted, false);
        queryWrapper.orderByDesc(MarkDataSampleEntity::getId);
        Page<MarkDataSampleEntity> page = baseMapper.selectPage(new Page<>(1, 5), queryWrapper);
        // fixme 脱敏
        return page.getRecords().stream().map(MarkDataSampleEntity::getDataSample).collect(Collectors.toList());
    }

}
