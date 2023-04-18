package com.togetherTeam.platform.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.Member;

@Mapper
public interface memberMapper {

	public Member login(Member vo);
}
