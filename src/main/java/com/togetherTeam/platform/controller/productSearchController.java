package com.togetherTeam.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.togetherTeam.platform.entity.CriteriaList;
import com.togetherTeam.platform.entity.PageMakerList;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.mapper.productMapper;

@RestController
public class productSearchController {

	List<Product> list = null;

	@Autowired
	private productMapper mapper;
	
//	@RequestMapping("/getCategory")
//	public List<Product> getCategory(String category, CriteriaList cri){
//			
//		if (category.equals("ALL")) {
//			list = mapper.getAllList(cri);
//		} else {
//			list = mapper.getCategoryList(category);
//		}
//		
//		return list;
//	}
	
	@RequestMapping("/searchProduct")
	public Map searchProduct(String query, CriteriaList cri){
		
		Map<String, Object> map = new HashMap<>();
		map.put("query", query);
		map.put("cri", cri);
		
		List<Product> list = mapper.searchProduct(map);
		int count = mapper.totalSearchCount(query);
		
		PageMakerList pageMakerList = new PageMakerList();
	    pageMakerList.setCri(cri);
	    pageMakerList.setTotalCount(count);
	    
	    Map<String, Object> res = new HashMap<>();
	    res.put("list", list);
	    res.put("pm", pageMakerList);

		return res;
	}
}
