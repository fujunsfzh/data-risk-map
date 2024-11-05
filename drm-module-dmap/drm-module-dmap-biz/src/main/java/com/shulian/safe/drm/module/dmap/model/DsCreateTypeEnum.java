package com.shulian.safe.drm.module.dmap.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import lombok.Getter;

/**
 * 数据源创建方式枚举
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/26 17:33
 * @version: V1.0
 */
@Getter
public enum DsCreateTypeEnum {

    /**
     * 手动创建
     */
    MANUAL("MANUAL", "手动创建"),
    /**
     * 批量导入
     */
    BATCH_IMPORT("BATCH_IMPORT", "批量导入"),
    /**
     * 自动扫描
     */
    SCAN("SCAN", "自动扫描");


    private String value;

    private String text;


    DsCreateTypeEnum(String value, String text) {
        this.value = value;
        this.text = text;
    }


    @JsonCreator
    public static DsCreateTypeEnum getByValue(String value) {
        for (DsCreateTypeEnum e : values()) {
            if (e.value.equals(value)) {
                return e;
            }
        }
        return null;
    }

}
