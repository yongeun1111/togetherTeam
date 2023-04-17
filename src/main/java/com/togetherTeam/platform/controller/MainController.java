package com.togetherTeam.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController  {

	@RequestMapping("/")
    public String main(){
        System.out.println("main controller start");
        return "index";
    }
	
	@RequestMapping("test")
	public String test() {
		return "test";
	}
}
