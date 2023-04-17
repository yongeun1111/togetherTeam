package com.togetherTeam.platform.domain.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class User {

    static int userId = 0; // pk
    private String userName;  // 이름
    private String userPassword; // 비밀번호
    private String userPone; // 연락처
    private String userCompany; // 회사명
    private String userDepartment ; // 부서명
    private String userIcon; // 프로필
    private String userContent; //남기는말
    private LocalDateTime userCreat; // 작성날짜

    public User(String userName, String userPassword, String userPone, String userCompany, String userDepartment, String userIcon, String userContent, LocalDateTime userCreat) {
        this.userId = userId + 1;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userPone = userPone;
        this.userCompany = userCompany;
        this.userDepartment = userDepartment;
        this.userIcon = userIcon;
        this.userContent = userContent;
        this.userCreat = userCreat;
    }
}
