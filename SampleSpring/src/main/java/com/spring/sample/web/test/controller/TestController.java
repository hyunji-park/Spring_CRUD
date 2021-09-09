package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.ITestService;

@Controller
public class TestController {
	@Autowired
	public ITestService iTestService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/testList")
	public ModelAndView testList(
			//HashMap : 값이 있어서 값이 일치하는것을 가져옴
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		int page = 1; //현재P변수
		if(params.get("page") != null) { //넘어오는 현재 P데이터가 존재 시
			page = Integer.parseInt(params.get("page"));
		}
		int cnt = iTestService.getB1Cnt(params); //총 게시글 개수
		//f3누르면 custom Paging으로 이동
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 3, 2);
		
		//데이터 시작, 종료 번호 추가
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, String>> list = iTestService.getB1List(params);
		
		mav.addObject("page", page);
		mav.addObject("pb", pb);
		mav.addObject("list", list);
		
		mav.setViewName("test/testList");
		
		return mav;
	}
	
	@RequestMapping(value =	"/testDtl")
	public ModelAndView testDtl(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iTestService.getB1(params);
		mav.addObject("data", data);
		mav.setViewName("test/testDtl");
		
		return mav;
	}
	
	@RequestMapping(value =	"/testAdd") //페이지로 보이기만 하는 것(화면만)
	public ModelAndView testAdd(ModelAndView mav) {
		mav.setViewName("test/testAdd"); //어느 jsp로 갈 것인가
		return mav;
	}
	
	@RequestMapping(value =	"/testAdds") //페이지 안에 값을 넣는 것(기능)
	public ModelAndView testAdds(
			@RequestParam HashMap<String, String> params, //params : 폼데이터
			ModelAndView mav) throws Throwable{
		
		int cnt = iTestService.addB1(params);
		
		if(cnt > 0) { //추가 성공
			mav.setViewName("redirect:testList");
		} else {
			mav.addObject("msg", "저장에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
	
	@RequestMapping(value =	"/testUpdate")
	public ModelAndView testUpdate(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iTestService.getB1(params);
		mav.addObject("data", data);
		mav.setViewName("test/testUpdate");
		
		return mav;
	}
	@RequestMapping(value =	"/testUpdates")
	public ModelAndView testUpdates(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		int cnt = iTestService.updateB1(params);
		
		if(cnt > 0) { //수정 성공
			mav.setViewName("test/testUpdates");
		} else {
			mav.addObject("msg", "수정에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
	
	@RequestMapping(value =	"/testDelete")
	public ModelAndView testDelete(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		int cnt = iTestService.deleteB1(params);
		
		if(cnt > 0) { //삭제 성공
			mav.setViewName("test/testList");
		} else {
			mav.addObject("msg", "삭제에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
}
