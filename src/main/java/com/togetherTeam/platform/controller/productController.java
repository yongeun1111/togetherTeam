package com.togetherTeam.platform.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
}
