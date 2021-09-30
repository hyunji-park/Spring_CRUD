package com.gd.test.web.testa.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.test.web.testa.dao.ITestAMDao;

@Service
public class TestAMService implements ITestAMService{
	@Autowired
	public ITestAMDao iTestAMDao;

	@Override
	public int getM1Cnt(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.getM1Cnt(params);
	}

	@Override
	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.getM1List(params);
	}

	@Override
	public int addM1(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.addM1(params);
	}

	@Override
	public int updateM1(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.updateM1(params);
	}

	@Override
	public int deleteM1(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.deleteM1(params);
	}

	@Override
	public int getM1IdCheck(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.getM1IdCheck(params);
	}

	@Override
	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable {
		return iTestAMDao.getM1(params);
	}
}
