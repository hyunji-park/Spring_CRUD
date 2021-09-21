package com.spring.sample.web.testm.controller;

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
import com.spring.sample.util.Utils;
import com.spring.sample.web.testm.service.ITestMService;

@Controller
public class TestMController {

	@Autowired
	public ITestMService iTestMService;

	@Autowired
	public IPagingService iPagingService;

	@RequestMapping(value = "/testMList")
	public ModelAndView testMList(
			@RequestParam HashMap<String, String> params, ModelAndView mav) {

		String page="1";

		if(params.get("page") != null) {
			page = params.get("page");
		}
		mav.addObject("page", page);
		mav.setViewName("testm/testMList");
		return mav;
	}

	@RequestMapping(value = "/testMLists", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String testMLists (
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> modelmap = new HashMap<String, Object>();

		int page = Integer.parseInt(params.get("page"));
		int cnt = iTestMService.getMCnt(params);
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 3, 2);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		List<HashMap<String, String>> list = iTestMService.getMList(params);

		modelmap.put("list", list);
		modelmap.put("pb", pb);

		return mapper.writeValueAsString(modelmap);
	}

	@RequestMapping(value = "/testMAdd")
	public ModelAndView testABAdd(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sMNo") != null) {
			mav.setViewName("testm/testMAdd");
		} else {
			mav.setViewName("redirect:Login");
		}

		return mav;
	}

	@RequestMapping(value = "/testMAdds", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testMAdds(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		String result = "success";

		try {
			int checkCnt = iTestMService.gettestMIdCheck(params);
			if(checkCnt == 0) {
				//비밀번호 암호화
				String pw = Utils.encryptAES128(params.get("pw"));
				params.put("pw", pw);

				int cnt = iTestMService.MAdd(params);

				if(cnt == 0) {
					result = "failed";
				}
			} else {
				modelMap.put("msg", "중복된 아이디가 있습니다.");
				//modelMap.
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "error";
		}
		modelMap.put("result", result);

		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/testMDtl")
	public ModelAndView testMDtl(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{
		if(params.get("no") != null) {

			HashMap<String, String> data = iTestMService.getMDtl(params);
			mav.addObject("data", data);
			mav.setViewName("testm/testMDtl");
		} else {
			mav.setViewName("redirect:testMList");
		}
		return mav;
	}

	@RequestMapping(value = "/testMUpdate")
	public ModelAndView testMUpdate(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable{

		if(params.get("no") != null) {
			HashMap<String, String> data = iTestMService.getMDtl(params);

			//비밀번호 복호화
			String pw = Utils.decryptAES128(data.get("M_PW"));
			data.put("M_PW", pw);

			mav.addObject("data", data);
			mav.setViewName("testm/testMUpdate");
		} else {
			mav.setViewName("redirect:testMList");
		}
		return mav;
	}

	@RequestMapping(value = "/testMUpdates", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testMUpdates(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		//비밀번호 암호화
		String pw = Utils.encryptAES128(params.get("M_PW"));
		params.put("M_PW", pw);

		String result = "success";

		try {
			int cnt = iTestMService.MUpdate(params);

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

	@RequestMapping(value = "/testMDeletes", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testMDeletes(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		String result = "success";

		try {
			int cnt = iTestMService.MDelete(params);

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
