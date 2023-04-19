package com.togetherTeam.platform.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebsocketBrokerConfig implements WebSocketMessageBrokerConfigurer {

	private static final Logger LOGGER = LoggerFactory.getLogger(WebsocketBrokerConfig.class);
	
	
	//onfigureMessageBroker
	// 유저가 메시지를 전송하거나 받을 수 있도록 중간에서
	// URL prefix(접두어)를 인식하고, 전송/전달(publish/subscribe) 중계
	// 중개자(Broker) 역할
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		
		// for subscribe prefix
		registry.enableSimpleBroker("/user");
		
		// for publish prefix
		registry.setApplicationDestinationPrefixes("/app");
	}
	
	// 메시지의 도착지점을 URL로 등록하는 메소드
	// 등록된 URL은 Controller의 @Messagemapping 어노테이션으로 할당해줘 S
	// impMessagingTemplate를 통해 약속된 경로나 유저에게 메시지를 전달
	// .withSockJS() : fallback 기능을 하는 sockJS를 할당
	// heart-beat : STOMP에서 TCP 연결이 잘 되어있는지 체크
	// HTTP header를 통해 연결 상태를 주기적으로 확인
	// setHeartbeatTime은 그 주기를 설정하는 메소드
	// java에서 언더바 [ _ ]를 int나 long에 천단위마다 사용하면 단위를 나타냄
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		
		registry.addEndpoint("/broadcast")
		.withSockJS()
		.setHeartbeatTime(60_000);
	}
}
