package com.gd.test.web.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestC {
	@RequestMapping(value = "/testC")
	public ModelAndView testC(ModelAndView mav) {
		mav.setViewName("test/testC");
		
		return mav;
	}
	
	@RequestMapping(value = "/testTopLeft")
	public ModelAndView testTopLeft(ModelAndView mav) {
		mav.setViewName("test/testTopLeft");
		
		return mav;
	}
}
