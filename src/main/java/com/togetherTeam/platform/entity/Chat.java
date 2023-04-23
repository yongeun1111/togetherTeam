package com.togetherTeam.platform.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Chat {
	
	private int chat_room_no;
	private LocalDateTime chat_date;
	private int chat_mem_no;
	private String chat_content;
	
	// not in DB
	private String chat_mem_id;
}
