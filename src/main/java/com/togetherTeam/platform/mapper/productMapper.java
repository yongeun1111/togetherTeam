package com.togetherTeam.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.Image;
import com.togetherTeam.platform.entity.Product;

@Mapper
public interface productMapper {

	public List<Product> getAllList(); // proList 페이지 전체 물품 리스트
	public List<Product> getAllListRecent(); // proList 페이지 전체 물품 리스트
	public List<Product> getAllListLike(); // proList 페이지 전체 물품 리스트
	public List<Product> getCategoryList(String category);
	public List<Product> getCategoryListRecent(String category);
	public List<Product> getCategoryListLike(String category);
	public List<Product> searchProduct(String query); // 상품 검색
	public void productRegister(Product vo); // insert SQL
	public void imageEnroll(Image vo); // 이미지 등록 insert

}
