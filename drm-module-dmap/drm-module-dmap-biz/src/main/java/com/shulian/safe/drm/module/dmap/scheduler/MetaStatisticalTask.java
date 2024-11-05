package com.shulian.safe.drm.module.dmap.scheduler;

import com.shulian.safe.drm.module.dmap.common.DrmConstants;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaHisService;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * 添加资产统计
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 17:00
 * @version: V1.0
 */
@Slf4j
@Component
public class MetaStatisticalTask {

    @Resource
    private RedissonClient redissonClient;

    @Resource
    private IMetaHisService metaHisService;

    /**
     * 每天零点执行
     */
    @Scheduled(cron = "0 5 0 * * ?")
    // @Scheduled(cron = "0 0/2 * * * ?")     // 2分钟一次 测试
    public void statisticalTask() {
        doRun(null);
    }

    public void doRun(LocalDate bizDate) {
        // 资产归属日期
        if (bizDate == null) {
            bizDate = LocalDate.now().minusDays(1);
        }

        String bizStr = bizDate.format(DateTimeFormatter.BASIC_ISO_DATE);
        String lockKey = DrmConstants.MATE_HIS_STATISTICAL_LOCK + bizStr;

        RLock lock = redissonClient.getLock(lockKey);
        try {
            lock.lock();
            // 执行统计任务
            log.info("执行统计任务");
            // 资产归属前一天
            metaHisService.statistical(bizDate);
        } finally {
            lock.unlock();
        }
    }

}
