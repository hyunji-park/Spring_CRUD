package com.spring.sample.web.m1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.m1.dao.M1IDao;

@Service
public class M1Service implements M1IService{
	
	@Autowired
	public M1IDao iDao;

	@Override
	public int getM1Cnt(HashMap<String, String> params) throws Throwable {
		return iDao.getM1Cnt(params);
	}

	@Override
	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable {
		return iDao.getM1List(params);
	}

	@Override
	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable {
		return iDao.getM1(params);
	}

	@Override
	public int addM1(HashMap<String, String> params) throws Throwable {
		return iDao.addM1(params);
	}

	@Override
	public int updateM1(HashMap<String, String> params) throws Throwable {
		return iDao.updateM1(params);
	}

	@Override
	public int deleteM1(HashMap<String, String> params) throws Throwable {
		return iDao.deleteM1(params);
	}

	@Override
	public int getM1IdCheck(HashMap<String, String> params) throws Throwable {
		return iDao.getM1IdCheck(params);
	}

	@Override
	public HashMap<String, String> getM1Login(HashMap<String, String> params) throws Throwable {
		return iDao.getM1Login(params);
	}

}
