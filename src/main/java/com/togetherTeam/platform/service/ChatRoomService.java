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
	
	public void createFile(int proNo, int chatRoomNo) throws IOException {
		
		String fileName = proNo + "_"+ chatRoomNo + ".txt";
		String pathName = fileUploadPath + fileName;
		// file 클래스에 path_name 할당
		File txtFile = new File(pathName);
		txtFile.createNewFile();
		
		chatRoomMapper.updateFileName(chatRoomNo, fileName);
	}
	
	@Override
	public void updateFileName(int chatRoomNo, String fileName) {
		
		chatRoomMapper.updateFileName(chatRoomNo, fileName);
	}

	
	public void appendMessage(ChatRoom chatRoom) throws IOException {
		
		System.out.println(chatRoom);
		
		int proNo = chatRoom.getPro_no();
		int buyerNo = chatRoom.getBuyer_mem_no();
		
		
		ChatRoom chatRoomAppend = chatRoomMapper.findChatRoomNo(proNo, buyerNo);
		
		String pathName = fileUploadPath + chatRoomAppend.getFile_name();
		
		FileOutputStream fos = new FileOutputStream(pathName, true);
		String content = chatRoom.getContent();
		int senderNo = chatRoom.getSender_no();
		String senderId = chatRoom.getSender_id();
		String sendTime = chatRoom.getSendTime();
		System.out.println("print:"+ content);
		
		String writeContent = senderId + "\n" + content + "\n" + "[" + sendTime + "]" + "\n";
		
		byte[] b = writeContent.getBytes();
		
		fos.write(b);
		fos.close();
		
		System.out.println("senderNo: "+ senderNo);
		System.out.println("senderId: "+ chatRoom.getSender_id());
		
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

}
