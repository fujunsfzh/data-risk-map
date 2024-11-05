package com.shulian.safe.drm.framework.quartz.core.util;

import cn.hutool.core.date.LocalDateTimeUtil;
import com.google.common.collect.Maps;
import com.shulian.safe.drm.framework.common.util.date.DateUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.quartz.CronExpression;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.*;

/**
 * Quartz Cron 表达式的工具类
 *
 * @author 系统源码
 */
@Slf4j
public class CronUtils {

    /**
     * 校验 CRON 表达式是否有效
     *
     * @param cronExpression CRON 表达式
     * @return 是否有效
     */
    public static boolean isValid(String cronExpression) {
        return CronExpression.isValidExpression(cronExpression);
    }

    /**
     * 基于 CRON 表达式，获得下 n 个满足执行的时间
     *
     * @param cronExpression CRON 表达式
     * @param n              数量
     * @return 满足条件的执行时间
     */
    public static List<LocalDateTime> getNextTimes(String cronExpression, int n) {
        // 1. 获得 CronExpression 对象
        CronExpression cron;
        try {
            cron = new CronExpression(cronExpression);
        } catch (ParseException e) {
            throw new IllegalArgumentException(e.getMessage());
        }
        // 2. 从当前开始计算，n 个满足条件的
        Date now = new Date();
        List<LocalDateTime> nextTimes = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            Date nextTime = cron.getNextValidTimeAfter(now);
            // 2.1 如果 nextTime 为 null，说明没有更多的有效时间，退出循环
            if (nextTime == null) {
                break;
            }
            nextTimes.add(LocalDateTimeUtil.of(nextTime));
            // 2.2 切换现在，为下一个触发时间；
            now = nextTime;
        }
        return nextTimes;
    }

    public static List<LocalDateTime> getNextFiveTime(String cron) {
        return CronUtils.getNextTimes(cron, 5);
    }

    /**
     * 基于 CRON 表达式，获得下 1 个满足执行的时间
     *
     * @param cronList
     * @return
     */
    public static Map<String, LocalDateTime> getNextTime(List<String> cronList) {
        Map<String, LocalDateTime> cronMap = Maps.newHashMap();
        if (CollectionUtils.isEmpty(cronList)) {
            return cronMap;
        }
        Date now = new Date();
        for (String cron : cronList) {
            Date nextTime = null;
            try {
                CronExpression cronExpression = new CronExpression(cron);
                nextTime = cronExpression.getNextValidTimeAfter(now);
                if (Objects.nonNull(nextTime)) {
                    cronMap.put(cron, LocalDateTimeUtil.of(nextTime));
                }
            } catch (ParseException e) {
                log.error("cron表达式错误", e);
            }
        }
        return cronMap;
    }

    /**
     * 根据当前时间和 cron，获取下次执行时间
     *
     * @param time
     * @param cron
     * @return
     */
    public static LocalDateTime getNextTime(LocalDateTime time, String cron) {
        if (StringUtils.isBlank(cron) || time == null) {
            return null;
        }
        CronExpression cronExpression = null;
        try {
            cronExpression = new CronExpression(cron);
        } catch (ParseException e) {
            log.error("cron表达式错误", e);
            return null;
        }
        Date nextTime = cronExpression.getNextValidTimeAfter(DateUtils.of(time));
        if (Objects.nonNull(nextTime)) {
            return LocalDateTimeUtil.of(nextTime);
        }
        return null;
    }

}