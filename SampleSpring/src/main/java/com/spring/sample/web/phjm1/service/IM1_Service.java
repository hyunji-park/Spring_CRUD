package com.gd.test.web.phjm1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface IM1_Service {

	public int getM1Cnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable;

	public int addM1(HashMap<String, String> params) throws Throwable;

	public int updateM1(HashMap<String, String> params) throws Throwable;

	public int deleteM1(HashMap<String, String> params) throws Throwable;

	public int getM1IdCheck(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable;

}
