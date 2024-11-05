package com.shulian.safe.drm.module.system.service.social;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.ObjUtil;
import cn.hutool.core.util.ReflectUtil;
import com.shulian.safe.drm.framework.common.enums.CommonStatusEnum;
import com.shulian.safe.drm.framework.common.pojo.PageResult;
import com.shulian.safe.drm.framework.common.util.http.HttpUtils;
import com.shulian.safe.drm.framework.common.util.object.BeanUtils;
import com.shulian.safe.drm.module.system.controller.admin.socail.vo.client.SocialClientPageReqVO;
import com.shulian.safe.drm.module.system.controller.admin.socail.vo.client.SocialClientSaveReqVO;
import com.shulian.safe.drm.module.system.dal.dataobject.social.SocialClientDO;
import com.shulian.safe.drm.module.system.dal.mysql.social.SocialClientMapper;
import com.shulian.safe.drm.module.system.enums.social.SocialTypeEnum;
import com.google.common.annotations.VisibleForTesting;
import com.xingyuv.jushauth.config.AuthConfig;
import com.xingyuv.jushauth.model.AuthCallback;
import com.xingyuv.jushauth.model.AuthResponse;
import com.xingyuv.jushauth.model.AuthUser;
import com.xingyuv.jushauth.request.AuthRequest;
import com.xingyuv.jushauth.utils.AuthStateUtils;
import com.xingyuv.justauth.AuthRequestFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Objects;
import static com.shulian.safe.drm.framework.common.exception.util.ServiceExceptionUtil.exception;
import static com.shulian.safe.drm.framework.common.util.json.JsonUtils.toJsonString;
import static com.shulian.safe.drm.module.system.enums.ErrorCodeConstants.*;

/**
 * 社交应用 Service 实现类
 *
 * @author 系统源码
 */
@Service
@Slf4j
public class SocialClientServiceImpl implements SocialClientService {

    /**
     * 小程序码要打开的小程序版本
     *
     * 1. release：正式版
     * 2. trial：体验版
     * 3. developer：开发版
     */
    @Value("${drm.wxa-code.env-version:release}")
    public String envVersion;
    /**
     * 订阅消息跳转小程序类型
     *
     * 1. developer：开发版
     * 2. trial：体验版
     * 3. formal：正式版
     */
    @Value("${drm.wxa-subscribe-message.miniprogram-state:formal}")
    public String miniprogramState;

    @Resource
    private AuthRequestFactory authRequestFactory;

    @Resource
    private StringRedisTemplate stringRedisTemplate; // WxMpService 需要使用到，所以在 Service 注入了它


    @Resource
    private SocialClientMapper socialClientMapper;

    @Override
    public String getAuthorizeUrl(Integer socialType, Integer userType, String redirectUri) {
        // 获得对应的 AuthRequest 实现
        AuthRequest authRequest = buildAuthRequest(socialType, userType);
        // 生成跳转地址
        String authorizeUri = authRequest.authorize(AuthStateUtils.createState());
        return HttpUtils.replaceUrlQuery(authorizeUri, "redirect_uri", redirectUri);
    }

    @Override
    public AuthUser getAuthUser(Integer socialType, Integer userType, String code, String state) {
        // 构建请求
        AuthRequest authRequest = buildAuthRequest(socialType, userType);
        AuthCallback authCallback = AuthCallback.builder().code(code).state(state).build();
        // 执行请求
        AuthResponse<?> authResponse = authRequest.login(authCallback);
        log.info("[getAuthUser][请求社交平台 type({}) request({}) response({})]", socialType,
                toJsonString(authCallback), toJsonString(authResponse));
        if (!authResponse.ok()) {
            throw exception(SOCIAL_USER_AUTH_FAILURE, authResponse.getMsg());
        }
        return (AuthUser) authResponse.getData();
    }

