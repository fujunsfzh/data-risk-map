package com.shulian.safe.drm.module.dmap.entity.scan;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.shulian.safe.drm.framework.mybatis.core.dataobject.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/12 16:16
 * @version: V1.0
 */
@TableName(value = "sc_task_result")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "探查 - 任务执行结果")
public class ScTaskResultEntity extends BaseEntity {


    @Schema(description = "任务id", example = "100")
    private Long taskId;

    @Schema(description = "实例id", example = "386d95240c46bf78d7ea1658f2283c96")
    private String instanceId;

    @Schema(description = "数据源数据源URL", example = "10.0.3.123")
    private String dsUrl;

    @Schema(description = "数据源端口", example = "3306")
    private String dsPort;

    @Schema(description = "数据源类型", example = "mysql")
    private String dsType;

    @Schema(description = "备注", example = "测试库")
    private String remark;


}

