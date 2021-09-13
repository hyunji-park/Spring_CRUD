package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestODao implements ITestODao{

	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getO1Cnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("testO.getO1cnt", params);
	}

	@Override
	public List<HashMap<String, String>> getO1List(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("testO.getO1List", params);
	}

	@Override
	public int addO1(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("testO.addO1", params);
	}

	@Override
	public int updateO1(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("testO.updateO1", params);
	}

	@Override
	public int deleteO1(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("testO.deleteO1", params);
	}
}
