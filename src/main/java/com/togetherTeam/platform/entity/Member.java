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

}
