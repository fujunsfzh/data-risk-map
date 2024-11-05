package com.shulian.safe.drm.module.dmap.model;

import lombok.Data;

import java.util.List;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/24 10:38
 * @version: V1.0
 */
@Data
public class MetaTable {

    private String name;

    private String remarks;

    private Boolean havePrimaryKey;

    // TABLE  VIEW
    private String tableType;

    private Long count;

    private List<MetaColumn> columns;
}
