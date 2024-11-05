package com.shulian.safe.drm.module.dmap.dto.tag;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
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
 * @date: 2024/10/8 17:12
 * @version: V1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "标签保存请求DTO")
public class TagSaveReqDTO implements Serializable {

    private static final long serialVersionUID = -1893321147351366836L;

    @Schema(description = "主键", example = "100")
    private Long id;

    @NotBlank
    @Schema(description = "标签名称", example = "身份证")
    private String tagName;

    @NotBlank
    @Schema(description = "标签编码", example = "sfz")
    private String tagCode;

    @NotNull
    @Schema(description = "标签类型 1-字段标签;2-表标签;", example = "1")
    private Integer tagType;

    @NotNull
    @Schema(description = "0-无风险;1-低风险;2-中风险;3-高风险;", example = "2")
    private Integer risk;

    @Schema(description = "逻辑关系 and-全部与；or-全部或", example = "and")
    private String logicRel;
}
