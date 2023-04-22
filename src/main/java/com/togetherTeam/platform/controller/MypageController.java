package com.togetherTeam.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.togetherTeam.platform.entity.CriteriaSale;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.PageSale;
import com.togetherTeam.platform.mapper.memberMapper;
import com.togetherTeam.platform.mapper.productMapper;

@Controller
public class MypageController {

	@Autowired
	private memberMapper mapper;
	
	@Autowired
	private productMapper mapper_pro;

	@GetMapping("/mypage_memInfo") // 마이페이지(mypage.jsp)로 이동
    public String mypage_memInfo(){
        return "sub/mypage_memInfo";
    }
	
	@PostMapping("/change_info") // 회원정보수정
	public String change_infoPost(Member vo, HttpSession session) {
		mapper.change_info(vo);
		Member result = mapper.update_login(vo);
		session.setAttribute("login", result);
		return "redirect:";
	}
	
	@RequestMapping("/mypage_proSale") // 판매 내역으로 이동
	public String mypage_proSale(HttpSession session, CriteriaSale cri, Model model) {
		
		Member member = (Member)session.getAttribute("login");
		
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mem_no", member.getMem_no());
		paramMap.put("cri", cri);
		// System.out.println(paramMap);
		List list = mapper_pro.getMemProductList(paramMap);
		// for(int i = 0; i < list.size(); i++) {
		// 	System.out.println("result......." + i + " : " + list.get(i));
		// }
		
		// 페이지 데이터 넘기기
		PageSale pagesale = new PageSale();
		pagesale.setCri(cri);
		pagesale.setMemProTotalCount(mapper_pro.memProTotalCount(member));
		model.addAttribute("pm", pagesale);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		}else {
			model.addAttribute("listCheck", "판매 내역이 존재하지 않습니다.");
		}
		
		// int proCount = mapper_pro.memProTotalCount(member);
		// System.out.println(proCount);
		return "sub/mypage_proSale";
	}
	
}
