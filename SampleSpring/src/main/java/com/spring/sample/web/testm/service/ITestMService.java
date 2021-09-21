package com.spring.sample.web.testm.service;

import java.util.HashMap;
import java.util.List;

public interface ITestMService {

	public int getMCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable;

	public int MAdd(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMDtl(HashMap<String, String> params) throws Throwable;

	public int MUpdate(HashMap<String, String> params) throws Throwable;

	public int MDelete(HashMap<String, String> params) throws Throwable;

	public int gettestMIdCheck(HashMap<String, String> params) throws Throwable;

}
