package com.togetherTeam.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.togetherTeam.platform.entity.Chat;
import com.togetherTeam.platform.entity.ChatRoom;
import com.togetherTeam.platform.entity.ProfileImage;

@Mapper
public interface chatRoomMapper {

	public void createChatRoom(ChatRoom chatRoom);
	public ChatRoom checkChatRoom(@Param("proNo") int proNo, @Param("buyerNo") int buyerNo);
	public List<ChatRoom> getChatList(int memNo);
	public ChatRoom findChatRoom(int chatRoomNo);
	public List<Chat> readChatHistory(int chatRoomNo);
	public void insertChat(Chat chat);
	public int findChatRead(@Param("chatRoomNo") int chatRoomNo, @Param("memNo") int memNo);
	public void updateChatRead(@Param("chatRoomNo") int chatRoomNo, @Param("chatMemNo") int chatMemNo);
	public Chat getRecentChat(int chatRoomNo);
	public String getId(int memNo);
	public ProfileImage getProfile(int memNo);
}
