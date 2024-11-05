package com.shulian.safe.drm.module.dmap.entity.meta;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/27 16:53
 * @version: V1.0
 */
@TableName(value = "ds_meta_his")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "资产历史统计")
public class MetaHisEntity extends BaseEntity {

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Schema(description = "统计日期", example = "2024-09-27")
    private LocalDate statisticalDate;

    @Schema(description = "数据库类型", example = "mysql")
    private String dbType;

    @Schema(description = "数据库数量", example = "1")
    private Long dbCount;
}
