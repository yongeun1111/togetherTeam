package com.togetherTeam.platform.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.togetherTeam.platform.entity.Image;
import com.togetherTeam.platform.entity.Product;
import com.togetherTeam.platform.mapper.productMapper;

@Controller
public class ImageController {
	
	@Autowired
	private productMapper mapper;
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String file_name){
		
		// System.out.println("getImage() : " + file_name);
		
		File file = new File("c:\\upload\\" + file_name);
		
		// 뷰로 반환할 ResponseEntity 객체의 주소를 저장할 참조 변수 선언
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			// header의 "Content-type"값에 Files.probeContentType(file.toPath()) 부여
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			// (출력시킬 대상 이미지 데이터 파일, header의 설정이 부여된 객체 추가, 상태 코드)
			// FileCopyUtils.copyToByteArray(file) : 대상 파일을 복사하여 Byte 배열로 반환
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	// 이미지 삭제
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String file_name){
	
		File file = null;
		
		try {
			// 대표 파일 삭제
			file = new File("c:\\upload\\" + URLDecoder.decode(file_name, "UTF-8"));
			file.delete();
			
			// 원본 파일 삭제
			String originFileName = file.getAbsolutePath().replace("s_","");
			// System.out.println("originFileName : "+ originFileName);
			
			file = new File(originFileName);
			file.delete();
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
		
	}
	
	// 이미지 등록
//	@RequestMapping("")
//	public void imageEnroll(Image vo) {
//		
//		vo.setPro_no(1);
//		vo.setUpload_path("test");
//		vo.setUuid("test2");
//		vo.setFile_name("test");
//		
//		mapper.imageEnroll(vo);
//		
//	}
	
	// 테스트
//	@RequestMapping("/test")
//	public void testregi(Product vo) {
//		
//		vo.setSeller_mem_no(1);
//    	vo.setPro_title("오징어");
//    	vo.setPro_category("땅콩");
//    	vo.setPro_name("맛있다");
//    	vo.setPro_theme("너도");
//    	vo.setPro_buy_price(200);
//    	vo.setPro_sale_price(500);
//    	vo.setPro_content("사 먹어");
//    	vo.setBuy_date("2023-04-20");
//    	
//    	System.out.println("Before :" + vo);
//    	
//    	// System.out.println(vo);
//    	mapper.productRegister(vo);
//    	
//    	System.out.println("After :" + vo);
//	}
	
	// 테스트
//	@RequestMapping("/test")
//	public void bookEnrollTEsts() {
//
//		Product pro = new Product();
//		// 상품 정보
//		pro.setSeller_mem_no(1);
//		pro.setPro_title("개구리");
//		pro.setPro_category("개구리");
//		pro.setPro_name("개구리");
//		pro.setPro_theme("개구리");
//		pro.setBuy_date("2012-12-15");
//		pro.setPro_buy_price(300);
//		pro.setPro_sale_price(50000);
//		pro.setPro_content("책 소개 ");
//
//		// 이미지 정보
//		List<Image> imageList = new ArrayList<Image>(); 
//		
//		Image image1 = new Image();
//		Image image2 = new Image();
//		
//		image1.setFile_name("test Image 1");
//		image1.setUpload_path("test image 1");
//		image1.setUuid("test1111");
//		
//		image2.setFile_name("test Image 2");
//		image2.setUpload_path("test image 2");
//		image2.setUuid("test2222");
//		
//		imageList.add(image1);
//		imageList.add(image2);
//		
//		pro.setImageList(imageList);        
//		
//		// productRegister() 메서드 호출
//		mapper.productRegister(pro);
//		
//    	for(Image attach : pro.getImageList()) {
//    		
//    		// 이미지에 물품 번호 등록
//    		attach.setPro_no(pro.getPro_no());
//    		mapper.imageEnroll(attach);
//    	}
//		
//		System.out.println("등록된 상품 : " + pro);
//		
//		
//	}

}
