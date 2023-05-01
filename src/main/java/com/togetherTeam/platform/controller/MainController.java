package com.togetherTeam.platform.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.togetherTeam.platform.entity.CriteriaList;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.PageMakerList;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.entity.ProfileImage;
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
        int page = 1;
        int perPageNum = 8;
        CriteriaList cri = new CriteriaList(page,perPageNum);
		List<Product> list = mapper_pro.getAllList(cri);
        model.addAttribute("allList", list);
        
        String theme = "#슬기로운 자취 생활";
        List<Product> theme_list = mapper_pro.getThemeListMain(theme);
        model.addAttribute("themeList", theme_list);
        
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
	
	@PostMapping("/check_id")
	@ResponseBody
	public Map<String, String> check_id(@RequestParam String id) {
	    Map<String, String> result = new HashMap<>();
	    int check = mapper.check_id(id);
	    
	    if (check == 0) {
	      result.put("result", "success");
	    } else {
	      result.put("result", "fail");
	    }
	    
	    return result;
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
		System.out.println(vo);
		int result = mapper.join(vo);
		
		if(result == 0) { // 회원가입실패
	        rttr.addFlashAttribute("error", "회원가입이 실패하였습니다.");
	        return "join"; // 회원가입 페이지로 이동
	    } else { // 회원가입성공
	    	if (vo.getMem_upload_path() != null) {
	    		ProfileImage profileImage = new ProfileImage();
	    		profileImage.setMem_no(vo.getMem_no());
	    		profileImage.setMem_upload_path(vo.getMem_upload_path());
	    		profileImage.setMem_uuid(vo.getMem_uuid());
	    		profileImage.setMem_file_name(vo.getMem_file_name());
	    		mapper.insertProfileImage(profileImage);	    		
	    	}
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
	
	@PostMapping("/search_id") // 아이디찾기
	@ResponseBody
	public List<Member> search_idPost(Member vo) {
		List<Member> result = mapper.search_id(vo);
	    return result;
	}
	
	@PostMapping("/search_pwd") // 비밀번호찾기
	@ResponseBody
	public List<Member> search_pwdPost(Member vo) {
		List<Member> result = mapper.search_pwd(vo);
	    return result;
	}

	
	@GetMapping("/change_pwd") // test 로그인 및 회원가입 등을 하는 페이지
    public String change_pwdGet(String mem_id, Model model){
		model.addAttribute("mem_id", mem_id);
        return "change_pw";
    }
	
	@PostMapping("/change_pwd") // test 로그인 및 회원가입 등을 하는 페이지
	public String change_pwdPost(Member vo){
		mapper.change_pwd(vo);
		return "login";
	}
	
	
	@RequestMapping("/logout") // 로그아웃
	public String logoutPost(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:";
	}
	
	 // 첨부 파일 업로드
    // ResponseEntity : Http body에 뷰로 전달하고 싶은 데이터를 포함시켜서 보냄 + status(상태 코드) 조작 가능
    @PostMapping(value="/uploadProfileImage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity uploadProfileImage(MultipartFile uploadFile) {
    	
    	// 이미지 파일인지 체크하기
    		
    		// System.out.println("파일이름 : " + multipartFile.getOriginalFilename());
    		// System.out.println("파일타입 : " + multipartFile.getContentType());
    		
    		
    		// 전달받은 uploadFile을 File 객체로 만들고 변수에 대입
    		File checkfile = new File(uploadFile.getOriginalFilename());
    		
    		// MIME TYPE : 어떤 종류의 파일인지에 대한 정보가 담긴 라벨
    		// MIME TYPE을 저장할 변수
    		String type = null;
    		
    		try {
    			
    			type = Files.probeContentType(checkfile.toPath());
    			// System.out.println("MIME TYPE : " + type);
    		
    		} catch(IOException e) {
    			e.printStackTrace();
    		}
    		
    		// srstsWith("image") : String 타입의 데이터를 파라미터로 전달받고 체크 대상인 image와 같으면 true, 아니면 false 반환
    		if(!type.startsWith("image")) {
    			
    			// 이미지 타입이 아니므로 null 값으로 만들어준다
    			ProfileImage image = null;
    			
    			return new ResponseEntity(image, HttpStatus.BAD_REQUEST);
    			
    		}
    	
    	
    	// 저장 경로 설정
    	// String uploadFolder = "C:\\Users\\smhrd\\git\\togetherTeam\\src\\main\\webapp\\resource\\upload";
    	// 상대 경로로 변경
    	String uploadFolder = "src/main/webapp/resource/upload";
    	
    	
    	// 날짜 폴더 경로
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		// -를 기준으로 분리하여 폴더 생성
		String datePath = str.replace("-", File.separator);
		
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
	
		ProfileImage vo = new ProfileImage();
		
		/* 파일 이름 */
		String uploadFileName = uploadFile.getOriginalFilename();
		// 정보를 객체에 저장
		vo.setMem_file_name(uploadFileName);
		vo.setMem_upload_path(datePath);
		
		/* uuid 적용 파일 이름 */
		String uuid = UUID.randomUUID().toString();
		vo.setMem_uuid(uuid);
		
		uploadFileName = uuid + "_" + uploadFileName;
		
		/* 파일 위치, 파일 이름을 합친 File 객체 */
		File saveFile = new File(uploadPath, uploadFileName);
		
		/* 파일 저장 */
		try {
			
			uploadFile.transferTo(saveFile);
			
			// 대표 이미지 이름
			File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
			
			// BufferedImage : 데이터 처리, 조작
			// 원본 이미지를 BufferedImage 타입으로 변경
			BufferedImage bo_image = ImageIO.read(saveFile);
			
			
			// 비율
			double ratio = 3;
			// 넓이 높이
			int width = (int) (bo_image.getWidth() / ratio);
			int height = (int) (bo_image.getHeight() / ratio);
			
			
			// 넓이, 높이, 생성될 이미지 타입 지정
			BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
			
			// Graphics2D : 그림을 그리는데 필요로 한 설정값과 메서드 제공
			// Grapghics2D 객체 생성
			Graphics2D graphic = bt_image.createGraphics();
			
			// 그리고자 하는 이미지, 그리기 시작하는 x좌표, 그리기 시작하는 y좌표, 넓이, 높이, 이미지 업데이트
			graphic.drawImage(bo_image, 0, 0, width, height, null);
			
			// 이미지 저장 (저장할 이미지, 이미지형식, 이미지 이름)
			ImageIO.write(bt_image, "jpg", thumbnailFile);
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}
			
			
    	
    	ResponseEntity<ProfileImage> result = new ResponseEntity<ProfileImage>(vo, HttpStatus.OK);
    
    	return result;
    }
}
