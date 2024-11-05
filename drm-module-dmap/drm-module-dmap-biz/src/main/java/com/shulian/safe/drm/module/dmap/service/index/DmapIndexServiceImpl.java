package com.shulian.safe.drm.module.dmap.service.index;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.shulian.safe.drm.framework.common.core.KeyValue;
import com.shulian.safe.drm.framework.common.util.AssertUtil;
import com.shulian.safe.drm.module.dmap.dto.IndexDbTypeInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexPropertyRetDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexScanRetDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexTotalRetDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaColumnEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaHisEntity;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaTableEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskInstanceEntity;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;
import com.shulian.safe.drm.module.dmap.model.DsCreateTypeEnum;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaColumnService;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaDatabaseService;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaHisService;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaTableService;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskInstanceService;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskResultService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 数据资产视图 指标概览
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 10:09
 * @version: V1.0
 */
@Slf4j
@Service
public class DmapIndexServiceImpl implements IDmapIndexService {

    @Resource
    private IMetaDatabaseService databaseService;

    @Resource
    private IMetaTableService tableService;

    @Resource
    private IMetaColumnService columnService;

    @Resource
    private IMetaHisService hisService;

    @Resource
    private IScTaskInstanceService taskInstanceService;

    @Resource
    private IScTaskResultService taskResultService;


    /**
     * 实例分布的饼图
     *
     * @param type engine-按引擎； env-按环境； app-按应用系统； souce-按添加来源； person-按负责人
     */
    public List<KeyValue> queryDbService(String type) {
        List<KeyValue> ret = Lists.newArrayList();
        switch (type) {
            case "engine":
                // 按照类型查询
                ret = queryByEngine();
                break;
            case "env":
                // 按环境
                ret = queryByEnv();
                break;
            case "app":
                // 按应用系统
                ret = queryByApp();
                break;
            case "source":
                // 按添加来源
                ret = queryByCreateType();
                break;
            case "person":
                // 按负责人
                ret = queryByChargePerson();
                break;
            default:
                // 默认 按类型
                ret = queryByEngine();
                break;
        }
        return ret;
    }


