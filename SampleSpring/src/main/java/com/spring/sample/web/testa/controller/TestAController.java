package com.spring.sample.web.testa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.testa.service.ITestAService;

@Controller
public class TestAController {

	@Autowired
	public ITestAService iTestAService;

	@Autowired
	public IPagingService iPagingService;


	@RequestMapping(value = "/testABList")
	public ModelAndView testABList(
			@RequestParam HashMap<String, String> params, ModelAndView mav) {

		String page="1";

		if(params.get("page") != null) {
			page = params.get("page");
		}
		mav.addObject("page", page);
		mav.setViewName("testa/testABList");

		return mav;
	}

	@RequestMapping(value = "/testABLists", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody //Spring에 돌려주는 내용이 View임을 제시
	public String testABLists(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper(); //jackson 객체

		Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터를 담을 map


		try {

			//페이지 취득
			int page = Integer.parseInt(params.get("page"));
			//개수 획득
			int cnt = iTestAService.getABCnt(params);
			//패이징 정보 획득
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 5, 2);
			//데이터 시작, 종료값 할당
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			//리스트 조회
			List<HashMap<String, String>> list = iTestAService.getABList(params);
			//데이터 담기
			modelMap.put("list", list);
			modelMap.put("pb", pb);

		} catch(Exception e) {
			e.printStackTrace();
		}


		//데이터를 문자열화
		return mapper.writeValueAsString(modelMap);
		//{list":[{B_NO:~,~,...},{},...],pb:{startCnt:~,...}}
	}

	@RequestMapping(value = "/testABAdd")
	public ModelAndView testABAdd(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sMNo") != null) {
			mav.setViewName("testa/testABAdd");
		} else {
			mav.setViewName("redirect:Login"); //redirect의 목적은 사용자의 주소를 저 주소(Login)로 이동하겠다는 것
		}
		return mav;
	}


	@RequestMapping(value = "/testABAdds", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testABAdds(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		String result = "success";

		try {
			int cnt = iTestAService.abAdd(params);

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

	@RequestMapping(value = "/testAB") //상세보기
	public ModelAndView testAB(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{

		if(params.get("no") != null) { //페이지의 안정성을 위해(주소를 직접 치고 들어갔을 때 리스트로 넘어가게 하고 목록에서 클릭해서 no랑 같이 넘어갔을 때 상세보기 잘 나오게)
			//조회수 증가(데이터 조회 직전에 증가)
			iTestAService.updateABHit(params);

			//데이터 조회
			HashMap<String, String> data = iTestAService.getAB(params);

			mav.addObject("data", data);
			mav.setViewName("testa/testAB");
		} else {
			mav.setViewName("redirect:testABList");
		}
		return mav;
	}

	@RequestMapping(value = "/testABUpdate")
	public ModelAndView testABUpdate(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{

		if(params.get("no") != null) {
			HashMap<String, String> data = iTestAService.getAB(params);

			mav.addObject("data", data);
			mav.setViewName("testa/testABUpdate");
		} else {
			mav.setViewName("redirect:testABList");
		}
		return mav;
	}

	@RequestMapping(value = "/testABUpdates", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testABUpdates(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		String result = "success";

		try {
			int cnt = iTestAService.abUpdate(params);

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

	@RequestMapping(value = "/testABDeletes", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testABDeletes(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		String result = "success";

		try {
			int cnt = iTestAService.abDelete(params);

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
}
