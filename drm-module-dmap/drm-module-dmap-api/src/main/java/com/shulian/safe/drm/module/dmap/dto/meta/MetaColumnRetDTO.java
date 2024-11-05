package com.shulian.safe.drm.module.dmap.dto.meta;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/23 15:33
 * @version: V1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "数据列返回DTO")
public class MetaColumnRetDTO implements Serializable {

    private static final long serialVersionUID = -5126430198010510801L;

    private Long id;

    @Schema(description = "数据库 ID", example = "123")
    private Long dbId;

    @Schema(description = "数据库名称", example = "123")
    private String dbName;

    @Schema(description = "表 ID", example = "123")
    private Long tableId;

    @Schema(description = "表名称", example = "测试表")
    private String tableName;

    @Schema(description = "列名", example = "name")
    private String colName;

    @Schema(description = "列中文", example = "用户名")
    private String colNameZh;

    @Schema(description = "列类型", example = "varchar")
    private String dataType;

    @Schema(description = "列长度", example = "100")
    private Integer dataLength;

    @Schema(description = "数据精度", example = "1")
    private Integer dataScale;

    @Schema(description = "是否可为空", example = "1")
    private Boolean nullable;

    @Schema(description = "默认值", example = "1")
    private String defaultValue;

    @Schema(description = "是否主键", example = "1")
    private Boolean primaryKey;

    @Schema(description = "主键是否为自增类型", example = "1")
    private Boolean keyIdentityFlag;

    @Schema(description = "是否外键", example = "0")
    private Boolean foreignKey;

    @Schema(description = "样例数据", example = "张三")
    @Deprecated
    private String colDemo;

    @Schema(description = "版本号", example = "1")
    private String version;

    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    private LocalDateTime createTime;

    @Schema(description = "采样的数据", example = "[张三,李四,王五]")
    private List<String> sampleList;
}
