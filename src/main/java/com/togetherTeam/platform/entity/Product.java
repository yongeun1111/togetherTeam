package com.togetherTeam.platform.entity;

import lombok.Data;

@Data
public class Product {

	private int pro_no; // pk 물품번호
    private int seller_mem_id;  // 판매자회원번호
    private String pro_title; // 물품제목
    private String pro_category; // 물품카테고리
    private String pro_name; // 물품이름
    private String pro_theme; // 물품테마
    private String buy_date; // 구매일시/사용기간
    private int buy_price; // 구매금액
    private int sale_price; // 판매금액
    private String pro_content; // 물품내용
    private String pro_date; // 등록일시
    private String pro_sale; // 판매여부
    private int buyer; // 구매자회원번호
    private String deal_date; // 구매완료일
    private int pro_like; // 찜카운트
	
	
}