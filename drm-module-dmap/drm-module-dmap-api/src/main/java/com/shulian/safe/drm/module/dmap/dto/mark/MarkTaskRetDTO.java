package com.shulian.safe.drm.module.dmap.dto.mark;

import com.shulian.safe.drm.module.dmap.enums.MarkTaskStatusEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/12 16:22
 * @version: V1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "打标任务返回DTO")
public class MarkTaskRetDTO implements Serializable {

    private static final long serialVersionUID = -7566021635514525736L;

    @Schema(description = "主键", example = "100")
    private Long id;

    @Schema(description = "1-敏感扫描 2-分类分级", example = "1")
    private Integer taskType;

    @Schema(description = "数据源id", example = "100")
    private Long dbId;

    @Schema(description = "数据源名称", example = "测试数据源")
    private String databaseName;

    @Schema(description = "数据源类型", example = "mysql")
    private String dbType;

    @Schema(description = "连接主机", example = "10.0.0.12")
    private String dbHost;

    @Schema(description = "连接端口", example = " 3306")
    private Integer dbPort;

    @Schema(description = "数据库名称", example = "user_info")
    private String dbName;

    @Schema(description = "数据源uri", example = " 10.0.3.12:3306/test")
    private String databaseUri;

    @Schema(description = "标签组id 敏感扫描用", example = "100")
    private Long tagGroupId;

    @Schema(description = "标签组名称", example = "测试标签组")
    private String tagGroupName;

    @Schema(description = "行业Id 分类分级用", example = "100")
    private Long industrialId;

    @Schema(description = "行业名称", example = "医疗行业")
    private String industrialName;

    @Schema(description = "抽取行数 -1-全量，其他抽取指定行数", example = "200")
    private Long scanNum;

    @Schema(description = "状态 1：运行中，2：正常终止，3：手动终止，4：异常终止", example = "2")
    private MarkTaskStatusEnum status;

    @Schema(description = "创建人", example = "zhangsan")
    private String creator;

    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    private LocalDateTime createTime;

    @Schema(description = "更新人", example = "zhangsan")
    private String updater;

    @Schema(description = "更新时间", example = "2024-09-18 16:00:38")
    private LocalDateTime updateTime;

    public String getDatabaseUri() {
        return dbHost + ":" + dbPort + "/" + dbName;
    }
}
