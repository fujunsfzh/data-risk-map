package com.shulian.safe.drm.module.dmap.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * Simple to Introduction
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/12 17:03
 * @version: V1.0
 */
public enum MarkTaskStatusEnum {

    INIT(0, "初始化"),

    RUNNING(1, "运行中"),

    NORMAL_TERMINATION(2, "正常终止"),

    MANUAL_TERMINATION(3, "手动终止"),

    ABNORMAL_TERMINATION(4, "异常终止");

    private Integer value;

    private String text;

    MarkTaskStatusEnum(Integer value, String text) {
        this.value = value;
        this.text = text;
    }

    @JsonValue
    public Integer getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    @JsonCreator
    public static MarkTaskStatusEnum getByValue(Integer value) {
        for (MarkTaskStatusEnum e : values()) {
            if (e.value.equals(value)) {
                return e;
            }
        }
        return null;
    }
}
