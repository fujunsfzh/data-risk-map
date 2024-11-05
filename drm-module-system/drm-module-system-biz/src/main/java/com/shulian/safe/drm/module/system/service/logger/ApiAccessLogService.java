package com.shulian.safe.drm.module.system.service.logger;


import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.module.system.api.logger.dto.ApiAccessLogCreateReqDTO;
import com.shulian.safe.drm.module.system.controller.admin.logger.vo.apiaccesslog.ApiAccessLogPageReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.logger.ApiAccessLogDO;

/**
 * API 访问日志 Service 接口
 *
 * @author 系统源码
 */
public interface ApiAccessLogService {

    /**
     * 创建 API 访问日志
     *
     * @param createReqDTO API 访问日志
     */
    void createApiAccessLog(ApiAccessLogCreateReqDTO createReqDTO);

    /**
     * 获得 API 访问日志分页
     *
     * @param pageReqVO 分页查询
     * @return API 访问日志分页
     */
    PageResult<ApiAccessLogDO> getApiAccessLogPage(ApiAccessLogPageReqVO pageReqVO);

    /**
     * 清理 exceedDay 天前的访问日志
     *
     * @param exceedDay 超过多少天就进行清理
     * @param deleteLimit 清理的间隔条数
     */
    Integer cleanAccessLog(Integer exceedDay, Integer deleteLimit);

}
