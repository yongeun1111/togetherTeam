package com.togetherTeam.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.Product;

@Mapper
public interface productMapper {

	public List<Product> getAllList(); // proList 페이지 전체 물품 리스트
	public List<Product> getCategoryList(String category);
}