    /**
     * 构建 AuthRequest 对象，支持多租户配置
     *
     * @param socialType 社交类型
     * @param userType   用户类型
     * @return AuthRequest 对象
     */
    @VisibleForTesting
    AuthRequest buildAuthRequest(Integer socialType, Integer userType) {
        // 1. 先查找默认的配置项，从 application-*.yaml 中读取
        AuthRequest request = authRequestFactory.get(SocialTypeEnum.valueOfType(socialType).getSource());
        Assert.notNull(request, String.format("社交平台(%d) 不存在", socialType));
        // 2. 查询 DB 的配置项，如果存在则进行覆盖
        SocialClientDO client = socialClientMapper.selectBySocialTypeAndUserType(socialType, userType);
        if (client != null && Objects.equals(client.getStatus(), CommonStatusEnum.ENABLE.getStatus())) {
            // 2.1 构造新的 AuthConfig 对象
            AuthConfig authConfig = (AuthConfig) ReflectUtil.getFieldValue(request, "config");
            AuthConfig newAuthConfig = ReflectUtil.newInstance(authConfig.getClass());
            BeanUtil.copyProperties(authConfig, newAuthConfig);
            // 2.2 修改对应的 clientId + clientSecret 密钥
            newAuthConfig.setClientId(client.getClientId());
            newAuthConfig.setClientSecret(client.getClientSecret());
            if (client.getAgentId() != null) { // 如果有 agentId 则修改 agentId
                newAuthConfig.setAgentId(client.getAgentId());
            }
            // 2.3 设置会 request 里，进行后续使用
            ReflectUtil.setFieldValue(request, "config", newAuthConfig);
        }
        return request;
    }

    // =================== 微信公众号独有 ===================


    // =================== 微信小程序独有 ===================



    // =================== 客户端管理 ===================

    @Override
    public Long createSocialClient(SocialClientSaveReqVO createReqVO) {
        // 校验重复
        validateSocialClientUnique(null, createReqVO.getUserType(), createReqVO.getSocialType());

        // 插入
        SocialClientDO client = BeanUtils.toBean(createReqVO, SocialClientDO.class);
        socialClientMapper.insert(client);
        return client.getId();
    }

    @Override
    public void updateSocialClient(SocialClientSaveReqVO updateReqVO) {
        // 校验存在
        validateSocialClientExists(updateReqVO.getId());
        // 校验重复
        validateSocialClientUnique(updateReqVO.getId(), updateReqVO.getUserType(), updateReqVO.getSocialType());

        // 更新
        SocialClientDO updateObj = BeanUtils.toBean(updateReqVO, SocialClientDO.class);
        socialClientMapper.updateById(updateObj);
    }

    @Override
    public void deleteSocialClient(Long id) {
        // 校验存在
        validateSocialClientExists(id);
        // 删除
        socialClientMapper.deleteById(id);
    }

    private void validateSocialClientExists(Long id) {
        if (socialClientMapper.selectById(id) == null) {
            throw exception(SOCIAL_CLIENT_NOT_EXISTS);
        }
    }

    /**
     * 校验社交应用是否重复，需要保证 userType + socialType 唯一
     *
     * 原因是，不同端（userType）选择某个社交登录（socialType）时，需要通过 {@link #buildAuthRequest(Integer, Integer)} 构建对应的请求
     *
     * @param id         编号
     * @param userType   用户类型
     * @param socialType 社交类型
     */
    private void validateSocialClientUnique(Long id, Integer userType, Integer socialType) {
        SocialClientDO client = socialClientMapper.selectBySocialTypeAndUserType(
                socialType, userType);
        if (client == null) {
            return;
        }
        if (id == null // 新增时，说明重复
                || ObjUtil.notEqual(id, client.getId())) { // 更新时，如果 id 不一致，说明重复
            throw exception(SOCIAL_CLIENT_UNIQUE);
        }
    }

    @Override
    public SocialClientDO getSocialClient(Long id) {
        return socialClientMapper.selectById(id);
    }

    @Override
    public PageResult<SocialClientDO> getSocialClientPage(SocialClientPageReqVO pageReqVO) {
        return socialClientMapper.selectPage(pageReqVO);
    }

}
