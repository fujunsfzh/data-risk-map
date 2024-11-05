package com.shulian.safe.drm.module.dmap.dto.meta;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/30 10:19
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "查询数据源表空间 DTO")
public class MetaSchemaReqDTO implements Serializable {

    @NotBlank(message = "数据源类型不可为空")
    @Schema(description = "数据源类型", example = "mysql")
    private String dbType;

    @NotBlank(message = "主机不可为空")
    @Schema(description = "连接主机", example = "10.0.0.12")
    private String dbHost;

    @NotNull(message = "连接端口不可为空")
    @Schema(description = "连接端口", example = " 3306")
    private Integer dbPort;

    @Schema(description = "数据库名称", example = "user_info")
    private String dbName;

    @Schema(description = "连接参数", example = "remarks=true")
    private String extParams;

    @NotBlank(message = "用户名不可为空")
    @Schema(description = "连接用户名", example = "root")
    private String dbUser;

    @NotBlank(message = "连接密码不可为空")
    @Schema(description = "连接密码", example = "123123123")
    private String dbPwd;

    @Schema(description = "oracle数据库连接方式 1-SERVICE_NAME，2-SID", example = "1")
    private Integer dboType;
}
