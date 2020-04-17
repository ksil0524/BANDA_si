package com.mvc.banda.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.banda.model.vo.AccountVo;



@Repository
public class JI_dao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	String NAMESPACE = "JI-mapper.";

	public int idoverlab(String id) {
		String res = null;
		
		try {
			
			res = sqlSession.selectOne(NAMESPACE + "idoverlab", id);
		

			
		} catch (Exception e) {
			System.out.println("[ERROR] Board Set Board to Notice");
			e.printStackTrace();
		}
	
		
		if(res != null) {
			return 1;
		}else {
			return 0;
		}
		
	}

	public int joinregister(AccountVo vo) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "joinregister", vo);
		} catch (Exception e) {
			System.out.println("[ERROR] Board Set Board to Notice");
			e.printStackTrace();
		}

		return res;
	}

	public int emailoverlab(String email) {
		String res = null;
		
		try {
			
			res = sqlSession.selectOne(NAMESPACE + "emailoverlab", email);
		

			
		} catch (Exception e) {
			System.out.println("[ERROR] Board Set Board to Notice");
			e.printStackTrace();
		}
	
		
		if(res != null) {
			return 1;
		}else {
			return 0;
		}
		
	}

}
