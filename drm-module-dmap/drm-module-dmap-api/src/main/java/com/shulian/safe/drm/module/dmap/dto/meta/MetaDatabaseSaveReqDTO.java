package com.shulian.safe.drm.module.dmap.dto.meta;

import com.mzt.logapi.starter.annotation.DiffLogField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:48
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "数据源保存 DTO")
public class MetaDatabaseSaveReqDTO implements Serializable {

    @Schema(description = "主键", example = "1")
    private Long id;

    @NotBlank(message = "数据源名称不可为空")
    @Schema(description = "数据源名称", example = "测试源")
    @DiffLogField(name = "数据源名称")
    private String name;

    @NotBlank(message = "数据源类型不可为空")
    @Schema(description = "数据源类型", example = "mysql")
    @DiffLogField(name = "数据源类型")
    private String dbType;

    @NotBlank(message = "主机不可为空")
    @Schema(description = "连接主机", example = "10.0.0.12")
    @DiffLogField(name = "连接主机")
    private String dbHost;

    @NotNull(message = "连接端口不可为空")
    @Schema(description = "连接端口", example = " 3306")
    @DiffLogField(name = "连接端口")
    private Integer dbPort;

    // @NotBlank(message = "数据库名称不可为空")
    // @Schema(description = "数据库名称", example = "user_info")
    // private String dbName;

    @NotEmpty(message = "数据库名称不可为空")
    @Schema(description = "数据库名称", example = "user_info")
    @DiffLogField(name = "数据库名称")
    private List<String> dbNameList;

    @Schema(description = "连接参数", example = "remarks=true")
    @DiffLogField(name = "连接参数")
    private String extParams;

    @NotBlank(message = "用户名不可为空")
    @Schema(description = "连接用户名", example = "root")
    @DiffLogField(name = "连接用户名")
    private String dbUser;

    @NotBlank(message = "连接密码不可为空")
    @Schema(description = "连接密码", example = "123123123")
    private String dbPwd;

    @Schema(description = "oracle数据库连接方式 1-SERVICE_NAME，2-SID", example = "1")
    @DiffLogField(name = "oracle数据库连接方式")
    private Integer dboType;

    @NotBlank(message = "应用系统名称不可为空")
    @Schema(description = "应用系统名称", example = "ERP 系统")
    @DiffLogField(name = "应用系统名称")
    private String appName;

    @NotBlank(message = "系统环境不可为空")
    @Schema(description = "系统环境:dev;test;pre;prod;", example = "dev")
    @DiffLogField(name = "系统环境")
    private String appEnv;

    @NotBlank(message = "联系人不可为空")
    @Schema(description = "应用联系人", example = "张三")
    @DiffLogField(name = "应用联系人")
    private String appContact;

    @NotBlank(message = "联系电话不可为空")
    @Schema(description = "联系电话", example = "123123123")
    @DiffLogField(name = "联系电话")
    private String appContactPhone;

    @NotBlank(message = "联系地址不可为空")
    @Schema(description = "联系地址", example = "北京市海淀区")
    @DiffLogField(name = "联系地址")
    private String appContactAddress;

}
