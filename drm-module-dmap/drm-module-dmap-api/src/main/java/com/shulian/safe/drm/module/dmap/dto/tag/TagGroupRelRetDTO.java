package com.shulian.safe.drm.module.dmap.dto.tag;

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
 * @date: 2024/10/12 14:57
 * @version: V1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "标签组关系返回DTO")
public class TagGroupRelRetDTO implements Serializable {

    @Schema(description = "标签组id", example = "100")
    private Long tagGroupId;

    @Schema(description = "标签组名称", example = "测试标签组")
    private String tagGroupName;

    @Schema(description = "标签组备注", example = "测试组备注")
    private String groupRemark;

    @Schema(description = "标签id", example = "101")
    private Long tagId;

    @Schema(description = "标签名称", example = "测试标签")
    private String tagName;

    @Schema(description = "创建时间", example = "2024-09-18 16:00:38")
    private LocalDateTime createTime;

    @Schema(description = "更新时间", example = "2024-09-18 16:00:38")
    private LocalDateTime updateTime;
}
