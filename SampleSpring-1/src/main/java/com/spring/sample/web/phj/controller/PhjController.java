package com.spring.sample.web.phj.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.phj.service.PhjIService;

@Controller
public class PhjController {
	@Autowired
	public PhjIService iService;

	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value = "/List")
	public ModelAndView List(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		System.out.println(params);
		int page = 1;
		if (params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		int cnt = iService.getSELLCnt(params);
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 3, 2);

		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		List<HashMap<String, String>> list = iService.getSELLList(params);

		mav.addObject("page", page);
		mav.addObject("pb", pb);
		mav.addObject("list", list);

		mav.setViewName("phjTest/List");

		return mav;
	}

	@RequestMapping(value = "/Dtl")
	public ModelAndView Dtl(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		HashMap<String, String> data = iService.getSELL(params);
		mav.addObject("data", data);
		mav.setViewName("phjTest/Dtl");

		return mav;
	}

	@RequestMapping(value = "/Add")
	public ModelAndView Add(ModelAndView mav) {
		mav.setViewName("phjTest/Add");
		return mav;
	}

	@RequestMapping(value = "/Adds")
	public ModelAndView Adds(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		int cnt = iService.addSELL(params);

		if (cnt > 0) {
			mav.setViewName("redirect:List");
		} else {
			mav.addObject("msg", "저장에 실패하였습니다.");
			mav.setViewName("phjTest/failedAction");
		}
		return mav;
	}

	
	 @RequestMapping(value = "/Update") 
	 public ModelAndView Update(
	 
		@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
	 
		HashMap<String, String> data = iService.getSELL(params);
		mav.addObject("data", data); 
		mav.setViewName("phjTest/Update");
		  
		return mav;
	}
	  
	@RequestMapping(value = "/Updates") 
	public ModelAndView Updates(
	  
	@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
	  
		int cnt = iService.updateSELL(params);
	  
		if(cnt > 0) { 
			mav.setViewName("phjTest/Updates"); 
		} else {
			mav.addObject("msg", "수정에 실패하였습니다.");
			mav.setViewName("phjTest/failedAction"); 
		} 
	  	return mav; 
	}

	@RequestMapping(value = "/Delete")
	public ModelAndView Delete(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		int cnt = iService.deleteSELL(params);

		if (cnt > 0) {
			mav.setViewName("redirect:List");
		} else {
			mav.addObject("msg", "삭제에 실패하였습니다.");
			mav.setViewName("phjTest/failedAction");
		}
		return mav;
	}
}