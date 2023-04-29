package com.togetherTeam.platform.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Chat {
	
	private int chat_room_no;
	private LocalDateTime chat_date;
	private int chat_mem_no;
	private String chat_content;
	private int chat_read;
	// not in DB
	private String chat_mem_id;
	private String opp_upload_path;
	private String opp_uuid;
	private String opp_file_name;
}
