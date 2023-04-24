package com.togetherTeam.platform.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.togetherTeam.platform.entity.ChatRoom;
import com.togetherTeam.platform.entity.CriteriaList;
import com.togetherTeam.platform.entity.Image;
import com.togetherTeam.platform.entity.LikeList;
import com.togetherTeam.platform.entity.Member;
import com.togetherTeam.platform.entity.PageMakerList;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.mapper.productMapper;

@Controller
public class productController {

	@Autowired
	private productMapper mapper;
	
	@GetMapping("/proList") // 중고 상품 페이지(proList.jsp)로 이동
    public String proList(CriteriaList cri, Model model){

		List<Product> list = mapper.getAllList(cri);
		model.addAttribute("list", list);
		
		PageMakerList pageMakerList = new PageMakerList();
		pageMakerList.setCri(cri);
		pageMakerList.setTotalCount(mapper.totalCount());
		model.addAttribute("pm", pageMakerList);
		
        return "sub/proList";
    }
	
	@GetMapping("/proView") // 중고 상품 페이지(proList.jsp)로 이동
    public String proView(Model model, @RequestParam int pro_no, HttpSession session){
		Member user = (Member)session.getAttribute("login");
		if(user != null) {
		LikeList vo = new LikeList();
		vo.setPro_no(pro_no);
		vo.setMem_no(user.getMem_no());
		int result = mapper.likeCheck(vo);
		model.addAttribute("result",result);
		}
		// 상품 정보 담아오기

		// .....
		
        return "sub/proView";
    }
	
	
    @GetMapping("/registration") // 상품 등록하기 페이지(registration.jsp)로 이동
    public String registration(HttpSession session, Model model){
    	Member loginMember = (Member)session.getAttribute("login");
    	if(loginMember == null) {
    		// 로그인하지 않은 사용자는 로그인 페이지로 이동
    		return "redirect:/login";
    	}else {
    		// 로그인한 사용자는 상품 등록 페이지로 이동
    		model.addAttribute("login", loginMember);
    		return "sub/registration";
    	}
    	
    }
    
    @PostMapping("/registration") // 상품등록하기
    public String registration(Product vo) {
    	
    	// System.out.println("vo.getImageList()"+vo.getImageList());
    	
    	System.out.println(vo);
    	// mapper.productRegister(vo);
    	
    	// 이미지 없을 경우
//    	if(vo.getImageList() == null || vo.getImageList().size() <= 0) {
//    		
//    	}
    	
    	//System.out.println(vo.getImageList());
    	//[Image(pro_no=0, img_no=0, img_date=null, upload_path=2023\04\20,2023\04\20, uuid=fee84e61-63c2-4abd-95e3-d36544d1a901,072f3cd7-5b9f-4509-b5b6-4103858e2b36, file_name=1123.jpg,3333.jfif)]
    	
    	// imageList 각 요소 하나씩 넘겨주기
    	for(Image attach : vo.getImageList()) {
    		
    		// 이미지에 물품 번호 등록
    		attach.setPro_no(vo.getPro_no());
    		// System.out.println(attach);
    		
    		mapper.imageEnroll(attach);
    		
    	}
    	
    	return "home";
    }
    
    // 첨부 파일 업로드
    // ResponseEntity : Http body에 뷰로 전달하고 싶은 데이터를 포함시켜서 보냄 + status(상태 코드) 조작 가능
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<Image>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
    	
    	// 이미지 파일인지 체크하기
    	for(MultipartFile multipartFile: uploadFile) {
    		
    		// System.out.println("파일이름 : " + multipartFile.getOriginalFilename());
    		// System.out.println("파일타입 : " + multipartFile.getContentType());
    		
    		
    		// 전달받은 uploadFile을 File 객체로 만들고 변수에 대입
    		File checkfile = new File(multipartFile.getOriginalFilename());
    		
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
    			List<Image> list = null;
    			
    			return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
    			
    		}
    	}
    	
    	// 저장 경로 설정
    	String uploadFolder = "C:\\Users\\smhrd\\git\\togetherTeam\\src\\main\\webapp\\resource\\upload";
    	
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
		
		// 이미지 정보 담는 객체
		List<Image> list = new ArrayList<>();
		
    	
    	for(MultipartFile multipartFile : uploadFile) {
    		
    		// 이미지 정보 객체
    		Image vo = new Image();
    		
    		/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			// 정보를 객체에 저장
			vo.setFile_name(uploadFileName);
			vo.setUpload_path(datePath);
			
			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);
			
			/* 파일 저장 */
			try {
				
				multipartFile.transferTo(saveFile);
				
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
			
			// 이미지 정보가 저장된 객체를 list 요소로 추가
			list.add(vo);
			
    	}
    	
    	ResponseEntity<List<Image>> result = new ResponseEntity<List<Image>>(list, HttpStatus.OK);
    
    	return result;
    }
    
    @GetMapping("/test")
	public String test(Model model) {
		ChatRoom chatRoom = new ChatRoom();
		model.addAttribute("chatRoom", chatRoom);
		Product vo = mapper.test();
		model.addAttribute("vo", vo);
		return "test";		
	}
    
    @PostMapping("/testChat") // 채팅 테스트
    public String testChat(Model model, Product vo) {
    	
    	model.addAttribute("pro", vo);
    	return "sub/testChat";
    }
    
    @PostMapping("/like")
    public int like() {
    	
    	return 1;
    }
    

    
    
}
