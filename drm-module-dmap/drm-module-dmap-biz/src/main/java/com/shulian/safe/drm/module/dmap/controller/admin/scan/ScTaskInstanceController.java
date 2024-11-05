package com.shulian.safe.drm.module.dmap.controller.admin.scan;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.util.date.DateUtils;
import com.shulian.safe.drm.module.dmap.controller.BaseController;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskInstanceEntity;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskInstanceService;
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
import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/19 18:00
 * @version: V1.0
 */
@Tag(name = "资产探查实例")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/sc/task/instance")
public class ScTaskInstanceController extends BaseController {

    @Resource
    private IScTaskInstanceService scTaskInstanceIdService;

    @Operation(summary = "探查任务实例-分页查询")
    @GetMapping("page")
    @Parameters({
            @Parameter(name = "taskId", description = "任务主键", example = "100"),
            @Parameter(name = "status", description = "任务状态", example = "任务执行状态 1：未执行，2：执行中，3：执行结束（成功）4，执行结束（失败）"),
            @Parameter(name = "startAt", description = "开始的时间点", example = "2024-07-19 18:06:04"),
            @Parameter(name = "endAt", description = "结束的时间点", example = "2024-09-19 18:06:08"),
    })
    public CommonResult<Page<ScTaskInstanceEntity>> page(@RequestParam(value = "taskId", required = false) Long taskId,
                                                         @RequestParam(value = "status", required = false) Integer exeStatus,
                                                         @RequestParam(value = "startAt", required = false) @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND) LocalDateTime startAt,
                                                         @RequestParam(value = "endAt", required = false) @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND) LocalDateTime endAt,
                                                         PageParam pageParam) {
        Page<ScTaskInstanceEntity> page = scTaskInstanceIdService.page(taskId, exeStatus, startAt, endAt, pageParam);
        return CommonResult.success(page);
    }


}
