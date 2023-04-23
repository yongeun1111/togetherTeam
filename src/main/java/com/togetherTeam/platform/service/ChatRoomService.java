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
	
	String fileUploadPath = "C:\\chat/";
	
	@Override
	public void addChatRoom(ChatRoom chatRoom) {
		
//		Timestamp createdDate = Timestamp.valueOf(LocalDateTime.now());
//		chatRoom.setRoom_date(createdDate);
        LocalDateTime now = LocalDateTime.now();
        now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
		chatRoom.setRoom_date(now);
		chatRoomMapper.addChatRoom(chatRoom);
	}
	
	// no connection with DB
	
	public List<Chat> readChatHistory(int chatRoomNo) {
		
		List<Chat> chatHistory = chatRoomMapper.readChatHistory(chatRoomNo);
		
		return chatHistory;
	}
	
	public void createFile(int proNo, int chatRoomNo) throws IOException {
		
		String fileName = proNo + "_"+ chatRoomNo + ".txt";
		String pathName = fileUploadPath + fileName;
		// file 클래스에 path_name 할당
		File txtFile = new File(pathName);
		txtFile.createNewFile();
		
		chatRoomMapper.updateFileName(chatRoomNo, fileName);
	}
	
	public List<ChatRoom> getChatList(int memNo) {
		List<ChatRoom> chatRoom = chatRoomMapper.getChatList(memNo);
		return chatRoom;
	}
	
	@Override
	public void updateFileName(int chatRoomNo, String fileName) {
		
		chatRoomMapper.updateFileName(chatRoomNo, fileName);
	}

	
	public void chatMessage(Chat chat) {
		System.out.println(chat);
		chatRoomMapper.chatMessage(chat);
	}
	
	
	
	@Override
	public int countChatRoomNo(int proNo, int buyerNo) {
		
		return chatRoomMapper.countChatRoomNo(proNo, buyerNo);
	}
	
	@Override
	public ChatRoom findChatRoomNo(int proNo, int buyerNo) {
		
		return chatRoomMapper.findChatRoomNo(proNo, buyerNo);
	}
	
	@Override
	public int getNo(int proNo, int buyerNo) {
		
		return chatRoomMapper.getNo(proNo, buyerNo);
	}
	
	@Override
	public ChatRoom findChatRoom(int chatRoomNo) {
		return chatRoomMapper.findChatRoom(chatRoomNo);
	}

}
