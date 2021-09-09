package com.spring.sample.web.phj.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PhjDao implements PhjIDao{
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getSELLList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("phjTest.getSELLList", params);
	}

	@Override
	public HashMap<String, String> getSELL(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("phjTest.getSELL", params);
	}

	@Override
	public int addSELL(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("phjTest.addSELL", params);
	}

	@Override
	public int updateSELL(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("phjTest.updateSELL", params);
	}

	@Override
	public int deleteSELL(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("phjTest.deleteSELL", params);
	}

	@Override
	public int getSELLCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("phjTest.getSELLCnt", params);
	}

}