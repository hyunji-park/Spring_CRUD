package com.spring.sample.web.phj.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.phj.dao.PhjIDao;

@Service
public class PhjService implements PhjIService{
	@Autowired
	public PhjIDao iDao;

	@Override
	public List<HashMap<String, String>> getSELLList(HashMap<String, String> params) throws Throwable {
		return iDao.getSELLList(params);
	}

	@Override
	public HashMap<String, String> getSELL(HashMap<String, String> params) throws Throwable {

		return iDao.getSELL(params);
	}

	@Override
	public int addSELL(HashMap<String, String> params) throws Throwable {
		return iDao.addSELL(params);
	}

	@Override
	public int updateSELL(HashMap<String, String> params) throws Throwable {
		return iDao.updateSELL(params);
	}

	@Override
	public int deleteSELL(HashMap<String, String> params) throws Throwable {
		return iDao.deleteSELL(params);
	}

	@Override
	public int getSELLCnt(HashMap<String, String> params) throws Throwable {
		return iDao.getSELLCnt(params);
	}

}
