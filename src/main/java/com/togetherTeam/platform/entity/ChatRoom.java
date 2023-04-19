package com.togetherTeam.platform.entity;

import java.security.Timestamp;

import lombok.Data;

@Data
public class ChatRoom {

	private int chat_room_no;
	private int pro_no;
	private int seller_mem_no;
	private int buyer_mem_no;
	private java.sql.Timestamp room_date;
	private String file_name;
	private String buyer_mem_id;
	private String seller_mem_id;
	
	// not in DB
	private String content;
	private String sendTime;
	private String sender_id;
	private String pro_title;
}
