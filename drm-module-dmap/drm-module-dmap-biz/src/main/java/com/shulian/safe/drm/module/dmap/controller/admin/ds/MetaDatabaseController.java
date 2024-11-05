package com.shulian.safe.drm.module.dmap.controller.admin.ds;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shulian.safe.drm.framework.apilog.core.annotation.ApiAccessLog;
import com.shulian.safe.drm.framework.apilog.core.enums.OperateTypeEnum;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.pojo.PageParam;
import com.shulian.safe.drm.module.dmap.controller.BaseController;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseRetDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaDatabaseSaveReqDTO;
import com.shulian.safe.drm.module.dmap.dto.meta.MetaSchemaReqDTO;
import com.shulian.safe.drm.module.dmap.entity.meta.MetaDatabaseEntity;
import com.shulian.safe.drm.module.dmap.service.meta.IMetaDatabaseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;
import java.util.Set;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 17:45
 * @version: V1.0
 */
@Tag(name = "数据地图-数据源")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/meta/ds")
public class MetaDatabaseController extends BaseController {

    @Resource
    private IMetaDatabaseService metaDatabaseService;

    @Operation(summary = "数据源-分页列表")
    @GetMapping("page")
    public CommonResult<Page<MetaDatabaseRetDTO>> page(MetaDatabaseRetDTO reqDTO,
                                                       PageParam pageParam) {
        Page<MetaDatabaseRetDTO> page = metaDatabaseService.page(reqDTO, pageParam);
        return CommonResult.success(page);
    }

    @PostMapping("schemas")
    @Operation(summary = "查询账号下所有库")
    @ApiAccessLog(operateType = OperateTypeEnum.GET, operateName = "查询账号下所有库")
    public CommonResult<Set<String>> schemas(@Valid @RequestBody MetaSchemaReqDTO reqDTO) {
        Set<String> schemaSet = metaDatabaseService.querySchemas(reqDTO);
        return CommonResult.success(schemaSet);
    }

    @PostMapping("create")
    @Operation(summary = "手动添加数据源")
    public CommonResult<Long> create(@Valid @RequestBody MetaDatabaseSaveReqDTO reqDTO) {
        Long dbId = metaDatabaseService.createDb(reqDTO);
        return CommonResult.success(dbId);
    }

    @GetMapping("sync")
    @Operation(summary = "手动同步元数据")
    @Parameters({
            @Parameter(name = "dbIds", description = "数据源主键", example = "100")
    })
    public CommonResult<Boolean> metaSync(@RequestParam("dbIds") List<Long> dbIds) {
        metaDatabaseService.metaSync(dbIds);
        return CommonResult.success(true);
    }

    @Operation(summary = "查询数据源详情")
    @GetMapping("info/{id}")
    @Parameter(name = "id", description = "数据源主键", example = "100")
    public CommonResult<MetaDatabaseEntity> queryInfo(@PathVariable("id") Long id) {
        MetaDatabaseEntity entity = metaDatabaseService.queryInfo(id);
        // 不回显密码
        entity.setDbPwd(null);
        return CommonResult.success(entity);
    }

    @PostMapping("update")
    @Operation(summary = "修改数据源")
    public CommonResult<Boolean> update(@Valid @RequestBody MetaDatabaseSaveReqDTO reqDTO) {
        metaDatabaseService.updateDB(reqDTO);
        return CommonResult.success(true);
    }


    @PutMapping("delete/{dbId}")
    @Operation(summary = "删除数据源")
    @Parameter(name = "dbId", description = "数据源主键", example = "100")
    public CommonResult<Boolean> delete(@PathVariable("dbId") Long dbId) {
        metaDatabaseService.delete(dbId);
        return CommonResult.success(true);
    }

    @GetMapping("supported/type")
    @Operation(summary = "查询支持的数据源类型")
    public CommonResult<List<String>> querySupportedDbType() {
        List<String> data = metaDatabaseService.querySupportedDbType();
        return CommonResult.success(data);
    }

    @GetMapping("byType")
    @Operation(summary = "根据数据源类型查数据源")
    @Parameter(name = "dbType", description = "数据源类型", example = "mysql")
    public CommonResult<List<MetaDatabaseRetDTO>> querySupportedDbType(@RequestParam(value = "dbType", required = false) String dbType) {
        List<MetaDatabaseRetDTO> list = metaDatabaseService.queryByDbType(dbType);
        return CommonResult.success(list);
    }

}
