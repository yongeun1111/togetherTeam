package com.togetherTeam.platform.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.mapper.productMapper;

@RestController
public class productSearchController {

	@Autowired
	private productMapper mapper;
	
	@RequestMapping("/getCategory")
	public List<Product> getCategory(String category){
	
		List<Product> list = null;
		
		System.out.println(category);
		
		if (category.equals("ALL")) {
			list = mapper.getAllList();
		} else {
			list = mapper.getCategoryList(category);
		}
		
		return list;
	}
}
