package com.shulian.safe.drm.module.dmap.service.index;

import com.shulian.safe.drm.framework.common.core.KeyValue;
import com.shulian.safe.drm.module.dmap.dto.IndexDbTypeInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexPropertyRetDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexScanRetDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexTotalRetDTO;

import java.time.LocalDate;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 14:21
 * @version: V1.0
 */
public interface IDmapIndexService {


    /**
     * 实例分布的饼图
     *
     * @param type engine-按引擎； env-按环境； app-按应用系统； souce-按添加来源； person-按负责人
     */
    List<KeyValue> queryDbService(String type);


    /**
     * 查询扫描指标
     *
     * @param begin 起始时间
     * @param end   结束时间
     * @return
     */
     IndexScanRetDTO queryScan(String begin, String end);

    /**
     * 查询数据库资产总量每日的变化趋势
     *
     * @param begin
     * @param end
     */
    List<KeyValue> queryDbTrend(LocalDate begin, LocalDate end);

    /**
     * 查询数据库类型每日的变化趋势
     *
     * @param begin
     * @param end
     */
    List queryDbTypeTrend(LocalDate begin, LocalDate end);

    /**
     * 查询总数据量
     */
    IndexTotalRetDTO queryTotal();


    /**
     * 查询资格概览数
     *
     * @return
     */
    IndexPropertyRetDTO queryProperty();


    /**
     * 数据库类别占比 饼图
     */
    List<KeyValue> dsRatio();


    /**
     * 数据库统计top5
     */
    List<KeyValue> dbTypeTop5();

    /**
     * 查询类别详情
     *
     * @param type
     * @return
     */
    List<IndexDbTypeInfoDTO> dbTypeInfo(String type);
}
