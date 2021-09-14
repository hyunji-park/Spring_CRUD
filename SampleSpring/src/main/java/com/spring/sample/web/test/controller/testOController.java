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
import com.spring.sample.web.test.service.ITestOService;

@Controller
public class testOController {
	@Autowired
	public ITestOService iTestOService;

	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value ="/testO")
	public ModelAndView testO(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		int page = 1;
		if (params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		//try {
		int cnt = iTestOService.getO1Cnt(params); //글 개수
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 2, 2);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));

		//목록데이터 취득
		List<HashMap<String, String>> list = iTestOService.getO1List(params);

		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("pb", pb);

		//} catch (Exception e) {
		//	e.printStackTrace();
		//}

		mav.setViewName("testO/testO");
		return mav;
	}


	@RequestMapping(value ="/testOAdd")
	public ModelAndView	testOAdd(
			@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable{
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
			mav.addObject("page", params.get("page"));
			mav.setViewName("redirect:testO"); //get방식으로 넘어감
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
			mav.setViewName("redirect:testO");
		} else {
			mav.addObject("msg", "삭제에 실패하였습니다.");
			mav.setViewName("test/failedAction");
		}
		return mav;
	}
}
