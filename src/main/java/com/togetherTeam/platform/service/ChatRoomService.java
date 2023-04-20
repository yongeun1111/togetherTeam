package com.togetherTeam.platform.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
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
	
	String fileUploadPath = "C:\\chat/";
	
	@Override
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
	
	public void createFile(int pro_no, int chat_room_no) throws IOException {
		
		String file_name = pro_no + "_"+ chat_room_no + ".txt";
		String path_name = fileUploadPath + file_name;
		// file 클래스에 path_name 할당
		File txtFile = new File(path_name);
		txtFile.createNewFile();
		
		chatRoomMapper.updateFileName(chat_room_no, file_name);
	}
	
	@Override
	public void updateFileName(int chat_room_no, String file_name) {
		
		chatRoomMapper.updateFileName(chat_room_no, file_name);
	}

	
	public void appendMessage(ChatRoom chatRoom) throws IOException {
		
		int pro_no = chatRoom.getPro_no();
		int buyer_mem_no = chatRoom.getBuyer_mem_no();
		
		ChatRoom chatRoomAppend = chatRoomMapper.findBychat_room_no(pro_no, buyer_mem_no);
		
		String path_name = fileUploadPath + chatRoomAppend.getFile_name();
		
		FileOutputStream fos = new FileOutputStream(path_name, true);
		String content = chatRoom.getContent();
		int sender_no = chatRoom.getSender_no();
		String sender_id = chatRoom.getSender_id();
		String sendTime = chatRoom.getSendTime();
		System.out.println("print:"+ content);
		
		String writeContent = sender_id + "\n" + content + "\n" + "[" + sendTime + "]" + "\n";
		
		byte[] b = writeContent.getBytes();
		
		fos.write(b);
		fos.close();
		
		System.out.println("sender_no: "+ sender_no);
		System.out.println("seller_id: "+ chatRoom.getSender_id());
		
	}
	
	
	
	@Override
	public int countBychat_room_no(int pro_no, int buyer_mem_no) {
		
		return chatRoomMapper.countBychat_room_no(pro_no, buyer_mem_no);
	}
	
	@Override
	public ChatRoom findBychat_room_no(int pro_no, int buyer_mem_no) {
		
		return chatRoomMapper.findBychat_room_no(pro_no, buyer_mem_no);
	}
	
	@Override
	public int get_no(int pro_no, int buyer_mem_no) {
		
		return chatRoomMapper.get_no(pro_no, buyer_mem_no);
	}

}
