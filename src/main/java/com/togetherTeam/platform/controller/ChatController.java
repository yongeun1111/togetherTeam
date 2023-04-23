package com.togetherTeam.platform.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.DateTimeAtCompleted;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.togetherTeam.platform.entity.Chat;
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
	
	
	
	// 채팅방 생성, 이전 채팅방 접속
	@GetMapping("/createChatRoom")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute("chatRoom") ChatRoom chatRoom) {
		
		// 채팅 화면에 전달할 parameter 설정
		Member member = (Member) session.getAttribute("login");
		int buyerNo = member.getMem_no(); 
		String buyerId = member.getMem_id();
		chatRoom.setBuyer_mem_no(buyerNo);
		chatRoom.setBuyer_mem_id(buyerId);
		
		// 채팅방이 이미 만들어져있는지 확인하고 이전 기록 불러오기
		ChatRoom tempChatRoom = chatRoomService.checkChatRoom(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no());
		if (tempChatRoom != null) {
			// 채팅 기록 불러오기
			chatRoom.setChat_room_no(tempChatRoom.getChat_room_no());
			List<Chat> chatHistory = chatRoomService.readChatHistory(tempChatRoom.getChat_room_no());
			model.addAttribute("chatHistory", chatHistory);
		} else {
			// 이전 채팅방이 없다면 채팅방 생성하고 채팅방번호 할당
			chatRoomService.createChatRoom(chatRoom);
			tempChatRoom = chatRoomService.checkChatRoom(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no());
			chatRoom.setChat_room_no(tempChatRoom.getChat_room_no());
		}
		
		// chatRoom 객체를 view로 전달
		model.addAttribute("chatRoomInfo", chatRoom);
		
		return "chatRoom";
	}
	
	// 채팅 메시지
	@MessageMapping("/broadcast")
	public void send(Chat chat) throws IOException {
		
		LocalDateTime now = LocalDateTime.now();
        chat.setChat_date(now);
		
        chatRoomService.insertChat(chat);
		
		int chatRoomNo = chat.getChat_room_no();
		String url = "/user/" + chatRoomNo + "/queue/messages";
		
		Chat message = new Chat();
		message.setChat_mem_no(chat.getChat_mem_no());
		message.setChat_mem_id(chat.getChat_mem_id());
		message.setChat_content(chat.getChat_content());
		message.setChat_date(chat.getChat_date());
		
		simpMessage.convertAndSend(url, message);
	}
	
	// 채팅방 리스트
	@RequestMapping("/chat")
	public String getUserChatList(HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("login");
		int memNo = member.getMem_no();

		List<ChatRoom> chatRoom = chatRoomService.getChatList(memNo);
		
		model.addAttribute("chatList", chatRoom);
		return "chat";
	}
	
	// 채팅방 리스트에서 채팅방으로 접속
	@PostMapping("/getChatHistory")
	@ResponseBody
	public Map getChatHistory(int chatRoomNo) {
		
		List<Chat> chatHistory = chatRoomService.readChatHistory(chatRoomNo);
		ChatRoom chatRoomInfo = chatRoomService.findChatRoom(chatRoomNo);
		
		Map<String, Object> chat = new HashMap<>();
		chat.put("chatHistory", chatHistory);
		chat.put("chatRoomInfo", chatRoomInfo);
				
		return chat;
	}
	
}