package com.shulian.safe.drm.module.dmap.config;

import com.shulian.safe.drm.framework.datapermission.core.rule.dept.DeptDataPermissionRuleCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 业务模块的数据权限 Configuration
 *
 * @author 系统源码
 */
@Configuration(proxyBeanMethods = false)
public class DataPermissionConfiguration {

    @Bean
    public DeptDataPermissionRuleCustomizer sysDeptDataPermissionRuleCustomizer() {
        return rule -> {
            // // dept
            // rule.addDeptColumn(AdminUserDO.class);
            // rule.addDeptColumn(DeptDO.class, "id");
            // // user
            // rule.addUserColumn(AdminUserDO.class, "id");
        };
    }

}
