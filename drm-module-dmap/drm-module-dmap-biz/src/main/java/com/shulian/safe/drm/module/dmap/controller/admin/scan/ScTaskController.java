package com.shulian.safe.drm.module.dmap.controller.admin.scan;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.controller.BaseController;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScTaskSaveReqDTO;
import com.shulian.safe.drm.module.dmap.entity.scan.ScTaskEntity;
import com.shulian.safe.drm.module.dmap.service.scan.IScTaskService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:35
 * @version: V1.0
 */
@Tag(name = "资产探查")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/sc/task")
public class ScTaskController extends BaseController {

    @Resource
    private IScTaskService scTaskService;


    @Operation(summary = "探查任务-分页查询")
    @GetMapping("page")
    @Parameters({
            @Parameter(name = "name", description = "任务名称", example = "1123"),
            @Parameter(name = "type", description = "任务类型 1-单次 2-周期", example = "1"),
            @Parameter(name = "status", description = "任务状态 1-正常 2-暂停", example = "1"),
    })
    public CommonResult<Page<ScTaskEntity>> page(@RequestParam(value = "name", required = false) String name,
                                                 @RequestParam(value = "type", required = false) Integer type,
                                                 @RequestParam(value = "status", required = false) Integer status,
                                                 PageParam pageParam) {
        Page<ScTaskEntity> page = scTaskService.page(name, type, status, pageParam);
        return CommonResult.success(page);
    }

    @PostMapping("create")
    @Operation(summary = "探查任务-创建探查任务")
    public CommonResult<Long> create(@Valid @RequestBody ScTaskSaveReqDTO reqDTO) {
        Long taskId = scTaskService.create(reqDTO);
        return CommonResult.success(taskId);
    }

    @Operation(summary = "探查任务-执行一次")
    @PutMapping("trigger/{id}")
    @Parameter(name = "id", description = "任务主键", example = "100")
    public CommonResult<Boolean> trigger(@PathVariable("id") Long id) {
        scTaskService.triggerJob(id);
        return CommonResult.success(true);
    }

    @Operation(summary = "探查任务-删除")
    @PutMapping("delete/{id}")
    @Parameter(name = "id", description = "任务主键", example = "100")
    public CommonResult<Boolean> delete(@PathVariable("id") Long id) {
        scTaskService.deleteTask(id);
        return CommonResult.success(true);
    }


    @Operation(summary = "探查任务-修改任务状态")
    @PutMapping("update/status")
    @Parameters({
            @Parameter(name = "id", description = "任务主键", example = "100"),
            @Parameter(name = "status", description = "任务状态 1-正常 2-暂停", example = "1"),
    })
    public CommonResult<Boolean> updateStatus(@RequestParam(value = "id") Long id,
                                              @RequestParam(value = "status") Integer status) {
        scTaskService.updateStatus(id, status);
        return CommonResult.success(true);
    }


    @Operation(summary = "探查任务-修改任务信息")
    @PostMapping("update")
    public CommonResult<Boolean> updateTask(@Valid @RequestBody ScTaskSaveReqDTO reqDTO) {
        scTaskService.updateTask(reqDTO);
        return CommonResult.success(true);
    }

    @Operation(summary = "探查任务-详情")
    @GetMapping("info")
    @Parameters({
            @Parameter(name = "id", description = "任务主键", example = "100"),
    })
    public CommonResult<ScTaskInfoDTO> queryTask(Long id) {
        ScTaskInfoDTO scTaskInfoDTO = scTaskService.queryTask(id);
        return CommonResult.success(scTaskInfoDTO);
    }


}
