package com.togetherTeam.platform.entity;

import lombok.Data;

@Data
public class CriteriaSale {
	private int page; // 현재페이지번호 page=4, page=2
	private int perPageNum;
	// private int pageStart; -> 만들면 getter, setter이 만들어지지만 아래에 필요한 getter을 만들었기때문에 만들필요가 없다.
	// private int pageStart;
	// private int pageEnd;
	
	public CriteriaSale() {
		this.page=1;
		this.perPageNum=10; // 조정
	}
	
	// select * from memboard order by boardGroup desc, boardSeq asc limit 1, 10
	// 현재 페이지의 게시글의 시작번호 구하기
	public int getPageStart() {
		return (page-1)*perPageNum; // limit #{pageStart}, #{perPagetNum}
									// #{pageStart} -> getter을 호출
	}
	
	public int getPageEnd() {
		return page*perPageNum;
	}
	
}

