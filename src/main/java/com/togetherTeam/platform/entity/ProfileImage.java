package com.togetherTeam.platform.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProfileImage {
	
	private int mem_no; // 회원번호
	private int mem_img_no; // 회원 이미지 번호
	private LocalDateTime mem_img_date; // 이미지 등록일
	private String mem_upload_path; // 이미지 경로
	private String mem_uuid; // 이미지 이름
	private String mem_file_name; // 이미지 원본 이름

}
