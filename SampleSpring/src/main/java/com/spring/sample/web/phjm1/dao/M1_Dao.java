package com.gd.test.web.phjm1.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class M1_Dao implements IM1_Dao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getM1Cnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("phjm1.getM1Cnt", params);
	}

	@Override
	public List<HashMap<String, String>> getM1List(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("phjm1.getM1List",params);
	}

	@Override
	public int addM1(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("phjm1.addM1", params);
	}

	@Override
	public int updateM1(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("phjm1.updateM1", params);
	}

	@Override
	public int deleteM1(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("phjm1.deleteM1", params);
	}

	@Override
	public int getM1IdCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("phjm1.getM1IdCheck",params);
	}

	@Override
	public HashMap<String, String> getM1(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("phjm1.getM1",params);
	}
	
}
