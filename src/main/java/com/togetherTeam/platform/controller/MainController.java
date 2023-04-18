package com.togetherTeam.platform.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.mapper.memberMapper;

@Controller
public class MainController  {

	@Autowired
	private memberMapper mapper;
	
	@RequestMapping("/")
    public String main(){
        System.out.println("main controller start");
        return "home";
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
	
	@PostMapping("/loginSucces") // login 성공시 home으로 이동
    public String loginSucces(Member vo, Model model, HttpSession session){
	    Member result = mapper.login(vo);
	    if(result == null) { // 로그인 실패 시
	        model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
	        // 로그인페이지에서 {error}를 열어봤을때, 오류 문장이 있으면 모덜창으로 보여주기?
	        return "login"; // 로그인 페이지로 이동
	    } else { // 로그인 성공 시
	        session.setAttribute("login", result); // 로그인 정보를 세션에 저장
	        return "home"; // 홈 페이지로 이동
	    }
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
