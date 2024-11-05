package com.shulian.safe.drm.module.dmap.controller.admin;

import com.shulian.safe.drm.framework.common.pojo.CommonResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.security.PermitAll;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Simple to Introduction
 *
 * @author: wangfj
 * @version: V1.0
 */
@Tag(name = "风险地图 - 测试")
@Slf4j
@Valid
@RestController
@RequestMapping("v1/dm/dev")
public class Controller {

    private static AtomicInteger counter = new AtomicInteger();

    @PermitAll
    @Operation(summary = "ping")
    @GetMapping(path = "ping")
    public CommonResult<Integer> ping(HttpServletRequest request) {
        return CommonResult.success(counter.incrementAndGet());
    }

    @PermitAll
    @Operation(summary = "pong")
    @PostMapping(path = "pong")
    public CommonResult<Integer> pong(HttpServletRequest request) {
        return CommonResult.success(counter.incrementAndGet());
    }

}
