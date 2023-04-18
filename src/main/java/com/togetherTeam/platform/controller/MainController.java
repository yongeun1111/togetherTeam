package com.togetherTeam.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController  {

	@RequestMapping("/")
    public String main(){
        System.out.println("main controller start");
        return "home";
    }

    @GetMapping("/proList") // 중고 상품 페이지(proList.jsp)로 이동
    public String proList(){
        return "sub/proList";
    }

    @GetMapping("/registration") // 상품 등록하기 페이지(registration.jsp)로 이동
    public String registration(){
        return "sub/registration";
    }

    @GetMapping("/proSearch") // 상품 검색 페이지(proSearch.jsp)로 이동
    public String proSearch(){
        return "sub/proSearch";
    }


	
	@GetMapping("/login") // test 로그인 및 회원가입 등을 하는 페이지
    public String start(){
        System.out.println("main controller start");
        return "login";
    }
	
	@GetMapping("/join") // join 회원가입 페이지로 이동
    public String join(){
        return "join";
    }
	
	@GetMapping("/search_id") // search_id 아이디찾기 페이지로 이동
    public String search_id(){
        return "search_id";
    }
	
	@GetMapping("/search_pwd") // search_pwd 비밀번호찾기 페이지로 이동
    public String search_pwd(){
        return "search_pwd";
    }

}
