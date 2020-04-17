package com.mvc.banda.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JH_dao {

	//NameSpace
	private String namespace="JH-mapper.";
	
	//SqlSession
	@Autowired
	private SqlSessionTemplate sqlSession;
	
}
