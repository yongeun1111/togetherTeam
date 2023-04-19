package com.togetherTeam.platform.mapper;

import java.io.IOException;

import org.apache.ibatis.annotations.Mapper;

import com.togetherTeam.platform.entity.ChatRoom;

@Mapper
public interface chatRoomMapper {

	public void addChatRoom(ChatRoom chatRoom);
	public void updateFileName(int chat_room_no, String file_name);
}
