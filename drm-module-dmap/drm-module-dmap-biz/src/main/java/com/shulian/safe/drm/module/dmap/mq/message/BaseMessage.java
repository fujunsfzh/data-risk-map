package com.shulian.safe.drm.module.dmap.mq.message;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 消息基础类
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/14 16:11
 * @version: V1.0
 */
@Data
public class BaseMessage implements Serializable {
    /**
     * 业务键，用于RocketMQ控制台查看消费情况
     */
    protected String key;
    /**
     * 发送消息来源，用于排查问题
     */
    protected String source = "";
    /**
     * 发送时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    protected LocalDateTime sendTime = LocalDateTime.now();

    // /**
    //  * 重试次数，用于判断重试次数，超过重试次数发送异常警告
    //  */
    // protected Integer retryTimes = 0;
}
