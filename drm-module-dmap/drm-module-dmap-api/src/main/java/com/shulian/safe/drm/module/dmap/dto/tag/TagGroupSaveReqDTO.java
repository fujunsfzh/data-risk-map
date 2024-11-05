package com.shulian.safe.drm.module.dmap.dto.tag;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.List;

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
@Schema(description = "标签组保存请求DTO")
public class TagGroupSaveReqDTO implements Serializable {

    private static final long serialVersionUID = -1893321147351366836L;


    @Schema(description = "主键", example = "100")
    private Long id;

    @NotBlank
    @Schema(description = "标签分组名称", example = "个人身份信息")
    private String groupName;

    @Schema(description = "备注说明", example = "识别个人身份信息")
    private String remark;

    @Schema(description = "包含的标签", example = "[100,101,102,103]")
    private List<Long> tagIdList;
}
