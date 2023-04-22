package com.togetherTeam.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.Product;

@Mapper
public interface memberMapper {

	public Member login(Member vo);
	public Member update_login(Member vo);
	public List<Member> search_id(Member vo);
	public List<Member> search_pwd(Member vo);
	public int check_id(String id);
	public void change_pwd(Member vo);
	public void change_info(Member vo);
	public List<Product> mypage_likeList(Member vo);
	public int join(Member vo);
	
}
