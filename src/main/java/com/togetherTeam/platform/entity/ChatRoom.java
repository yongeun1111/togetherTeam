package com.togetherTeam.platform.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ChatRoom {

	private int chat_room_no;
	private int pro_no;
	private int seller_mem_no;
	private int buyer_mem_no;
	private LocalDateTime room_date;
	private String buyer_mem_id;
	private String seller_mem_id;
	private String pro_title;
	private String recentChat;
}
