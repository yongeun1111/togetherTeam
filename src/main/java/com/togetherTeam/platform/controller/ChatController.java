package com.togetherTeam.platform.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.togetherTeam.platform.entity.ChatRoom;
import com.togetherTeam.platform.entity.Member;


@Controller
public class ChatController {

	@Autowired
	private SimpMessagingTemplate simpMessage;
	
	
	// 채팅
	@RequestMapping("/chatMessage")
	public String getWebSocketWithSockJs(Model model, HttpSession session, @ModelAttribute("chatRoom") ChatRoom chatRoom) throws IOException {
		
		// 채팅 화면에 전달할 parameter 설정
		Member member = (Member) session.getAttribute("login");
		int buyer_mem_no = member.getMem_no(); 
		String buyer_mem_id = member.getMem_id();
		chatRoom.setBuyer_mem_no(buyer_mem_no);
		chatRoom.setBuyer_mem_id(buyer_mem_id);
		
		// chatRoom 이미 만들어져있는지 확인
		return "chatBroadcastProduct";
	}
}