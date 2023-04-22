package com.togetherTeam.platform.mapper;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.togetherTeam.platform.entity.ChatRoom;

@Mapper
public interface chatRoomMapper {

	public void addChatRoom(ChatRoom chatRoom);
	public void updateFileName(@Param("chatRoomNo") int chatRoomNo, @Param("fileName") String fileName);
	public int countChatRoomNo(@Param("proNo") int proNo, @Param("buyerNo") int buyerNo);
	public ChatRoom findChatRoomNo(@Param("proNo") int proNo, @Param("buyerNo") int buyerNo);
	public int getNo(@Param("proNo") int proNo, @Param("buyerNo") int buyerNo);
	public List<ChatRoom> getChatList(int memNo);
	public ChatRoom findChatRoom(int chatRoomNo);
}
