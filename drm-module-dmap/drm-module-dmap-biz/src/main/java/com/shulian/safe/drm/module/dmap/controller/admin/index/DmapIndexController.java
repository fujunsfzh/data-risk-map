package com.shulian.safe.drm.module.dmap.controller.admin.index;

import com.shulian.safe.drm.framework.common.core.KeyValue;
import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import com.shulian.safe.drm.framework.common.util.AssertUtil;
import com.shulian.safe.drm.framework.common.util.date.DateUtils;
import com.shulian.safe.drm.module.dmap.controller.BaseController;
import com.shulian.safe.drm.module.dmap.dto.IndexDbTypeInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexPropertyRetDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexScanRetDTO;
import com.shulian.safe.drm.module.dmap.dto.IndexTotalRetDTO;
import com.shulian.safe.drm.module.dmap.service.index.IDmapIndexService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.time.LocalDate;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 14:23
 * @version: V1.0
 */
@Tag(name = "资产概览")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/dmap/index")
public class DmapIndexController extends BaseController {

    @Resource
    private IDmapIndexService mapIndexService;


    @GetMapping("queryDbService")
    @Operation(summary = "查询实例分布饼图")
    @Parameters({
            @Parameter(name = "type",
                    description = "engine-按引擎； env-按环境； app-按应用系统； source-按添加来源； person-按负责人",
                    example = "engine",
                    required = true),
    })
    public CommonResult<List<KeyValue>> queryDbService(@RequestParam(value = "type") String type) {
        List<KeyValue> ret = mapIndexService.queryDbService(type);
        return CommonResult.success(ret);
    }

    /**
     * 查询扫描指标
     *
     * @param begin 起始时间
     * @param end   结束时间
     * @return
     */
    @GetMapping("queryScan")
    @Operation(summary = "查询扫描指标")
    @Parameters({
            @Parameter(name = "begin", description = "开始日期", example = "2024-09-01", required = true),
            @Parameter(name = "end", description = "结束日期", example = "2024-09-30", required = true),
    })
    public CommonResult<IndexScanRetDTO> queryScan(@RequestParam("begin") String begin,
                                                   @RequestParam("end") String end) {
        IndexScanRetDTO ret = mapIndexService.queryScan(begin, end);
        return CommonResult.success(ret);
    }

    @GetMapping("queryDbTrend")
    @Operation(summary = "查询数据库资产总量每日的变化趋势")
    @Parameters({
            @Parameter(name = "begin", description = "开始时间", example = "2024-09-20", required = true),
            @Parameter(name = "end", description = "结束时间", example = "2024-09-30", required = true)
    })
    public CommonResult<List<KeyValue>> queryDbTrend(@RequestParam(value = "begin") @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY) LocalDate begin,
                                                     @RequestParam(value = "end") @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY) LocalDate end) {
        List<KeyValue> keyValues = mapIndexService.queryDbTrend(begin, end);
        return CommonResult.success(keyValues);
    }


    @GetMapping("queryDbTypeTrend")
    @Operation(summary = "查询数据库类型每日的变化趋势 [{'类型':[{'日期':'数据'}]}]")
    @Parameters({
            @Parameter(name = "begin", description = "开始时间", example = "2024-09-20", required = true),
            @Parameter(name = "end", description = "结束时间", example = "2024-09-30", required = true)
    })
    public CommonResult<List<KeyValue>> queryDbTypeTrend(@RequestParam(value = "begin") @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY) LocalDate begin,
                                                         @RequestParam(value = "end") @DateTimeFormat(pattern = DateUtils.FORMAT_YEAR_MONTH_DAY) LocalDate end) {
        List<KeyValue> keyValues = mapIndexService.queryDbTypeTrend(begin, end);
        return CommonResult.success(keyValues);
    }


    @GetMapping("queryTotal")
    @Operation(summary = "查询总数据量")
    public CommonResult<IndexTotalRetDTO> queryTotal() {
        IndexTotalRetDTO ret = mapIndexService.queryTotal();
        return CommonResult.success(ret);
    }


    @GetMapping("queryProperty")
    @Operation(summary = "查询资源概览数")
    public CommonResult<IndexPropertyRetDTO> queryProperty() {
        IndexPropertyRetDTO ret = mapIndexService.queryProperty();
        return CommonResult.success(ret);
    }

    @GetMapping("dsRatio")
    @Operation(summary = "数据库类别占比 饼图")
    public CommonResult<List<KeyValue>> dsRatio() {
        List<KeyValue> ret = mapIndexService.dsRatio();
        return CommonResult.success(ret);
    }


    @GetMapping("dbTypeTop5")
    @Operation(summary = "数据库统计Top5")
    public CommonResult<List<KeyValue>> dbTypeTop5() {
        List<KeyValue> keyValues = mapIndexService.dbTypeTop5();
        return CommonResult.success(keyValues);
    }

    @GetMapping("dbTypeInfo")
    @Operation(summary = "查询类型详情")
    @Parameters({
            @Parameter(name = "type", description = "数据库类型", example = "mysql", required = true)
    })
    public CommonResult<List<IndexDbTypeInfoDTO>> dbTypeInfo(@RequestParam("type") String type) {
        AssertUtil.isTrue(StringUtils.isNotBlank(type), "type 参数不能为空");
        List<IndexDbTypeInfoDTO> ret = mapIndexService.dbTypeInfo(type);
        return CommonResult.success(ret);
    }
}
