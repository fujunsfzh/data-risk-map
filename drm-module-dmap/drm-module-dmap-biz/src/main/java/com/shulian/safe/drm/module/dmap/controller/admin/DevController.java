package com.shulian.safe.drm.module.dmap.controller.admin;

import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.util.date.DateUtils;
import com.shulian.safe.drm.module.dmap.mq.RocketProducer;
import com.shulian.safe.drm.module.dmap.scheduler.MetaStatisticalTask;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.time.LocalDate;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/29 11:56
 * @version: V1.0
 */
@Tag(name = "开发工具")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/dev")
public class DevController {

    @Resource
    private MetaStatisticalTask metaStatisticalTask;

    /**
     * 触发统计任务
     *
     * @param bizDate
     * @return
     */
    @GetMapping("statistical")
    @Operation(summary = "触发统计任务")
    @Parameters({
            @Parameter(name = "bizDate", description = "要统计数据的日期", example = "2024-09-28", required = true)
    })
    public CommonResult<Boolean> statistical(@RequestParam(value = "bizDate") @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY) LocalDate bizDate) {
        metaStatisticalTask.doRun(bizDate);
        return CommonResult.success(true);
    }


    @Resource
    private RocketProducer producer;

    @GetMapping("send")
    public CommonResult send(String topic, String message, String messageKey, String tag) {
        producer.syncSend(topic, message, messageKey, tag);
        return CommonResult.success(true);
    }
}
