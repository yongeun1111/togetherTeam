package com.example.portfolio_23.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(name = "/")
public class MainController  {


    public String main(){
        System.out.println("main controller start");
        return "index";
    }

}
