package com.shulian.safe.drm.framework.common.core;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Key Value 的键值对
 *
 * @author 系统源码
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "键值对")
public class KeyValue<K, V> implements Serializable {

    @Schema(description = "键")
    private K key;

    @Schema(description = "值")
    private V value;

}
