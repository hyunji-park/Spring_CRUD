package com.spring.sample.web.test.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.ITestOService;

@Controller
public class testOController {
	@Autowired
	public ITestOService iTestOService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value ="/testO")
	  public ModelAndView testO(ModelAndView mav) throws Throwable {
	  
	  List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
	  
	  HashMap<String, String> data = new HashMap<String, String>();
	  data.put("O_NO", "1");
	  data.put("M_NO", "1");
	  data.put("M_NM", "test");
	  data.put("CON", "가나다라");
	  
	  list.add(data);
	  
	  mav.addObject("list", list); mav.setViewName("testO/testO");
	  
	  return mav; 
	  }
	 
	@RequestMapping(value ="/testOList")
	public ModelAndView testOList (
		@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		int page = 1;
		if (params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		int cnt = iTestOService.getO1Cnt(params); //글 개수
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 2, 2);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		//목록데이터 취득
		List<HashMap<String, String>> list = iTestOService.getO1List(params);
		
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("pb", pb);
		
		mav.setViewName("redirect:testO");
		return mav;
	}
	
	@RequestMapping(value ="/testOAdd")
	public ModelAndView	testOAdd(
		@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable{
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);
		System.out.println("testttttttttestttttttttesttttttttttttt"+params);		

		int cnt = iTestOService.addO1(params);

		if(cnt > 0) { //추가 성공
			mav.setViewName("redirect:testO");
		} else {
			mav.addObject("msg", "저장에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
	
	@RequestMapping(value ="/testOUpdate")
	public ModelAndView testOUpdate(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		int cnt = iTestOService.updateO1(params);
		
		if(cnt > 0) { //수정 성공
			mav.setViewName("redirect:testO");
		} else {
			mav.addObject("msg", "수정에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
	
	@RequestMapping(value ="/testODelete")
	public ModelAndView testODelete(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
		int cnt = iTestOService.deleteO1(params);
		
		if(cnt > 0) { //삭제 성공
			mav.setViewName("reditect:testO");
		} else {
			mav.addObject("msg", "삭제에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
}
