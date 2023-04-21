package com.togetherTeam.platform.entity;

import lombok.Data;

@Data
public class PageMakerList {
	
	private CriteriaList cri;
	private int totalCount; // 총 게시글의 수
	private int startPage; // 시작 페이지 번호
	private int endPage; // 끝 페이지 번호 (조정이 필요)
	private boolean prev; // 이전 버튼 존재 유무 (true, false)
	private boolean next; // 다음 버튼 존재 유무 (true, false)
	private int displayPageNum = 3; // 1 2 3 4 5 ▷, ◁ 6 7 8 9
	
	// 구한 총 게시글의 수를 세팅하는 메소드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePaging();
	}
	// 페이징 처리에서 가장 중요한 부분 (나머지 변수 계산)
	private void makePaging() {
		// 1. 화면에 보여질 마지막 페이지 번호
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		// 2. 화면에 보여질 시작 페이지 번호
		startPage = (endPage - displayPageNum) + 1;
		// startPage가 0이하로 갈 오류를 대비해 미리 1로 지정
		if (startPage<=0) {
			startPage = 1;
		}
		// 3. 전체 마지막 페이지 계산
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		// 4. 화면에 보여질 마지막 페이지의 유효성 체크
		if (tempEndPage < endPage) {
			endPage = tempEndPage;
		}
		
		// 5. 이전 페이지 버튼 존재 여부
		prev = (startPage==1) ? false : true;
		
		// 6. 다음 페이지 버튼 존재 여부
		next = (endPage<tempEndPage) ? true : false;
	}
	
}
