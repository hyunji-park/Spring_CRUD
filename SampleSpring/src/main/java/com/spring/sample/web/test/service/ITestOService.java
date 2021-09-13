package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface ITestOService {

	public int getO1Cnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getO1List(HashMap<String, String> params) throws Throwable;

	public int addO1(HashMap<String, String> params) throws Throwable;

	public int updateO1(HashMap<String, String> params) throws Throwable;

	public int deleteO1(HashMap<String, String> params) throws Throwable;

}
