package com.togetherTeam.platform.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.CriteriaList;
import com.togetherTeam.platform.entity.Image;
import com.togetherTeam.platform.entity.LikeList;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.Product;

@Mapper
public interface productMapper {

	public List<Product> getAllList(CriteriaList cri); // proList 페이지 전체 물품 리스트
	public List<Product> getAllListRecent(); // proList 페이지 전체 물품 리스트
	public List<Product> getAllListLike(); // proList 페이지 전체 물품 리스트
	public List<Product> getCategoryList(String category);
	public List<Product> getCategoryListRecent(String category);
	public List<Product> getCategoryListLike(String category);
	public List<Product> searchProduct(String query); // 상품 검색
	public void productRegister(Product vo); // insert SQL
	public void imageEnroll(Image vo); // 이미지 등록 insert
	public int totalCount(); // 총 상품 카운트
	public List<Product> getMemProductList(Map<String, Object> paramMap); // 회원이 등록한 상품 리스트
	public int memProTotalCount(Member vo); // 상품 총 개수
	public int likeCheck(LikeList vo); // 상품 총 개수
	
	public Product test(); // 채팅 테스트
	
}
