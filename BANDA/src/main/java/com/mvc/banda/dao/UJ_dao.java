package com.mvc.banda.dao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.banda.model.vo.AccountVo;

@Repository
public class UJ_dao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	String NAMESPACE = "UJ-mapper.";
	
	
	
	public AccountVo login(AccountVo vo) {
		
		AccountVo res = null;
		
		
		
	
		try {
			res = sqlSession.selectOne(NAMESPACE+"login",vo);
		}catch(Exception e) {
			System.out.println("[error]:login");
			e.printStackTrace();
			
			
		}
		
		
		
		
		return res;
	}
	
	
	
	
	public int register(AccountVo vo) {
		
		int res = 0;
		
		try {
			
			res= sqlSession.insert(NAMESPACE+"register",vo);
		}catch(Exception e) {
			
			e.printStackTrace();
		}
		return res;
		
		
		
	}
	
	
	
	
}
