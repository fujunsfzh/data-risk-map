package com.shulian.safe.drm.module.system.controller.admin.logger;

import com.shulian.safe.drm.framework.apilog.core.annotation.ApiAccessLog;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.common.util.object.BeanUtils;
import com.shulian.safe.drm.framework.excel.core.util.ExcelUtils;
import com.shulian.safe.drm.module.system.controller.admin.logger.vo.apiaccesslog.ApiAccessLogPageReqVO;
import com.shulian.safe.drm.module.system.controller.admin.logger.vo.apiaccesslog.ApiAccessLogRespVO;
import com.shulian.safe.drm.module.system.dal.dataobject.logger.ApiAccessLogDO;
import com.shulian.safe.drm.module.system.service.logger.ApiAccessLogService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

import static com.shulian.safe.drm.framework.apilog.core.enums.OperateTypeEnum.EXPORT;
import static com.shulian.safe.drm.framework.common.pojo.CommonResult.success;

@Tag(name = "管理后台 - API 访问日志")
@RestController
@RequestMapping("/infra/api-access-log")
@Validated
public class ApiAccessLogController {

    @Resource
    private ApiAccessLogService apiAccessLogService;

    @GetMapping("/page")
    @Operation(summary = "获得API 访问日志分页")
    @PreAuthorize("@ss.hasPermission('infra:api-access-log:query')")
    public CommonResult<PageResult<ApiAccessLogRespVO>> getApiAccessLogPage(@Valid ApiAccessLogPageReqVO pageReqVO) {
        PageResult<ApiAccessLogDO> pageResult = apiAccessLogService.getApiAccessLogPage(pageReqVO);
        return success(BeanUtils.toBean(pageResult, ApiAccessLogRespVO.class));
    }

    @GetMapping("/export-excel")
    @Operation(summary = "导出API 访问日志 Excel")
    @PreAuthorize("@ss.hasPermission('infra:api-access-log:export')")
    @ApiAccessLog(operateType = EXPORT)
    public void exportApiAccessLogExcel(@Valid ApiAccessLogPageReqVO exportReqVO,
                                        HttpServletResponse response) throws IOException {
        exportReqVO.setPageSize(PageParam.PAGE_SIZE_NONE);
        List<ApiAccessLogDO> list = apiAccessLogService.getApiAccessLogPage(exportReqVO).getList();
        // 导出 Excel
        ExcelUtils.write(response, "API 访问日志.xls", "数据", ApiAccessLogRespVO.class,
                BeanUtils.toBean(list, ApiAccessLogRespVO.class));
    }

}
