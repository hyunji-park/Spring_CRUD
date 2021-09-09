package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ITestDao;

@Service
public class TestService implements ITestService {
	@Autowired
	public ITestDao iTestDao;

	@Override
	public List<HashMap<String, String>> getB1List(HashMap<String, String> params) throws Throwable {
		return iTestDao.getB1List(params);
	}

	@Override
	public HashMap<String, String> getB1(HashMap<String, String> params) throws Throwable {
		return iTestDao.getB1(params);
	}

	@Override
	public int addB1(HashMap<String, String> params) throws Throwable {
		return iTestDao.addB1(params);
	}

	@Override
	public int updateB1(HashMap<String, String> params) throws Throwable {
		return iTestDao.updateB1(params);
	}

	@Override
	public int deleteB1(HashMap<String, String> params) throws Throwable {
		return iTestDao.deleteB1(params);
	}

	@Override
	public int getB1Cnt(HashMap<String, String> params) throws Throwable {
		return iTestDao.getB1Cnt(params);
	}
}
