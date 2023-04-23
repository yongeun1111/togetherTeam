package com.togetherTeam.platform.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.togetherTeam.platform.entity.Chat;
import com.togetherTeam.platform.entity.ChatRoom;
import com.togetherTeam.platform.mapper.chatRoomMapper;

@Service
@Transactional
public class ChatRoomService implements chatRoomMapper {

	@Autowired
	chatRoomMapper chatRoomMapper;
		
	@Override
	public void createChatRoom(ChatRoom chatRoom) {
		
        LocalDateTime now = LocalDateTime.now();
        now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
		chatRoom.setRoom_date(now);
		chatRoomMapper.createChatRoom(chatRoom);
	}
	
	
	public List<Chat> readChatHistory(int chatRoomNo) {
		
		List<Chat> chatHistory = chatRoomMapper.readChatHistory(chatRoomNo);
		
		return chatHistory;
	}
		
	public List<ChatRoom> getChatList(int memNo) {
		List<ChatRoom> chatRoom = chatRoomMapper.getChatList(memNo);
		return chatRoom;
	}
		
	public void chatMessage(Chat chat) {
		chatRoomMapper.chatMessage(chat);
	}
	
	@Override
	public ChatRoom findChatRoom(int chatRoomNo) {
		return chatRoomMapper.findChatRoom(chatRoomNo);
	}
	
	@Override
	public ChatRoom checkChatRoom(int proNo, int buyerNo) {
		
		return chatRoomMapper.checkChatRoom(proNo, buyerNo);
	}
	
	
}
