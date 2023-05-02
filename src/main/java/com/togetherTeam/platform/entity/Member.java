package com.togetherTeam.platform.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class Member {

    private int mem_no; // pk 회원번호
    private String mem_id;  // 회원아이디
    private String mem_pwd; // 회원비밀번호
    private String mem_name; // 회원이름
    private String mem_phone; // 회원전화번호
    private String mem_birth; // 회원생년월일
    private String mem_email; // 회원이메일
    private LocalDateTime mem_date; // 회원가입일자
    private String mem_delete; // 회원가입일자

    // 프로필 이미지
    private int mem_img_no; // 이미지 번호
	private LocalDateTime mem_img_date; // 이미지 등록일
	private String mem_upload_path; // 이미지 경로
	private String mem_uuid; // 이미지 이름
	private String mem_file_name; // 이미지 원본 이름
}