    /**
     * 按负责人
     */
    private List<KeyValue> queryByChargePerson() {
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        // 按负责人
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getAppContact, Collectors.counting()));
        List<KeyValue> ret = dsMap.entrySet().stream().map(e -> {
            return new KeyValue(e.getKey(), e.getValue());
        }).collect(Collectors.toList());
        return ret;
    }

    /**
     * 按添加方式（来源）
     */
    private List<KeyValue> queryByCreateType() {
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        // 按应用系统
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getCreateType, Collectors.counting()));
        List<KeyValue> ret = dsMap.entrySet().stream()
                .map(e -> {
                    String createType = e.getKey();
                    DsCreateTypeEnum createTypeEnum = DsCreateTypeEnum.getByValue(createType);
                    return new KeyValue(createTypeEnum.getText(), e.getValue());
                })
                .collect(Collectors.toList());
        return ret;
    }

    /**
     * 按应用系统
     */
    private List<KeyValue> queryByApp() {
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        // 按应用系统
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getAppName, Collectors.counting()));
        List<KeyValue> ret = dsMap.entrySet().stream()
                .map(e -> new KeyValue(e.getKey(), e.getValue()))
                .collect(Collectors.toList());
        return ret;
    }


    /**
     * 按环境
     */
    private List<KeyValue> queryByEnv() {
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        // 环境
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getAppEnv, Collectors.counting()));
        List<KeyValue> ret = dsMap.entrySet().stream()
                .map(e -> new KeyValue(e.getKey(), e.getValue()))
                .collect(Collectors.toList());
        return ret;
    }

    /**
     * 按类型
     */
    private List<KeyValue> queryByEngine() {
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        // 按类型
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getDbType, Collectors.counting()));
        List<KeyValue> ret = dsMap.entrySet().stream()
                .map(e -> new KeyValue(e.getKey(), e.getValue()))
                .collect(Collectors.toList());
        return ret;
    }


    /**
     * 查询扫描指标
     *
     * @param begin 起始时间
     * @param end   结束时间
     * @return
     */
    public IndexScanRetDTO queryScan(String begin, String end) {
        AssertUtil.isTrue(StringUtils.isNotBlank(begin), "开始日期不能为空");
        AssertUtil.isTrue(StringUtils.isNotBlank(end), "开始日期不能为空");
        AssertUtil.isTrue(end.compareTo(begin) >= 0, "日期不合法");

        List<ScTaskInstanceEntity> instanceList = taskInstanceService.list(new LambdaQueryWrapper<ScTaskInstanceEntity>()
                .eq(ScTaskInstanceEntity::getDeleted, false)
                .ge(ScTaskInstanceEntity::getCreateTime, begin)
                .le(ScTaskInstanceEntity::getCreateTime, end)
        );

        // 总扫描的IP数
        Long ipCount = instanceList.stream()
                .filter(Objects::nonNull)
                .mapToLong(instance -> Optional.ofNullable(instance.getIpCount()).orElse(0))
                .sum();

        // 数据库服务
        List<String> instanceIdList = instanceList.stream().map(ScTaskInstanceEntity::getInstanceId).collect(Collectors.toList());
        // 无任务实例,则返回
        if (CollectionUtils.isEmpty(instanceIdList)) {
            return new IndexScanRetDTO(ipCount, 0L, Lists.newArrayList());
        }

        // List<ScTaskResultEntity> resultList = taskResultService.list(new LambdaQueryWrapper<ScTaskResultEntity>()
        //         .eq(ScTaskResultEntity::getDeleted, false)
        //         .in(ScTaskResultEntity::getInstanceId, instanceIdList)
        // );
        /**
         * in 查询效率低，修改了扫描任务逻辑
         */
        // 查询任务结果
        QueryWrapper<ScTaskResultEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("distinct ds_url, ds_port");
        queryWrapper.lambda().eq(ScTaskResultEntity::getDeleted, false)
                .ge(ScTaskResultEntity::getCreateTime, begin)
                .le(ScTaskResultEntity::getCreateTime, end);
        // 排序
        queryWrapper.lambda().orderByAsc(ScTaskResultEntity::getDsUrl, ScTaskResultEntity::getDsPort);
        List<ScTaskResultEntity> resultList = taskResultService.list(queryWrapper);

        // 数据库服务数
        Long dataServiceCount = (long) resultList.size();

        // 按 ip，查看 ip 内的服务数
        Map<String, Long> dsUrlMap = resultList.stream().collect(Collectors.groupingBy(ScTaskResultEntity::getDsUrl, LinkedHashMap::new, Collectors.counting()));
        List<KeyValue<String, String>> dataServiceList = Lists.newArrayList();
        dsUrlMap.entrySet().forEach(e -> {
            // ip
            String key = e.getKey();
            // 端口个数
            Long value = e.getValue();
            dataServiceList.add(new KeyValue(key, String.valueOf(value)));
        });

        return new IndexScanRetDTO(ipCount, dataServiceCount, dataServiceList);
    }

    /**
     * 查询数据库资产总量每日的变化趋势
     *
     * @param begin
     * @param end
     */
    @Override
    public List<KeyValue> queryDbTrend(LocalDate begin, LocalDate end) {
        AssertUtil.notNull(begin, "开始日期不能为空");
        AssertUtil.notNull(end, "开始日期不能为空");
        AssertUtil.isTrue(end.isAfter(begin), "日期不合法");

        List<MetaHisEntity> list = hisService.list(
                new LambdaQueryWrapper<MetaHisEntity>()
                        .eq(MetaHisEntity::getDeleted, false)
                        .ge(MetaHisEntity::getStatisticalDate, begin)
                        .le(MetaHisEntity::getStatisticalDate, end)
        );

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Map<String, Long> map = list.stream().collect(Collectors.groupingBy(
                e -> dtf.format(e.getStatisticalDate()), Collectors.summingLong(e -> e.getDbCount())));

        List<KeyValue> ret = Lists.newArrayList();
        // 计算日期差值
        long daysBetween = ChronoUnit.DAYS.between(begin, end);
        for (int i = 0; i <= daysBetween; i++) {
            LocalDate date = begin.plusDays(i);
            String dataKey = dtf.format(date);
            // 指定日期有数据 则取数据 否则取0
            if (map.containsKey(dataKey)) {
                Long val = map.get(dataKey);
                ret.add(new KeyValue(dataKey, val));
            } else {
                ret.add(new KeyValue(dataKey, 0L));
            }
        }
        return ret;
    }

    private void checkParam() {
    }

    /**
     * 查询数据库类型每日的变化趋势
     *
     * @param begin
     * @param end
     */
    @Override
    public List queryDbTypeTrend(LocalDate begin, LocalDate end) {
        AssertUtil.notNull(begin, "开始日期不能为空");
        AssertUtil.notNull(end, "开始日期不能为空");
        AssertUtil.isTrue(end.isAfter(begin), "日期不合法");

        List<MetaHisEntity> list = hisService.list(
                new LambdaQueryWrapper<MetaHisEntity>()
                        .eq(MetaHisEntity::getDeleted, false)
                        .ge(MetaHisEntity::getStatisticalDate, begin)
                        .le(MetaHisEntity::getStatisticalDate, end)
        );

        // 计算日期差值
        long daysBetween = ChronoUnit.DAYS.between(begin, end);
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 按类型分组
        Map<String, List<MetaHisEntity>> typeMap = list.stream().collect(Collectors.groupingBy(MetaHisEntity::getDbType));

        // 要返回的数据 key-类型，val-数据List
        List<KeyValue> ret = Lists.newArrayList();
        typeMap.entrySet().forEach(e -> {
            // 数据库的类型
            String key = e.getKey();
            List<MetaHisEntity> value = e.getValue();
            // 再按日期分组
            Map<String, Long> statisticalMap = value.stream()
                    .collect(Collectors.toMap(t -> dtf.format(t.getStatisticalDate()), MetaHisEntity::getDbCount));
            // 执行类型，执行日期的数据
            List<KeyValue> dataList = Lists.newArrayList();
            // 填充日期数据
            for (int i = 0; i <= daysBetween; i++) {
                LocalDate date = begin.plusDays(i);
                String dataKey = dtf.format(date);
                // 指定日期有数据 则取数据 否则取0
                if (statisticalMap.containsKey(dataKey)) {
                    Long val = statisticalMap.get(dataKey);
                    dataList.add(new KeyValue(dataKey, val));
                } else {
                    dataList.add(new KeyValue(dataKey, 0L));
                }
            }
            ret.add(new KeyValue(key, dataList));
        });
        return ret;
    }


    /**
     * 查询总数据量
     */
    @Override
    public IndexTotalRetDTO queryTotal() {
        Long indexTotal = tableService.queryIndexTotal();
        return new IndexTotalRetDTO(indexTotal, null);
    }


    /**
     * 查询资格概览数
     *
     * @return
     */
    @Override
    public IndexPropertyRetDTO queryProperty() {
        // 数据库数
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        // 数据表数
        long tableCount = tableService.count(new LambdaQueryWrapper<MetaTableEntity>().eq(MetaTableEntity::getDeleted, false));
        // 字段数
        long columnCount = columnService.count(new LambdaQueryWrapper<MetaColumnEntity>().eq(MetaColumnEntity::getDeleted, false));

        // 数据源数
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(e -> e.getDbHost() + ":" + e.getDbPort(), Collectors.counting()));
        long dsCount = dsMap.size();

        return IndexPropertyRetDTO.builder()
                .dsCount(dsCount)
                .dbCount((long) dbList.size())
                .tbCount(tableCount)
                .coCount(columnCount)
                .build();
    }


    /**
     * 数据库类别占比 饼图
     */
    @Override
    public List<KeyValue> dsRatio() {
        // 数据库数
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        Map<String, Long> typeMap = dbList.stream().collect(Collectors.groupingBy(MetaDatabaseEntity::getDbType, Collectors.counting()));
        return typeMap.entrySet().stream().map(e -> new KeyValue(e.getKey(), e.getValue())).collect(Collectors.toList());
    }


    /**
     * 数据库统计top5
     */
    @Override
    public List<KeyValue> dbTypeTop5() {
        // 数据库数据
        List<MetaDatabaseEntity> dbList = databaseService.list(new LambdaQueryWrapper<MetaDatabaseEntity>().eq(MetaDatabaseEntity::getDeleted, false));
        Map<String, Long> typeMap = dbList.stream().collect(Collectors.toMap(MetaDatabaseEntity::getDbType, e -> 1L, Long::sum));
        // 根据value 降序排序
        // MapUtil.sortByValue(typeMap, true);
        LinkedHashMap<String, Long> lMap = new LinkedHashMap<>();
        Comparator<Map.Entry<String, Long>> entryComparator = Map.Entry.comparingByValue();
        // 降序
        entryComparator = entryComparator.reversed();
        typeMap.entrySet().stream().sorted(entryComparator).limit(5).forEachOrdered(e -> lMap.put(e.getKey(), e.getValue()));

        return lMap.entrySet().stream().map(e -> new KeyValue(e.getKey(), e.getValue())).collect(Collectors.toList());

    }

    /**
     * 查询类别详情
     *
     * @param type
     * @return
     */
    @Override
    public List<IndexDbTypeInfoDTO> dbTypeInfo(String type) {
        // 数据库数据
        List<MetaDatabaseEntity> dbList = databaseService.list(
                new LambdaQueryWrapper<MetaDatabaseEntity>()
                        .eq(MetaDatabaseEntity::getDeleted, false)
                        .eq(MetaDatabaseEntity::getDbType, type));
        // 统计 host:port 数量
        Map<String, Long> dsMap = dbList.stream().collect(Collectors.groupingBy(e -> e.getDbHost() + ":" + e.getDbPort(), Collectors.counting()));
        // 降序排序<主机+端口,数据库个数>
        Map<String, Long> hostCountMap = MapUtil.sortByValue(dsMap, true);
        // 降序排序<主机+端口, db的ids>
        Map<String, List<Long>> hostIdMap = dbList.stream().collect(
                Collectors.toMap(e -> e.getDbHost() + ":" + e.getDbPort(),
                        e -> Lists.newArrayList(e.getId()),
                        (List<Long> o, List<Long> n) -> {
                            o.addAll(n);
                            return o;
                        })
        );

        List<IndexDbTypeInfoDTO> ret = Lists.newArrayList();

        hostCountMap.entrySet().forEach(e -> {
            String key = e.getKey();
            Long dbCount = e.getValue();

            List<Long> dbIds = hostIdMap.get(key);
            Long tbCount = tableService.queryCountByDbId(dbIds);
            Long coCount = columnService.queryCountByDbId(dbIds);

            String[] split = key.split(":");

            IndexDbTypeInfoDTO infoDTO = new IndexDbTypeInfoDTO();
            infoDTO.setType(type)
                    .setDbHost(split[0])
                    .setDbPort(Integer.valueOf(split[1]))
                    .setDbCount(dbCount)
                    .setTbCount(tbCount)
                    .setCoCount(coCount);
            ret.add(infoDTO);
        });
        return ret;
    }

}
