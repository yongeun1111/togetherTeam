package com.togetherTeam.platform.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Image {

	private int pro_no; // 물품번호
	private int img_no; // 이미지 번호
	private LocalDateTime img_date; // 이미지 등록일
	private String upload_path; // 이미지 경로
	private String uuid; // 이미지 이름
	private String file_name; // 파일경로
	
}
