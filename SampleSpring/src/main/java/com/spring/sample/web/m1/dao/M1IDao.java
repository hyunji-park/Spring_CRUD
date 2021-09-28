package com.spring.sample.web.m1.dao;

import java.util.HashMap;
import java.util.List;

public interface M1IDao {

	public int getM1Cnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable;

	public int addM1(HashMap<String, String> params) throws Throwable;

	public int updateM1(HashMap<String, String> params) throws Throwable;

	public int deleteM1(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getM1Login(HashMap<String, String> params) throws Throwable;

	public int getM1IdCheck(HashMap<String, String> params) throws Throwable;

}
