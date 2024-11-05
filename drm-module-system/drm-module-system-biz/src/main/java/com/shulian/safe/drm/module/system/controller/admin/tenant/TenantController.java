package com.shulian.safe.drm.module.system.controller.admin.tenant;

import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import javax.annotation.security.PermitAll;
import static com.shulian.safe.drm.framework.common.pojo.CommonResult.success;

@Tag(name = "管理后台 - 租户")
@RestController
@RequestMapping("/system/tenant")
public class TenantController {

    @GetMapping("/get-id-by-name")
    @PermitAll
    @Operation(summary = "使用租户名，获得租户编号", description = "登录界面，根据用户的租户名，获得租户编号")
    @Parameter(name = "name", description = "租户名", required = true, example = "1024")
    public CommonResult getTenantIdByName(@RequestParam("name") String name) {
        return success(null);
    }

    @GetMapping("/get-by-website")
    @PermitAll
    @Operation(summary = "使用域名，获得租户信息", description = "登录界面，根据用户的域名，获得租户信息")
    @Parameter(name = "website", description = "域名", required = true, example = "www.iocoder.cn")
    public CommonResult getTenantByWebsite(@RequestParam("website") String website) {
        return success(null);
    }
}
