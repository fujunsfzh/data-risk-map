package com.shulian.safe.drm.module.system.service.logger;

import cn.hutool.core.util.StrUtil;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.common.util.object.BeanUtils;
import com.shulian.safe.drm.module.system.api.logger.dto.ApiAccessLogCreateReqDTO;
import com.shulian.safe.drm.module.system.controller.admin.logger.vo.apiaccesslog.ApiAccessLogPageReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.logger.ApiAccessLogDO;
import com.shulian.safe.drm.module.system.dal.mysql.logger.ApiAccessLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import java.time.LocalDateTime;

import static com.shulian.safe.drm.module.system.dal.dataobject.logger.ApiAccessLogDO.REQUEST_PARAMS_MAX_LENGTH;
import static com.shulian.safe.drm.module.system.dal.dataobject.logger.ApiAccessLogDO.RESULT_MSG_MAX_LENGTH;

/**
 * API 访问日志 Service 实现类
 *
 * @author 系统源码
 */
@Slf4j
@Service
@Validated
public class ApiAccessLogServiceImpl implements ApiAccessLogService {

    @Resource
    private ApiAccessLogMapper apiAccessLogMapper;

    @Override
    public void createApiAccessLog(ApiAccessLogCreateReqDTO createDTO) {
        ApiAccessLogDO apiAccessLog = BeanUtils.toBean(createDTO, ApiAccessLogDO.class);
        apiAccessLog.setRequestParams(StrUtil.maxLength(apiAccessLog.getRequestParams(), REQUEST_PARAMS_MAX_LENGTH));
        apiAccessLog.setResultMsg(StrUtil.maxLength(apiAccessLog.getResultMsg(), RESULT_MSG_MAX_LENGTH));
        // if (TenantContextHolder.getTenantId() != null) {
            apiAccessLogMapper.insert(apiAccessLog);
        // } else {
        //     // 极端情况下，上下文中没有租户时，此时忽略租户上下文，避免插入失败！
        //     TenantUtils.executeIgnore(() -> apiAccessLogMapper.insert(apiAccessLog));
        // }
    }

    @Override
    public PageResult<ApiAccessLogDO> getApiAccessLogPage(ApiAccessLogPageReqVO pageReqVO) {
        return apiAccessLogMapper.selectPage(pageReqVO);
    }

    @Override
    @SuppressWarnings("DuplicatedCode")
    public Integer cleanAccessLog(Integer exceedDay, Integer deleteLimit) {
        int count = 0;
        LocalDateTime expireDate = LocalDateTime.now().minusDays(exceedDay);
        // 循环删除，直到没有满足条件的数据
        for (int i = 0; i < Short.MAX_VALUE; i++) {
            int deleteCount = apiAccessLogMapper.deleteByCreateTimeLt(expireDate, deleteLimit);
            count += deleteCount;
            // 达到删除预期条数，说明到底了
            if (deleteCount < deleteLimit) {
                break;
            }
        }
        return count;
    }

}
