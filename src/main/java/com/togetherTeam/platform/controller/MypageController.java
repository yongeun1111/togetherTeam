package com.togetherTeam.platform.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.mapper.memberMapper;
import com.togetherTeam.platform.mapper.productMapper;

@Controller
public class MypageController {

	@Autowired
	private memberMapper mapper;
	
	@Autowired
	private productMapper mapper_pro;

	@GetMapping("/mypage_memInfo") // 마이페이지(mypage.jsp)로 이동
    public String mypage_memInfo(){
        return "sub/mypage_memInfo";
    }
	
	@PostMapping("/change_info") // 회원정보수정
	public String change_infoPost(Member vo, HttpSession session) {
		mapper.change_info(vo);
		Member result = mapper.update_login(vo);
		session.setAttribute("login", result);
		return "redirect:";
	}
	
}
