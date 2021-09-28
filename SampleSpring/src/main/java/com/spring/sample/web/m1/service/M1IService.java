package com.spring.sample.web.m1.service;

import java.util.HashMap;
import java.util.List;

public interface M1IService {

	public int getM1Cnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable;

	public int addM1(HashMap<String, String> params) throws Throwable;

	public int updateM1(HashMap<String, String> params) throws Throwable;

	public int deleteM1(HashMap<String, String> params) throws Throwable;

	public int getM1IdCheck(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getM1Login(HashMap<String, String> params) throws Throwable;
	
	//멀티라인 편집 alt + shift + a
	
	
}
