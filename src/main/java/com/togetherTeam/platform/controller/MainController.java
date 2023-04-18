package com.togetherTeam.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController  {

	@RequestMapping("/index")
    public String main(){
        System.out.println("main controller start");
        return "index";
    }
	
	@GetMapping("/") // test 로그인 및 회원가입 등을 하는 페이지
    public String start(){
        System.out.println("main controller start");
        return "login";
    }

	@PostMapping("/login") // login -> home 페이지로 이동
	public String login() {
		return "home";
	}
	
	@GetMapping("/join") // join 회원가입 페이지로 이동
    public String join(){
        return "join";
    }

	// post 엔터티 만들고 나서 해보자	
	
	@GetMapping("/search_id") // search_id 아이디찾기 페이지로 이동
    public String search_id(){
        return "search_id";
    }
	
	// post 엔터티 만들고 나서 해보자
	
	@GetMapping("/search_pwd") // search_pwd 비밀번호찾기 페이지로 이동
    public String search_pwd(){
        return "search_pwd";
    }
	
	// post 엔터티 만들고 나서 해보자	
}
