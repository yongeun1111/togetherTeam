package com.togetherTeam.platform.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.print.attribute.standard.DateTimeAtCompleted;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.togetherTeam.platform.entity.ChatRoom;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.mapper.chatRoomMapper;
import com.togetherTeam.platform.service.ChatRoomService;

import ch.qos.logback.core.util.TimeUtil;


@Controller
public class ChatController {

	@Autowired
	private SimpMessagingTemplate simpMessage;
	
	@Autowired
	private ChatRoomService chatRoomService;
	
	
	@GetMapping("/test")
	public String test(Model model) {
		
		return "test";		
	}
	
	// 채팅
	@GetMapping("/chatMessage")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute("chatRoom") ChatRoom chatRoom) throws IOException {
		
		// 채팅 화면에 전달할 parameter 설정
		Member member = (Member) session.getAttribute("login");
		int buyer_mem_no = member.getMem_no(); 
		String buyer_mem_id = member.getMem_id();
		chatRoom.setBuyer_mem_no(buyer_mem_no);
		chatRoom.setBuyer_mem_id(buyer_mem_id);
		
		// 채팅방이 이미 만들어져있는지 확인하고 이전 기록 불러오기
		if (chatRoomService.countBychat_room_no(chatRoom.getChat_room_no(), chatRoom.getBuyer_mem_no())>0) {
			// 채팅방 정보 확인
			ChatRoom chatRoomTemp = chatRoomService.findBychat_room_no(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no());
			// 채팅 기록 불러오기
			List<ChatRoom> chatHistory = chatRoomService.readChatHistory(chatRoomTemp);
			model.addAttribute("chatHistory", chatHistory);
		} else {
			// 이전 채팅방이 없다면 채팅방 생성
			chatRoomService.addChatRoom(chatRoom);
			// 텍스트 파일 생성
			chatRoomService.createFile(chatRoom.getPro_no(), chatRoomService.get_no(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no()));
		}
		
		// chatRoom 객체를 view로 전달
		model.addAttribute("chatRoomInfo", chatRoom);
		
		return "sub/testChat";
	}
	
	@MessageMapping("/boradcast")
	public void send(ChatRoom chatRoom) throws IOException {
		
		chatRoom.setSendTime(LocalDateTime.now().toString());
		
		chatRoomService.appendMessage(chatRoom);
		
		int chat_room_no = chatRoom.getChat_room_no();
		String url = "/user/" + chat_room_no + "/queue/messages";
		
		ChatRoom temp_chatRoom = new ChatRoom();
		temp_chatRoom.setSender_no(chatRoom.getSender_no());
		temp_chatRoom.setSender_id(chatRoom.getSender_id());
		temp_chatRoom.setContent(chatRoom.getContent());
		temp_chatRoom.setSendTime(chatRoom.getSendTime());
		
		simpMessage.convertAndSend(url, temp_chatRoom);
	}
}