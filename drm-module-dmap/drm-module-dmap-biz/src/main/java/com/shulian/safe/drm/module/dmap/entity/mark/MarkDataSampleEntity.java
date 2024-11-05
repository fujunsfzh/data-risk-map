package com.shulian.safe.drm.module.dmap.entity.mark;

import com.baomidou.mybatisplus.annotation.TableName;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/12 15:29
 * @version: V1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "标签数据样本")
@TableName(value = "mark_data_sample")
public class MarkDataSampleEntity extends BaseEntity {

    private static final long serialVersionUID = -2757557291706214345L;

    @Schema(description = "任务主键",example = "100")
    private Long taskId;

    @Schema(description = "数据源id",example = "100")
    private Long dbId;

    @Schema(description = "数据表主键",example = "数据表主键")
    private Long tableId;

    @Schema(description = "数据表名称",example = "数据表名称")
    private String tableName;

    @Schema(description = "字段名称",example = "字段名称")
    private String colName;

    @Schema(description = "数据样板",example = "数据样本")
    private String dataSample;
}
