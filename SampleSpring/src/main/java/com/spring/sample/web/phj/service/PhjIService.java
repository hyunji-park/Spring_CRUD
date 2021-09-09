package com.spring.sample.web.phj.service;

import java.util.HashMap;
import java.util.List;

public interface PhjIService {
	public List<HashMap<String, String>> getSELLList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getSELL(HashMap<String, String> params) throws Throwable;
	
	public int addSELL(HashMap<String, String> params) throws Throwable;
	
	public int updateSELL(HashMap<String, String> params) throws Throwable;
	
	public int deleteSELL(HashMap<String, String> params) throws Throwable;
	
	public int getSELLCnt(HashMap<String, String> params) throws Throwable;
	
}