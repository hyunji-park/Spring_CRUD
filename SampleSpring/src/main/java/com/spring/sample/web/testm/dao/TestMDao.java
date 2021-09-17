package com.spring.sample.web.testm.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestMDao implements ITestMDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getMCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("TestM.getMCnt", params);
	}
	
	@Override
	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("testM.getMList", params);
	}

	@Override
	public int MAdd(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("testM.MAdd");
	}

	@Override
	public HashMap<String, String> getMDtl(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("testM.getMDtl", params);
	}

	@Override
	public int MUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("testM.MUpdate", params);
	}

	@Override
	public int MDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("testM.MDelete", params);
	}
}
