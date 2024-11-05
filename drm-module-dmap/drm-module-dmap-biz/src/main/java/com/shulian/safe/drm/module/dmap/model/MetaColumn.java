package com.shulian.safe.drm.module.dmap.model;

import lombok.Data;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/24 10:16
 * @version: V1.0
 */
@Data
public class MetaColumn {
    /**
     * 列名称
     */
    private String name;
    /**
     * 数据类型
     */
    private String dataType;
    /**
     * 数据长度
     */
    private Integer length;
    /**
     * 数据精度
     */
    private Integer scale;
    /**
     * 是否可为空
     */
    private Boolean nullable;
    /**
     * 默认值
     */
    private String defaultValue;
    /**
     * 是否主键
     */
    private Boolean primaryKey;
    /**
     * 主键是否为自增类型
     */
    private Boolean keyIdentityFlag;
    /**
     * 是否外键
     */
    private Boolean foreignKey;

    /**
     * 列注释
     */
    private String remarks;



}
