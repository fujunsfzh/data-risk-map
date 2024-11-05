package com.shulian.safe.drm.module.dmap.dto.tag;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/8 16:45
 * @version: V1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "标签规则-实体")
public class TagRuleSaveReqDTO implements Serializable {

    private static final long serialVersionUID = 7112721319557834521L;

    @Schema(description = "主键", example = "100")
    private Long id;

    @NotNull
    @Schema(description = "标签id", example = "101")
    private Long tagId;

    @NotNull
    @Schema(description = "匹配类型 1-名称匹配；2-注释匹配；3-内容匹配", example = "3")
    private Integer matchingType;

    @NotNull
    @Schema(description = "匹配方法 1-精确匹配-等于；2-模糊匹配-包含；3-正则匹配", example = "2")
    private Integer matchingMethod;

    @NotNull
    @Schema(description = "匹配源类型 1-输入匹配；2-字典匹配", example = "1")
    private Integer matchingSourceType;

    @Schema(description = "匹配内容，多个逗号分隔", example = "sfz,idcard")
    private String matchingContent;

    // @Schema(description = "正则表达式", example = "")
    // private String ruleRegex;

    @Schema(description = "匹配字典值", example = "sfz")
    private String matchingDict;

    @Schema(description = "优先级 数字越小越优先", example = "5")
    private Integer priority;

    @Schema(description = "状态 1：正常，2：停用", example = "1")
    private Integer status;
}
