package com.spring.sample.web.m1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.util.Utils;
import com.spring.sample.web.m1.service.M1IService;

@Controller
public class M1Controller {

	@Autowired
	public M1IService iService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/MList") 
	public ModelAndView MList (
		@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		System.out.println(params);
		int page = 1;
		//넘어온 페이지 값이 있을 경우 페이지 값 세팅
		if (params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		int cnt = iService.getM1Cnt(params); //글 개수
		//페이징 계산 후 bean에 데이터 세팅
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 2, 2);
		//조회 시작 및 종료 번호 할당
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		//목록데이터 취득
		List<HashMap<String, String>> list = iService.getM1List(params);
		
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("pb", pb);
		
		mav.setViewName("M1/MList");
		return mav;
	}
	
	@RequestMapping(value = "/MDtl") 
	public ModelAndView MDtl (
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iService.getM1(params);
		
		mav.addObject("data", data);
		mav.setViewName("M1/MDtl");
		
		return mav;
	}
	
	@RequestMapping(value = "/MAdd")
	public ModelAndView MAdd(ModelAndView mav) {
		mav.setViewName("M1/MAdd");
		return mav;
	}
	
	@RequestMapping(value = "/MAdds")
	public ModelAndView MAdds(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		int checkCnt = iService.getM1IdCheck(params);
		
		if(checkCnt == 0) {
			//비밀번호 암호화
			String m_pw = Utils.encryptAES128(params.get("m_pw"));
			params.put("m_pw", m_pw);
			
			int cnt = iService.addM1(params);
			if(cnt > 0) {
				mav.setViewName("redirect:MList");
			} else {
				mav.addObject("msg", "등록에 실패하였습니다");
				mav.setViewName("M1/failedAction");
			}
		} else {
			mav.addObject("msg", "중복된 아이디가 있습니다.");
			mav.setViewName("M1/failedAction");
		}
		return mav;
	}
	
	@RequestMapping(value = "/MUpdate") 
	 public ModelAndView MUpdate(
		@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iService.getM1(params);
		
		//비밀번호 복호화
		String m_pw = Utils.decryptAES128(data.get("M_PW"));
		data.put("M_PW", m_pw);
		
		mav.addObject("data", data);
		mav.setViewName("M1/MUpdate");
		
		return mav;
	}
	
	@RequestMapping(value = "/MUpdates") 
	public ModelAndView MUpdates(
		@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
		
		//비밀번호 암호화
		String m_pw = Utils.encryptAES128(params.get("m_pw"));
		params.put("m_pw", m_pw);
				
		int cnt = iService.updateM1(params);
		if(cnt > 0) { 
			mav.setViewName("M1/MUpdates"); 
		} else {
			mav.addObject("msg", "수정에 실패하였습니다.");
			mav.setViewName("M1/failedAction"); 
		}
		return mav;
	}
	
	@RequestMapping(value = "/MDelete")
	public ModelAndView MDelete(
		@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		int cnt = iService.deleteM1(params);
		
		if(cnt > 0) {
			mav.setViewName("redirect:MList");
		} else {
			mav.addObject("msg", "삭제에 실패하였습니다.");
			mav.setViewName("M1/failedAction");
		}
		return mav;
		}
	
	@RequestMapping(value = {"/Login", "/userLogin"})
	public ModelAndView Login(HttpServletRequest req, HttpSession session, ModelAndView mav) {
		System.out.println(req.getServletPath());
		
		if(session.getAttribute("sMNo") != null) { //로그인 상태
			//mav.setViewName("redirect:testList");
			mav.setViewName("redirect:testO");
		} else { //로그인 안된 상태
			mav.setViewName("M1/Login");
		}
			
		return mav;
	}
	
	@RequestMapping(value = "/Logins")
	public ModelAndView Logins(
		@RequestParam HashMap<String, String> params,
				//HttpServletRequest req, //1번 취득방식
				HttpSession session, //2번 취득 방식
				ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iService.getM1Login(params);
		
		//비밀번호 암호화
		String m_pw = Utils.encryptAES128(params.get("m_pw"));
		params.put("m_pw", m_pw);
		if(data != null) { //사용자 데이터가 있을 경우
			
			//Session 취득 방법
			//1. request를 활용
			//HttpSession session = req.getSession();
			
			//setAttribute(키, 값) : 세션에 해당 키와 값을 넣는다.
			session.setAttribute("sMNo", data.get("M_NO"));
			session.setAttribute("sMNm", data.get("M_NM"));
		
			//getAttribute(키) : 세션에서 키에 해당하는 값을 가져온다.
			System.out.println(session.getAttribute("sMNm"));	
			//mav.setViewName("redirect:testList");
			mav.setViewName("redirect:testO");
			
		} else { //없을 경우(로그인 실패)
			mav.addObject("msg", "아이디나 비밀번호가 틀립니다.");
			mav.setViewName("M1/failedAction");
		}
	
		return mav;
	}
	
	@RequestMapping(value = "/Logout")
	public ModelAndView Logout (HttpSession session, ModelAndView mav) {
		session.invalidate(); //session 정보 초기화
		
		mav.setViewName("redirect:Login");
		
		return mav;
	}
			
}
