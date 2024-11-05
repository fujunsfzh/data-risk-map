package com.shulian.safe.drm.module.dmap.service.meta;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaHisEntity;
import com.shulian.safe.drm.module.dmap.mapper.meta.MetaHisMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 16:57
 * @version: V1.0
 */
@Slf4j
@Service
public class MetaHisServiceImpl extends ServiceImpl<MetaHisMapper, MetaHisEntity> implements IMetaHisService {

    @Resource
    private IMetaDatabaseService databaseService;


    /**
     * 统计资产数据
     *
     * @param bizDate 资产归属日期
     */
    @Transactional(rollbackFor = Exception.class)
    public void statistical(LocalDate bizDate) {
        // 统计日期 = 归属日期 +1 天
        LocalDate statisticalDate = bizDate.plusDays(1);

        LambdaQueryWrapper<MetaDatabaseEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaDatabaseEntity::getDeleted, false);
        // 创建时间小于当前时间
        queryWrapper.lt(MetaDatabaseEntity::getCreateTime, statisticalDate);
        List<MetaDatabaseEntity> list = databaseService.list(queryWrapper);

        Map<String, Long> typeMap = list.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getDbType, Collectors.counting()));

        List<MetaHisEntity> data = typeMap.entrySet().stream().map(e -> {
            String key = e.getKey();
            Long value = e.getValue();
            MetaHisEntity entity = new MetaHisEntity(bizDate, key, value);
            return entity;
        }).collect(Collectors.toList());

        // 删除指定日期统计的数据
        deleteByBizDate(bizDate);
        // 重新添加
        if (CollectionUtils.isNotEmpty(data)) {
            saveBatch(data);
        }
    }


    /**
     * 删除当天历史统计的数据
     *
     * @param bizDate
     */
    public void deleteByBizDate(LocalDate bizDate) {
        LambdaQueryWrapper<MetaHisEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MetaHisEntity::getStatisticalDate, bizDate);
        queryWrapper.eq(MetaHisEntity::getDeleted, false);
        remove(queryWrapper);
    }


}
