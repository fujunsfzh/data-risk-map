package com.shulian.safe.drm.module.system.framework.rpc.config;

import com.shulian.safe.drm.module.system.api.config.ConfigApi;
import com.shulian.safe.drm.module.system.api.file.FileApi;
import com.shulian.safe.drm.module.system.api.websocket.WebSocketSenderApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(proxyBeanMethods = false)
@EnableFeignClients(clients = {FileApi.class, WebSocketSenderApi.class, ConfigApi.class})
public class RpcConfiguration {
}
