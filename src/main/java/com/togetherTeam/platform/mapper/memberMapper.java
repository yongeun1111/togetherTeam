package com.togetherTeam.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.Member;

@Mapper
public interface memberMapper {

	public Member login(Member vo);
	public List<Member> search_id(Member vo);
	public List<Member> search_pwd(Member vo);
	public int join(Member vo);
	
}
