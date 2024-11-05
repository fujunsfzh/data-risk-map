package com.shulian.safe.drm.module.dmap.controller;

import lombok.extern.slf4j.Slf4j;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Slf4j
public class BaseController {

    protected HttpServletRequest request;

    @Resource
    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }
}
