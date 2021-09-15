package com.spring.sample.web.testa.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestADao {

	public int getABCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getABList(HashMap<String, String> params) throws Throwable;

	public int abAdd(HashMap<String, String> params) throws Throwable;

}
