package com.gd.test.web.phjm1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.test.common.bean.PagingBean;
import com.gd.test.common.service.IPagingService;
import com.gd.test.util.Utils;
import com.gd.test.web.phjm1.service.IM1_Service;

@Controller
public class M1_Controller {
	@Autowired
	public IM1_Service iM1_Service;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/M1List")
	public ModelAndView M1List(
			@RequestParam HashMap<String, String> params, ModelAndView mav) {
		
		String page = "1";
		
		if(params.get("page") != null) {
			page = params.get("page");
		}
		
		mav.addObject("page", page);
		mav.setViewName("phjm1/M1List");
		
		return mav;
	}
	
	@RequestMapping(value = "/M1ListAjax", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String M1ListAjax(
		@RequestParam HashMap<String, String> params) throws Throwable {
	
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	int page = Integer.parseInt(params.get("page"));
	int cnt = iM1_Service.getM1Cnt(params);
	PagingBean pb = iPagingService.getPagingBean(page, cnt, 5, 3);
	
	params.put("startCnt", Integer.toString(pb.getStartCount()));
	params.put("endCnt", Integer.toString(pb.getEndCount()));
	
	List<HashMap<String, String>> list = iM1_Service.getM1List(params);
	
	modelMap.put("list", list);
	modelMap.put("pb", pb);
	
	return mapper.writeValueAsString(modelMap); 
	}
	
	@RequestMapping(value = "/M1Add")
	public ModelAndView M1Add(ModelAndView mav) {
		
		mav.setViewName("phjm1/M1Add");
		
		return mav;
	}
	
	@RequestMapping(value = "/M1CUDAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
		public String M1CUDAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String result = "success";
		
		try {
			int cnt = 0;
		
			//CUD 처리
			switch(params.get("gbn")) {
				case "c" :
					// 비밀번호 암호화
					params.put("m_pw", Utils.encryptAES128(params.get("m_pw")));					
					cnt = iM1_Service.addM1(params);
					break;
				case "u" :
					// 비밀번호 암호화
					params.put("m_pw", Utils.encryptAES128(params.get("m_pw")));
					cnt = iM1_Service.updateM1(params);
					break;
				case "d" :
					cnt = iM1_Service.deleteM1(params);
					break;
			}
			
			if(cnt == 0) {
				result = "failed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			result = "error";
		}
		modelMap.put("result", result);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/M1IdCheckAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
		public String M1IdCheckAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iM1_Service.getM1IdCheck(params);
		modelMap.put("cnt", cnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/M1Dtl") 
	public ModelAndView M1Dtl (
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iM1_Service.getM1(params);
		
		mav.addObject("data", data);
		mav.setViewName("phjm1/M1Dtl");
		
		return mav;
	}
	
	@RequestMapping(value = "/M1Update") 
	public ModelAndView M1Update (
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
	
		HashMap<String, String> data = iM1_Service.getM1(params);
		
		data.put("M_PW", Utils.decryptAES128(data.get("M_PW")));
		
		mav.addObject("data", data);
		mav.setViewName("phjm1/M1Update");
		
		return mav;
	}
}
