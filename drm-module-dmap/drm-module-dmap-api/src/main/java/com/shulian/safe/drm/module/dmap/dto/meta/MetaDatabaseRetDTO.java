package com.shulian.safe.drm.module.dmap.dto.meta;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/25 15:58
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "数据源返回实体")
public class MetaDatabaseRetDTO implements java.io.Serializable {

    @Schema(description = "主键", example = "123")
    private Long id;

    @Schema(description = "数据源名称", example = "测试源")
    private String name;

    @Schema(description = "数据源类型", example = "mysql")
    private String dbType;

    @Schema(description = "连接主机", example = "10.0.0.12")
    private String dbHost;

    @Schema(description = "连接端口", example = " 3306")
    private Integer dbPort;

    @Schema(description = "数据库名称", example = "userinfo")
    private String dbName;

    @Schema(description = "连接参数", example = "remarks=true")
    private String extParams;

    @Schema(description = "连接用户名", example = "root")
    private String dbUser;

    @Schema(description = "oracle数据库连接方式 1-SERVICE_NAME，2-SID", example = "1")
    private String dboType;

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

    @Schema(description = "创建人", example = "zhangsan")
    private String creator;

    @Schema(description = "部门", example = "001")
    private Long deptId;

    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    private LocalDateTime createTime;

    @Schema(description = "更新人", example = "zhangsan")
    private String updater;

    @Schema(description = "更新时间", example = "2024-09-18 16:00:38")
    private LocalDateTime updateTime;

    @Schema(description = "添加方式,MANUAL-手动添加,BATCH_IMPORT-批量导入,SCAN-自动扫描", example = "MANUAL")
    private String createType;
}
