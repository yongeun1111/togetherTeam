package com.togetherTeam.platform.entity;

import lombok.Data;

@Data
public class MypageLikeList {

	private String category;
	private int mem_no;
	private int page; // 현재 페이지 번호 page=4, page=2
	private int perPageNum; // 한 페이지에 출력할 게시물 개수
	
	public MypageLikeList() {
		this.page = 1;
		this.perPageNum = 5; // 조정 가능
		
	}

	public MypageLikeList(int mem_no, int page, int perPageNum) {
		this.mem_no = mem_no;
		this.page = page;
		this.perPageNum = perPageNum;
	}

	// 현재 페이지 게시글의 시작번호 구하기
	// 메소드 이름에서 get 다음 pageStart를 따로 속성 지정 안해도 
	// myBatis에서 인식 가능함
	public int getStartPage() {
		return (page-1)*perPageNum;
		// DB쪽 구문 limit #{pageStart}, #{perPageNum}
	}
	
	public int getEndPage() {
		return page*perPageNum;
	}
}
