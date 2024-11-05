package com.shulian.safe.drm.module.dmap.mq;

import com.shulian.safe.drm.framework.common.util.json.JsonUtils;
import com.shulian.safe.drm.module.dmap.mq.message.BaseMessage;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.rocketmq.client.producer.SendCallback;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.apache.rocketmq.spring.support.RocketMQHeaders;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 消息生产者
 *
 * @company:
 * @author: ZJW
 * @date: 2024/10/17 21:45
 * @version: V1.0
 */
@Slf4j
@Service
public class RocketProducer {


    @Resource
    private RocketMQTemplate rocketMQTemplate;


    /**
     * 发送消息
     *
     * @param topic
     * @param msg
     */
    public SendResult syncSend(String topic, String msg) {
        SendResult sendResult = rocketMQTemplate.syncSend(topic, msg);
        return sendResult;
    }

    public SendResult syncSend(String topic, String msg, String msgKey, String tag) {
        Message<String> sendMessage = MessageBuilder.withPayload(msg)
                .setHeader(RocketMQHeaders.KEYS, msgKey)
                .build();
        String destination = topic;
        if (StringUtils.isNotBlank(tag)) {
            destination = topic + ":" + tag;
        }
        return rocketMQTemplate.syncSend(destination, sendMessage);
    }


    /**
     * 异步发送
     *
     * @param topic
     * @param msg
     */
    public void asyncSend(String topic, String msg, String msgKey, String tag) {
        Message<String> sendMessage = MessageBuilder.withPayload(msg)
                .setHeader(RocketMQHeaders.KEYS, msgKey)
                .build();
        String destination = topic;
        if (StringUtils.isNotBlank(tag)) {
            destination = topic + ":" + tag;
        }
        rocketMQTemplate.asyncSend(destination, sendMessage, new SendCallback() {
            @Override
            public void onSuccess(SendResult result) {
                log.info("[{}]异步发送成功，结果为：[{}]]", topic, result);
            }

            @Override
            public void onException(Throwable e) {
                log.error("[{}][异步发送失败]", topic, e);
            }
        });
    }

    /**
     * 异步同步消息
     *
     * @param topic
     * @param message
     * @param tag
     * @param <T>
     * @return
     */
    public <T extends BaseMessage> void asyncSend(String topic, T message, String tag) {
        Message<T> sendMessage = MessageBuilder.withPayload(message)
                .setHeader(RocketMQHeaders.KEYS, message.getKey())
                .build();
        String destination = topic;
        if (StringUtils.isNotBlank(tag)) {
            destination = topic + ":" + tag;
        }
        log.info("[{}]异步发送消息 {}", destination, JsonUtils.toJsonString(sendMessage));
        rocketMQTemplate.asyncSend(destination, sendMessage, new SendCallback() {
            @Override
            public void onSuccess(SendResult result) {
                log.info("[{}]异步发送成功", topic);
            }

            @Override
            public void onException(Throwable e) {
                log.error("[{}][异步发送失败]", topic, e);
            }
        });
    }

    /**
     * 异步同步消息
     *
     * @param topic
     * @param messageList
     * @param tag         批量发送消息,消息 tag 相同
     * @param <T>
     * @return
     */
    public <T extends BaseMessage> void asyncBatchSend(String topic, List<T> messageList, String tag) {
        if (CollectionUtils.isEmpty(messageList)) {
            return;
        }
        List<Message<T>> sendMessageList = new ArrayList<>();
        for (T message : messageList) {
            Message<T> sendMessage = MessageBuilder.withPayload(message)
                    .setHeader(RocketMQHeaders.KEYS, message.getKey())
                    .build();
            sendMessageList.add(sendMessage);
        }
        String destination = topic;
        if (StringUtils.isNotBlank(tag)) {
            destination = topic + ":" + tag;
        }
        rocketMQTemplate.asyncSend(destination, sendMessageList, new SendCallback() {
            @Override
            public void onSuccess(SendResult result) {
                log.info("[{}]异步发送成功，结果为：[{}]]", topic, result);
            }

            @Override
            public void onException(Throwable e) {
                log.error("[{}][异步发送失败]", topic, e);
            }
        });
    }


}
