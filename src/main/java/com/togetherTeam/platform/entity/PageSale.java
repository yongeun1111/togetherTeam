package com.togetherTeam.platform.entity;

import lombok.Data;

//페이징 처리를 하기위해서 ★계산★하는 클래스
@Data
public class PageSale {
	private CriteriaSale cri;
	private int memProTotalCount; // 총 게시글의 수
	private int startPage; // 시작 페이지 번호
	private int endPage; // 끝 페이지 번호(조정이 되어야한다)
	private boolean prev; // 이전버튼(o:true, x:false)
	private boolean next; // 다음버튼(o:true, x:false)
	private int displayPageNum=5; //   1 2 3 4 5 ▷
								  // ◁ 6 7 8 9 10 ▷ 
	// 총 게시글의 수를 구하는 메서드
	public void setMemProTotalCount(int memProTotalCount) {
		this.memProTotalCount=memProTotalCount;
		makePaging();
	}
	
	// 페이징 처리에서 가장 중요한 부분
	private void makePaging() {
		// 1. 화면에 보여질 마지막 페이지 번호
		endPage=(int)Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum;
		
		// 2. 화면에 보여질 시작 페이지 번호
		startPage=(endPage-displayPageNum)+1;
		if(startPage<=0) {
			startPage=1;
		}
		
		// 3. 전체 마지막 페이지 계산
		int tempEndPage=(int)(Math.ceil(memProTotalCount/(double)cri.getPerPageNum()));
		
		// 4. 화면에 보여질 마지막 페이지의 유효성 체크
		if(tempEndPage<endPage) {
			endPage = tempEndPage;
		}
		
		// 5. 이전 페이지 버튼 존재 여부
		prev = (startPage == 1) ? false : true;
		
		// 6. 다음 페이지 존재 여부
		next = (endPage<tempEndPage) ? true : false;
	}
	
}
