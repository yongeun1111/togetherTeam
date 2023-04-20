package com.togetherTeam.platform.mapper;

import java.io.IOException;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.togetherTeam.platform.entity.ChatRoom;

@Mapper
public interface chatRoomMapper {

	public void addChatRoom(ChatRoom chatRoom);
	public void updateFileName(@Param("chat_room_no") int chat_room_no, @Param("file_name") String file_name);
	public int countBychat_room_no(@Param("pro_no") int pro_no, @Param("buyer_mem_no") int buyer_mem_no);
	public ChatRoom findBychat_room_no(@Param("pro_no") int pro_no, @Param("buyer_mem_no") int buyer_mem_no);
	public int get_no(@Param("pro_no") int pro_no, @Param("buyer_mem_no") int buyer_mem_no);
}
