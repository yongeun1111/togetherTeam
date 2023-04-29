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
import com.togetherTeam.platform.entity.Image;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.entity.ProfileImage;
import com.togetherTeam.platform.mapper.chatRoomMapper;
import com.togetherTeam.platform.mapper.productMapper;
import com.togetherTeam.platform.service.ChatRoomService;

import ch.qos.logback.core.util.TimeUtil;


@Controller
public class ChatController {

	@Autowired
	private SimpMessagingTemplate simpMessage;
	
	@Autowired
	private ChatRoomService chatRoomService;
	
	@Autowired
	private productMapper mapper;
	
	
	// 판매자 문의 버튼을 통해 채팅방 생성하거나 채팅리스트로 접속
	@GetMapping("/createChatRoom")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute("chatRoom") ChatRoom addChatRoom) {
		
		// 채팅 화면에 전달할 parameter 설정
		Member member = (Member) session.getAttribute("login");
		int memNo = member.getMem_no(); 
		String memId = member.getMem_id();
		addChatRoom.setBuyer_mem_no(memNo);
		addChatRoom.setBuyer_mem_id(memId);
		
		// 채팅방이 이미 만들어져있는지 확인하고 이전 기록 불러오기
		ChatRoom tempChatRoom = chatRoomService.checkChatRoom(addChatRoom.getPro_no(), addChatRoom.getBuyer_mem_no());
		if (tempChatRoom == null) {
			// 이전 채팅방이 없다면 채팅방 생성하고 채팅방번호 할당
			chatRoomService.createChatRoom(addChatRoom);
		}
		
		
		// chatRoom 객체를 view로 전달
		List<ChatRoom> chatRoomList = chatRoomService.getChatList(memNo);
		int count = 0;
		ProfileImage image = new ProfileImage();
		for (ChatRoom chatRoom : chatRoomList) {
			// 접속 로그인 사용자가 판매자, 구매자 판단
			if (memNo != chatRoom.getBuyer_mem_no()) {
			
				chatRoom.setSeller_mem_id(member.getMem_id());
				String tempId = chatRoomService.getId(chatRoom.getBuyer_mem_no());
				chatRoom.setBuyer_mem_id(tempId);
				
				// 반대쪽 사용자 프로필 이미지 바인딩
				image = chatRoomService.getProfile(chatRoom.getBuyer_mem_no());
				if (image != null) {
					chatRoom.setOpp_upload_path(image.getMem_upload_path());
					chatRoom.setOpp_uuid(image.getMem_uuid());
					chatRoom.setOpp_file_name(image.getMem_file_name());
				}
				// 읽지 않은 메시지 카운트
				count = chatRoomService.findChatRead(chatRoom.getChat_room_no(), chatRoom.getBuyer_mem_no());
		
			} else {
				
				chatRoom.setBuyer_mem_id(member.getMem_id());
				String tempId = chatRoomService.getId(chatRoom.getSeller_mem_no());
				chatRoom.setSeller_mem_id(tempId);
				
				image = chatRoomService.getProfile(chatRoom.getSeller_mem_no());
				if (image != null) {
					chatRoom.setOpp_upload_path(image.getMem_upload_path());
					chatRoom.setOpp_uuid(image.getMem_uuid());
					chatRoom.setOpp_file_name(image.getMem_file_name());					
				}
				
				count = chatRoomService.findChatRead(chatRoom.getChat_room_no(), chatRoom.getSeller_mem_no());
			}
			
			Chat recentChat = chatRoomService.getRecentChat(chatRoom.getChat_room_no());
			if (recentChat != null){
				chatRoom.setRecentChat(recentChat.getChat_content());
			}
			chatRoom.setUnReadChat(count);
		}
		
		model.addAttribute("chatList", chatRoomList);
		
		return "chat";
	}
	
	// 채팅 메시지
	@MessageMapping("/broadcast")
	public void send(Chat chat) throws IOException {
		ChatRoom chatRoom = chatRoomService.findChatRoom(chat.getChat_room_no());
		ProfileImage image = new ProfileImage();
		if (chatRoom.getBuyer_mem_no() != chat.getChat_mem_no()) {
			if (chatRoomService.getProfile(chatRoom.getSeller_mem_no()) != null){
				image = chatRoomService.getProfile(chatRoom.getSeller_mem_no());				
			}
		} else {
			if (chatRoomService.getProfile(chatRoom.getBuyer_mem_no()) != null) {
				image = chatRoomService.getProfile(chatRoom.getBuyer_mem_no());				
			}
		}
		
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
		message.setOpp_upload_path(image.getMem_upload_path());
		message.setOpp_uuid(image.getMem_uuid());
		message.setOpp_file_name(image.getMem_file_name());
				
		simpMessage.convertAndSend(url, message);
	}
	
	// 헤더에서 채팅리스트 접속
	@RequestMapping("/chat")
	public String getUserChatList(HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("login");
		int memNo = member.getMem_no();
		int count = 0;
		
		List<ChatRoom> chatList = chatRoomService.getChatList(memNo);
		ProfileImage image = new ProfileImage();
		for (ChatRoom chatRoom : chatList) {
			// 접속 로그인 사용자가 판매자, 구매자 판단
			if (memNo != chatRoom.getBuyer_mem_no()) {
			
				chatRoom.setSeller_mem_id(member.getMem_id());
				String tempId = chatRoomService.getId(chatRoom.getBuyer_mem_no());
				chatRoom.setBuyer_mem_id(tempId);
				
				// 반대쪽 사용자 프로필 이미지 바인딩
				image = chatRoomService.getProfile(chatRoom.getBuyer_mem_no());
				if (image != null) {
					chatRoom.setOpp_upload_path(image.getMem_upload_path());
					chatRoom.setOpp_uuid(image.getMem_uuid());
					chatRoom.setOpp_file_name(image.getMem_file_name());
				}
				// 읽지 않은 메시지 카운트
				count = chatRoomService.findChatRead(chatRoom.getChat_room_no(), chatRoom.getBuyer_mem_no());
		
			} else {
				
				chatRoom.setBuyer_mem_id(member.getMem_id());
				String tempId = chatRoomService.getId(chatRoom.getSeller_mem_no());
				chatRoom.setSeller_mem_id(tempId);
				
				image = chatRoomService.getProfile(chatRoom.getSeller_mem_no());
				if (image != null) {
					chatRoom.setOpp_upload_path(image.getMem_upload_path());
					chatRoom.setOpp_uuid(image.getMem_uuid());
					chatRoom.setOpp_file_name(image.getMem_file_name());					
				}
				
				count = chatRoomService.findChatRead(chatRoom.getChat_room_no(), chatRoom.getSeller_mem_no());
			}
			
			Chat recentChat = chatRoomService.getRecentChat(chatRoom.getChat_room_no());
			if (recentChat != null){
				chatRoom.setRecentChat(recentChat.getChat_content());
			}
			chatRoom.setUnReadChat(count);
		}
		model.addAttribute("chatList", chatList);
		return "chat";
	}
	
	// 채팅방 리스트에서 채팅방으로 접속
	@PostMapping("/getChatHistory")
	@ResponseBody
	public Map getChatHistory(int chatRoomNo, int senderNo) {
		
		List<Chat> chatHistory = chatRoomService.readChatHistory(chatRoomNo);
		ChatRoom chatRoomInfo = chatRoomService.findChatRoom(chatRoomNo);
		Product productInfo = mapper.chatRoomProduct(chatRoomInfo.getPro_no());
		
		ProfileImage image = new ProfileImage(); 
		for (Chat chat : chatHistory) {
			if (senderNo != chat.getChat_mem_no()) {
				chatRoomService.updateChatRead(chatRoomNo, chat.getChat_mem_no());
				if (chatRoomService.getProfile(chat.getChat_mem_no()) != null) {
					image = chatRoomService.getProfile(chat.getChat_mem_no());
					chat.setOpp_upload_path(image.getMem_upload_path());
					chat.setOpp_uuid(image.getMem_uuid());
					chat.setOpp_file_name(image.getMem_file_name());
										
				};
			};
		};
		Map<String, Object> chat = new HashMap<>();
		
		chat.put("chatHistory", chatHistory);
		chat.put("chatRoomInfo", chatRoomInfo);
		chat.put("productInfo", productInfo);
		
		return chat;
	}
	
	// 채팅 읽음 처리
	@PostMapping("/chatReadCount")
	@ResponseBody
	public int chatReadCount(int memNo) {
		int count = 0;
		int tempNo = 0;
		List<ChatRoom> chatList = chatRoomService.getChatList(memNo);
		for (ChatRoom chatRoom : chatList) {
			if (memNo != chatRoom.getBuyer_mem_no()) {
				tempNo = chatRoom.getBuyer_mem_no();
				count += chatRoomService.findChatRead(chatRoom.getChat_room_no(), tempNo);
			} else {
				tempNo = chatRoom.getSeller_mem_no();
				count += chatRoomService.findChatRead(chatRoom.getChat_room_no(), tempNo);
			}
		}
		
		return count;
	}
	
}