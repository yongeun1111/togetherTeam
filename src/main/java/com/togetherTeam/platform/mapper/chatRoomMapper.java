package com.togetherTeam.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.togetherTeam.platform.entity.Chat;
import com.togetherTeam.platform.entity.ChatRoom;

@Mapper
public interface chatRoomMapper {

	public void createChatRoom(ChatRoom chatRoom);
	public ChatRoom checkChatRoom(@Param("proNo") int proNo, @Param("buyerNo") int buyerNo);
	public List<ChatRoom> getChatList(int memNo);
	public ChatRoom findChatRoom(int chatRoomNo);
	public List<Chat> readChatHistory(int chatRoomNo);
	public void chatMessage(Chat chat);
}
