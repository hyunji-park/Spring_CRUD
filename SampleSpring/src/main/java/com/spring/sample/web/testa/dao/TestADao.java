package com.spring.sample.web.testa.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestADao implements ITestADao{
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getABCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("testA.getABCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getABList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("testA.getABList", params);
	}

	@Override
	public int abAdd(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("testA.abAdd", params);
	}
}
