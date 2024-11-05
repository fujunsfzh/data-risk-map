package com.shulian.safe.drm.framework.mybatis.core.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseDO;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import com.shulian.safe.drm.framework.web.core.util.WebFrameworkUtils;
import org.apache.ibatis.reflection.MetaObject;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * 通用参数填充实现类
 * <p>
 * 如果没有显式的对通用参数进行赋值，这里会对通用参数进行填充、赋值
 *
 * @author hexiaowu
 */
public class DefaultDBFieldHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        if (Objects.nonNull(metaObject)) {
            Object originalObject = metaObject.getOriginalObject();
            if (originalObject instanceof BaseDO) {
                BaseDO baseDO = (BaseDO) originalObject;

                LocalDateTime current = LocalDateTime.now();
                // 创建时间为空，则以当前时间为插入时间
                if (Objects.isNull(baseDO.getCreateTime())) {
                    baseDO.setCreateTime(current);
                }
                // 更新时间为空，则以当前时间为更新时间
                if (Objects.isNull(baseDO.getUpdateTime())) {
                    baseDO.setUpdateTime(current);
                }

                Long userId = WebFrameworkUtils.getLoginUserId();
                // 当前登录用户不为空，创建人为空，则当前登录用户为创建人
                if (Objects.nonNull(userId) && Objects.isNull(baseDO.getCreator())) {
                    baseDO.setCreator(userId.toString());
                }
                // 当前登录用户不为空，更新人为空，则当前登录用户为更新人
                if (Objects.nonNull(userId) && Objects.isNull(baseDO.getUpdater())) {
                    baseDO.setUpdater(userId.toString());
                }
            } else if (originalObject instanceof BaseEntity) {
                BaseEntity entity = (BaseEntity) originalObject;
                LocalDateTime current = LocalDateTime.now();
                // 创建时间为空，则以当前时间为插入时间
                if (Objects.isNull(entity.getCreateTime())) {
                    entity.setCreateTime(current);
                }
                // 更新时间为空，则以当前时间为更新时间
                if (Objects.isNull(entity.getUpdateTime())) {
                    entity.setUpdateTime(current);
                }

                // 填充登录用户名
                String userName = WebFrameworkUtils.getLoginUserName();
                // 当前登录用户不为空，创建人为空，则当前登录用户为创建人
                if (Objects.nonNull(userName) && Objects.isNull(entity.getCreator())) {
                    entity.setCreator(userName);
                }
                // 当前登录用户不为空，更新人为空，则当前登录用户为更新人
                if (Objects.nonNull(userName) && Objects.isNull(entity.getUpdater())) {
                    entity.setUpdater(userName);
                }

                // 填充当前登录用户部门ID
                Long loginUserDeptId = WebFrameworkUtils.getLoginUserDeptId();
                if (Objects.nonNull(loginUserDeptId) && Objects.isNull(entity.getDeptId())) {
                    entity.setDeptId(loginUserDeptId);
                }
            }
        }
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        if (metaObject != null) {
            // 更新时间为空，则以当前时间为更新时间
            Object modifyTime = getFieldValByName("updateTime", metaObject);
            if (Objects.isNull(modifyTime)) {
                setFieldValByName("updateTime", LocalDateTime.now(), metaObject);
            }
            // 当前登录用户不为空，更新人为空，则当前登录用户为更新人
            Object modifier = getFieldValByName("updater", metaObject);
            if (Objects.isNull(modifier)) {
                // system do 和 其他业务 entity
                Object originalObject = metaObject.getOriginalObject();
                if (originalObject instanceof BaseDO) {
                    Long userId = WebFrameworkUtils.getLoginUserId();
                    if (Objects.nonNull(userId)) {
                        setFieldValByName("updater", userId.toString(), metaObject);
                    }
                } else if (originalObject instanceof BaseEntity) {
                    String loginUserName = WebFrameworkUtils.getLoginUserName();
                    if (Objects.nonNull(loginUserName)) {
                        setFieldValByName("updater", loginUserName, metaObject);
                    }
                }
            }
        }
    }
}
