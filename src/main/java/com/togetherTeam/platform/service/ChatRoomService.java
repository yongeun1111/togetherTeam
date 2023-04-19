package com.togetherTeam.platform.service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.togetherTeam.platform.entity.ChatRoom;
import com.togetherTeam.platform.mapper.chatRoomMapper;

@Service
@Transactional
public class ChatRoomService implements chatRoomMapper {

	@Autowired
	chatRoomMapper chatRoomMapper;
	
	String fileUploadPath = "C:\\chat";
	
	public void addChatRoom(ChatRoom chatRoom) {
		
		Timestamp createdDate = Timestamp.valueOf(LocalDateTime.now());
		chatRoom.setRoom_date(createdDate);
		
		chatRoomMapper.addChatRoom(chatRoom);
	}
	
	// no connection with DB
	
	public List<ChatRoom> readChatHistory(ChatRoom chatRoom) throws IOException{
		
		String pathName = fileUploadPath + chatRoom.getFile_name();
		
		// DB에 저장된 chat.txt 파일을 읽어옴
		BufferedReader br = new BufferedReader(new FileReader(pathName));
		
		// View에 ChatRoom 객체 전달
		ChatRoom chatRoomLines = new ChatRoom();
		List<ChatRoom> chatHistory = new ArrayList<ChatRoom>();
		
		String chatLine;
		int idx = 1;
		
		while ((chatLine = br.readLine()) != null) {
			
			// 메시지 1개 : 보낸 사람 아이디, 내용, 보낸 시간
			// 총 3줄 구성
			int answer = idx % 3;
			if (answer == 1) {
				// 보낸 사람 아이디
				chatRoomLines.setSender_id(chatLine);
				idx++;
			} else if (answer == 2) {
				// 메시지 내용
				chatRoomLines.setContent(chatLine);
				idx++;
			} else {
				// 보낸 시간
				chatRoomLines.setSendTime(chatLine);
				// 메시지가 담긴 ChatRoom 객체를 List타입으로 저장
				chatHistory.add(chatRoomLines);
				// 객체, idx(줄 수) 초기화
				chatRoomLines= new ChatRoom();
				idx = 1;
			}
		}
		return chatHistory;
	}
	
	public void updateFileName(int chat_room_no, String file_name) {
		chatRoomMapper.updateFileName(chat_room_no, file_name);
	}
	
	
}
