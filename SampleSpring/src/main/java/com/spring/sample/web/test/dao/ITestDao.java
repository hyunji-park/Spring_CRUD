package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestDao {

	public List<HashMap<String, String>> getB1List(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getB1(HashMap<String, String> params) throws Throwable;

	public int addB1(HashMap<String, String> params) throws Throwable;

	public int updateB1(HashMap<String, String> params) throws Throwable;

	public int deleteB1(HashMap<String, String> params) throws Throwable;

	public int getB1Cnt(HashMap<String, String> params) throws Throwable;

}
