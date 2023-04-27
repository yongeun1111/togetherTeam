package com.togetherTeam.platform.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.togetherTeam.platform.entity.CriteriaList;
import com.togetherTeam.platform.entity.CriteriaSale;
import com.togetherTeam.platform.entity.Image;
import com.togetherTeam.platform.entity.LikeList;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.MypageLikeList;
import com.togetherTeam.platform.entity.PageMakerList;
import com.togetherTeam.platform.entity.PageSale;
import com.togetherTeam.platform.entity.Product;
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

	@GetMapping("/mypage_likeList") // 마이페이지(mypage_likeList.jsp)로 이동
    public String mypage_likeList(CriteriaList cri, HttpSession session, Model model){
		Member vo = (Member)session.getAttribute("login");
		List<Product> cnt = mapper.mypage_likeList_count(vo);
		int mem_no = vo.getMem_no();
		cri.setPerPageNum(5);
		MypageLikeList mll = new MypageLikeList(mem_no,cri.getPage(),cri.getPerPageNum());
		List<Product> list = mapper.mypage_likeList(mll);
		
		if (list.isEmpty()) {
	        if (cri.getPage() >= 2) {
	        	cri.setPage(cri.getPage()-1);
	            // 감소된 currentPage를 기반으로 리스트 데이터 다시 받아오기
	            mll = new MypageLikeList(mem_no, cri.getPage(), cri.getPerPageNum());
	            list = mapper.mypage_likeList(mll);

	        }
	    }
		model.addAttribute("list", list);		
		
		ArrayList<List<Image>> image = new ArrayList<>();
		
		for(Product p : list) {
			int pro_no = p.getPro_no();
			List<Image> im = mapper_pro.getProductOneImage(pro_no);
			image.add(im);
		}
		// System.out.println(image);
		model.addAttribute("image", image);
		
		
		PageMakerList pageMakerList = new PageMakerList();
		pageMakerList.setCri(cri);
		pageMakerList.setTotalCount(cnt.size());
		model.addAttribute("pm", pageMakerList);
		
        return "sub/mypage_likeList";
    }
	
	@PostMapping("/likeInsert")
	@ResponseBody
	public Map<String, Object> likeInsert(LikeList vo, HttpSession session, @RequestParam int pro_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		Member user = (Member)session.getAttribute("login");
		if (user == null) {
			map.put("result", "not_login");
			return map;
		}
		int mem_no = user.getMem_no();
		vo.setMem_no(mem_no);
		try {
			mapper.likeInsert(vo);
			mapper_pro.likeCountSave(pro_no);
			int cnt = mapper_pro.likeCount(pro_no);
			map.put("result", "success");
			map.put("likeCnt", cnt);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}
		
	@PostMapping("/likeDelete")
	@ResponseBody
	public Map<String, Object> likeDelete(LikeList vo, HttpSession session, @RequestParam int pro_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		Member user = (Member)session.getAttribute("login");
		if (user == null) {
			map.put("result", "not_login");
			return map;
		}
		int mem_no = user.getMem_no();
		vo.setMem_no(mem_no);
		try {
			mapper.likeDelete(vo);
			mapper_pro.likeCountSave(pro_no);
			int cnt = mapper_pro.likeCount(pro_no);
			System.out.println(cnt);
			map.put("result", "success");
			map.put("likeCnt", cnt);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}
	
	@PostMapping("/likeDelete_mypage")
	public String deleteLikeList(LikeList vo, HttpSession session, 
			@RequestParam(defaultValue = "1") int page, RedirectAttributes rttr) {
	    Member user = (Member) session.getAttribute("login");
	    int mem_no = user.getMem_no();
	    vo.setMem_no(mem_no);
	    try {
	        mapper.likeDelete(vo);
	    } catch(Exception e) {
	        e.printStackTrace();
	        // 에러 처리
	    }

	    rttr.addAttribute("page", page);
	    return "redirect:/mypage_likeList";
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
	
	@PostMapping("/proSaleChange")
	@ResponseBody
	public Map<String, Object> proSaleChange(@RequestParam int pro_no){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		mapper_pro.proSaleCh(pro_no);
		Product pro_sale = mapper_pro.getProduct(pro_no);
		
		map.put("pro", pro_sale);
		
		return map;
	}
	
}
