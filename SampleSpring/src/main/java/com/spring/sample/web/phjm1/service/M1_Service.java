package com.gd.test.web.phjm1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.test.web.phjm1.dao.IM1_Dao;

@Service
public class M1_Service implements IM1_Service {
	@Autowired
	public IM1_Dao iM1_Dao;

	@Override
	public int getM1Cnt(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.getM1Cnt(params);
	}

	@Override
	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.getM1List(params);
	}

	@Override
	public int addM1(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.addM1(params);
	}

	@Override
	public int updateM1(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.updateM1(params);
	}

	@Override
	public int deleteM1(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.deleteM1(params);
	}

	@Override
	public int getM1IdCheck(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.getM1IdCheck(params);
	}

	@Override
	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable {
		return iM1_Dao.getM1(params);
	}
}
