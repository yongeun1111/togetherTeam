package com.togetherTeam.platform.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.mapper.productMapper;

@Controller
public class productController {

	@Autowired
	private productMapper mapper;
	
	@GetMapping("/proList") // 중고 상품 페이지(proList.jsp)로 이동
    public String proList(Model model){
		
		List<Product> list = mapper.getAllList();
		model.addAttribute("list", list);
		
        return "sub/proList";
    }
	
    @GetMapping("/registration") // 상품 등록하기 페이지(registration.jsp)로 이동
    public String registration(HttpSession session, Model model){
    	Member loginMember = (Member)session.getAttribute("login");
    	if(loginMember == null) {
    		// 로그인하지 않은 사용자는 로그인 페이지로 이동
    		return "redirect:/login";
    	}else {
    		// 로그인한 사용자는 상품 등록 페이지로 이동
    		model.addAttribute("login", loginMember);
    		return "sub/registration";
    	}
    	
    }
}
