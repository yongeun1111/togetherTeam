package com.togetherTeam.platform.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

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
	
	
	
	// 채팅
	@GetMapping("/chatMessage")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute("chatRoom") ChatRoom chatRoom) throws IOException {
		
		
		// 채팅 화면에 전달할 parameter 설정
		Member member = (Member) session.getAttribute("login");
		int buyerNo = member.getMem_no(); 
		String buyerId = member.getMem_id();
		chatRoom.setBuyer_mem_no(buyerNo);
		chatRoom.setBuyer_mem_id(buyerId);
		
		// 채팅방이 이미 만들어져있는지 확인하고 이전 기록 불러오기
		if (chatRoomService.countChatRoomNo(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no())>0) {
			// 채팅방 정보 확인
			ChatRoom tempChatRoom = chatRoomService.findChatRoomNo(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no());
			// 채팅 기록 불러오기
			List<ChatRoom> chatHistory = chatRoomService.readChatHistory(tempChatRoom);
			model.addAttribute("chatHistory", chatHistory);
		} else {
			// 이전 채팅방이 없다면 채팅방 생성
			chatRoomService.addChatRoom(chatRoom);
			// 텍스트 파일 생성
			chatRoomService.createFile(chatRoom.getPro_no(), chatRoomService.getNo(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no()));
		}
		
		chatRoom.setChat_room_no(chatRoomService.getNo(chatRoom.getPro_no(), chatRoom.getBuyer_mem_no()));
		
		// chatRoom 객체를 view로 전달
		model.addAttribute("chatRoomInfo", chatRoom);
		
		return "testChat";
	}
	
	@MessageMapping("/broadcast")
	public void send(ChatRoom chatRoom) throws IOException {
		
		System.out.println(chatRoom);
		chatRoom.setSendTime(LocalDateTime.now().toString());
		
		chatRoomService.appendMessage(chatRoom);
		
		int chatRoomNo = chatRoom.getChat_room_no();
		String url = "/user/" + chatRoomNo + "/queue/messages";
		
		ChatRoom tempChatRoom = new ChatRoom();
		tempChatRoom.setSender_no(chatRoom.getSender_no());
		tempChatRoom.setSender_id(chatRoom.getSender_id());
		tempChatRoom.setContent(chatRoom.getContent());
		tempChatRoom.setSendTime(chatRoom.getSendTime());
		
		simpMessage.convertAndSend(url, tempChatRoom);
	}
	
	@RequestMapping("/userChatInfo")
	public String getUserChatList(HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("login");
		int memNo = member.getMem_no();

		List<ChatRoom> chatRoom = chatRoomService.getChatList(memNo);
		
		model.addAttribute("chatList", chatRoom);
		System.out.println(chatRoom);
		return "userChatInfo";
	}
	
	@RequestMapping("/userToChat")
	public String getChatRoom(Model model, int chatRoomNo) throws IOException {
		
		ChatRoom chatRoomRead = chatRoomService.findChatRoom(chatRoomNo);
		int proNo = chatRoomRead.getPro_no();
		int buyerNo = chatRoomRead.getBuyer_mem_no();
		List<ChatRoom> chatHistory = chatRoomService.readChatHistory(chatRoomRead);
		
		model.addAttribute("chatHistory", chatHistory);
		
		String proTitle = chatRoomRead.getPro_title();
		int sellerNo = chatRoomRead.getSeller_mem_no();
		model.addAttribute("chatRoomNo", chatRoomNo);
		model.addAttribute("proNo", proNo);
		model.addAttribute("buyerNo", buyerNo);
		model.addAttribute("sellerNo", sellerNo);
		model.addAttribute("proTitle", proTitle);
		
		return "chatBroadcastChatRoom";
	}
}