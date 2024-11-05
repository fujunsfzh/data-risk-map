package com.shulian.safe.drm.framework.common.util.json.databind;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

/**
 * 基于时间戳的 LocalDateTime 反序列化器
 *
 * @author 老五
 */
public class TimestampLocalDateTimeDeserializer extends JsonDeserializer<LocalDateTime> {

    public static final TimestampLocalDateTimeDeserializer INSTANCE = new TimestampLocalDateTimeDeserializer();

    @Override
    public LocalDateTime deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        // 将 Long 时间戳，转换为 LocalDateTime 对象
        long valueAsLong = p.getValueAsLong();
        if (valueAsLong == 0) {
            String valueAsString = p.getValueAsString();
            if (StringUtils.isNotBlank(valueAsString)) {
                return LocalDateTime.parse(valueAsString, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            // 避免前端传值空时，反序列化 1970-01-01 08:00:00
            return null;
        }
        return LocalDateTime.ofInstant(Instant.ofEpochMilli(valueAsLong), ZoneId.systemDefault());
    }

}
