package com.shulian.safe.drm.module.dmap.controller.admin.ds;

import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.module.dmap.controller.BaseController;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaTableRetDTO;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaTableService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/26 11:08
 * @version: V1.0
 */
@Tag(name = "数据地图-数据表")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/meta/tb")
public class MetaTableController extends BaseController {

    @Resource
    private IMetaTableService metaTableService;

    @Operation(summary = "数据表-分页列表")
    @GetMapping("page")
    public CommonResult<PageResult<MetaTableRetDTO>> page(MetaTableRetDTO reqDTO,
                                                          PageParam pageParam) {
        PageResult<MetaTableRetDTO> page = metaTableService.page(reqDTO, pageParam);
        return CommonResult.success(page);
    }

}