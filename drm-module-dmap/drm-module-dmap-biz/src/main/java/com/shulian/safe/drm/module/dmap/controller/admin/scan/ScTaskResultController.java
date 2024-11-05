package com.shulian.safe.drm.module.dmap.controller.admin.scan;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.controller.BaseController;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskResultEntity;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskResultService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/19 18:07
 * @version: V1.0
 */
@Tag(name = "资产探查结果")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/sc/task/result")
public class ScTaskResultController extends BaseController {

    @Resource
    private IScTaskResultService scTaskResultService;

    @Operation(summary = "探查结果-分页查询")
    @GetMapping("page")
    @Parameters({
            @Parameter(name = "taskId", description = "任务主键", example = "100"),
            @Parameter(name = "instanceId", description = "实例主键", example = "100"),
            @Parameter(name = "dsUrl", description = "连接URI", example = "10.0.0.100"),
            @Parameter(name = "dsType", description = "类型", example = "mysql"),
    })
    public CommonResult<Page<ScTaskResultEntity>> page(@RequestParam(value = "taskId", required = false) Long taskId,
                                                       @RequestParam(value = "instanceId", required = false) String instanceId,
                                                       @RequestParam(value = "dsUrl", required = false) String dsUrl,
                                                       @RequestParam(value = "dsType", required = false) String dsType,
                                                       PageParam pageParam) {

        Page<ScTaskResultEntity> page = scTaskResultService.page(taskId, instanceId, dsUrl, dsType, pageParam);
        return CommonResult.success(page);
    }

}
