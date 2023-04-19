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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.mapper.memberMapper;
import com.togetherTeam.platform.mapper.productMapper;

@Controller
public class MainController  {

	@Autowired
	private memberMapper mapper;
	
	@Autowired
	private productMapper mapper_pro;
	
	@RequestMapping("/")
    public String main(Model model){
        List<Product> list = mapper_pro.getAllListRecent();
        model.addAttribute("allList", list);
        return "home";
    }

	@GetMapping("/get-products")
	@ResponseBody
	public List<Product> getProducts(String category) {
	    List<Product> productList = mapper_pro.getCategoryListRecent(category);
	    return productList;
	}
	

    @GetMapping("/proSearch") // 상품 검색 페이지(proSearch.jsp)로 이동
    public String proSearch(){
        return "sub/proSearch";
    }


	
	@GetMapping("/login") // test 로그인 및 회원가입 등을 하는 페이지
    public String loginGet(){
        System.out.println("main controller start");
        return "login";
    }
	
	@PostMapping("/login") // login 성공시 home으로 이동
    public String loginPost(Member vo, Model model, HttpSession session){
	    Member result = mapper.login(vo);
	    if(result == null) { // 로그인 실패 시
	        model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
	        // 로그인페이지에서 {error}를 열어봤을때, 오류 문장이 있으면 모덜창으로 보여주기?
	        return "login"; // 로그인 페이지로 이동
	    } else { // 로그인 성공 시
	        session.setAttribute("login", result); // 로그인 정보를 세션에 저장
	        return "redirect:"; // 홈 페이지로 이동
	    }
    }
	
	@GetMapping("/join") // join 회원가입 페이지(join.jsp)로 이동
    public String joinGet(){
        return "join";
    }

	@PostMapping("/check_password")
	@ResponseBody
	public Map<String, String> checkPassword(@RequestParam String pw, @RequestParam String pw2) {
	    Map<String, String> result = new HashMap<>();
	    
	    if (pw.equals(pw2)) {
	      result.put("result", "success");
	    } else {
	      result.put("result", "fail");
	    }
	    
	    return result;
	}
	
	@PostMapping("/join") // 회원가입진행
    public String joinPost(Member vo, RedirectAttributes rttr, String mem_id){
		int result = mapper.join(vo);
		if(result == 0) { // 회원가입실패
	        rttr.addFlashAttribute("error", "회원가입이 실패하였습니다.");
	        return "join"; // 회원가입 페이지로 이동
	    } else { // 회원가입성공
	        rttr.addFlashAttribute("join", mem_id); // 입력한 회원아이디
	        return "redirect:join_success"; // 로그인페이지로 이동
	    }
    }
	
	@GetMapping("/join_success") // join 회원가입 완료 페이지(join_success.jsp)로 이동
    public String joinSuccess(){
        return "join_success";
    }
	
	@GetMapping("/search_idpw") // search_idpw 아이디찾기 페이지로 이동
    public String search_idGet(){
        return "search_idpw";
    }
	
	@PostMapping("/search_id") // search_id 아이디찾기 페이지로 이동
    public String search_idPost(Member vo, Model model){
		Member result = mapper.search_id(vo);
		if(result == null) { // 조회결과가 없을때
	        model.addAttribute("error", "입력하신 정보와 일치하는 아이디가 없습니다.");
	        return "search_id"; // 아이디찾기 페이지로 이동
	    } else { // 조회 성공시
	        model.addAttribute("search_id", result); // 조회결과 정보를 모델에 저장
	        return "login"; // 로그인페이지로 이동
	    }
    }

	@PostMapping("/search_pwd") // search_pwd 비밀번호찾기 페이지로 이동
    public String search_pwdPost(Member vo, Model model){
		Member result = mapper.search_pwd(vo);
		if(result == null) { // 조회결과가 없을때
	        model.addAttribute("error", "입력하신 정보와 일치하는 계정이 없습니다.");
	        return "search_"; // 비밀번호찾기 페이지로 이동
	    } else { // 조회 성공시
	        model.addAttribute("search_idpw", result); // 조회결과 정보를 모델에 저장
	        return "change_pw"; // 비밀번호 변경 페이지로 이동
	    }
    }
	
	@RequestMapping("/logout") // 로그아웃
	public String logoutPost(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:";
	}
}
