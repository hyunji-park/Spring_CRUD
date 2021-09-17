package com.spring.sample.web.testm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.testm.dao.ITestMDao;

@Service
public class TestMService implements ITestMService {

	@Autowired
	public ITestMDao iTestMDao;

	@Override
	public int getMCnt(HashMap<String, String> params) throws Throwable {
		return iTestMDao.getMCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable {
		return iTestMDao.getMList(params);
	}

	@Override
	public int MAdd(HashMap<String, String> params) throws Throwable {
		return iTestMDao.MAdd(params);
	}

	@Override
	public HashMap<String, String> getMDtl(HashMap<String, String> params) throws Throwable {
		return iTestMDao.getMDtl(params);
	}

	@Override
	public int MUpdate(HashMap<String, String> params) throws Throwable {
		return iTestMDao.MUpdate(params);
	}

	@Override
	public int MDelete(HashMap<String, String> params) throws Throwable {
		return iTestMDao.MDelete(params);
	}
	
	
}
