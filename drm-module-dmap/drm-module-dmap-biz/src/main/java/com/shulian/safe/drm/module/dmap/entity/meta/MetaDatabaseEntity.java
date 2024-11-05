package com.shulian.safe.drm.module.dmap.entity.meta;

import com.baomidou.mybatisplus.annotation.TableName;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 11:18
 * @version: V1.0
 */
@TableName(value = "ds_meta_database")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "资产-数据源实体")
public class MetaDatabaseEntity extends BaseEntity {

    @Schema(description = "数据源名称", example = "测试源")
    private String name;

    @Schema(description = "数据源类型", example = "mysql")
    private String dbType;

    @Schema(description = "连接主机", example = "10.0.0.12")
    private String dbHost;

    @Schema(description = "连接端口", example = " 3306")
    private Integer dbPort;

    @Schema(description = "数据库名称", example = "user_info")
    private String dbName;

    @Schema(description = "连接参数", example = "remarks=true")
    private String extParams;

    @Schema(description = "唯一标识", example = "uuid")
    private String dbMd5;

    @Schema(description = "连接用户名", example = "root")
    private String dbUser;

    @Schema(description = "连接密码", example = "123123123")
    // FIXME String类型，查询的时候没生效，BaseTypeHandler走的默认的 StringTypeHandle, 导致密码没解密，更新时又重复加密
    // @TableField(typeHandler = EncryptTypeHandler.class)
    private String dbPwd;

    @Schema(description = "oracle数据库连接方式 1-SERVICE_NAME，2-SID", example = "1")
    private Integer dboType;

    @Schema(description = "添加方式,MANUAL-手动添加,BATCH_IMPORT-批量导入,SCAN-自动扫描", example = "MANUAL")
    private String createType;

    @Schema(description = "应用系统名称", example = "ERP 系统")
    private String appName;

    @Schema(description = "系统环境:dev;test;pre;prod;", example = "dev")
    private String appEnv;

    @Schema(description = "应用联系人", example = "张三")
    private String appContact;

    @Schema(description = "联系电话", example = "123123123")
    private String appContactPhone;

    @Schema(description = "联系地址", example = "北京市海淀区")
    private String appContactAddress;

    @Schema(description = "状态:1-未同步;2-同步中;3-同步成功;4-同步失败", example = "2")
    private Integer status;

    @Schema(description = "版本号", example = "1")
    private String version;

    @Schema(description = "'扩展属性:连接字符串'", example = "北京市海淀区")
    private String dbConnUri;
}
