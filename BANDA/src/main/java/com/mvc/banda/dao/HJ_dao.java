package com.mvc.banda.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.banda.model.vo.AccountVo;
import com.mvc.banda.model.vo.CommentVo;
import com.mvc.banda.model.vo.FeedVo;
import com.mvc.banda.model.vo.FollowVo;
import com.mvc.banda.model.vo.LikesVo;
import com.mvc.banda.model.vo.MapVo;

@Repository
public class HJ_dao {

	//NameSpace
	private String namespace="HJ-mapper.";
	
	//SqlSession
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<String> map_autocompleteAjax(HashMap<String, String> searchMap){
		/*
		 * 검색어 자동완성(header)
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200213
		*/
		List<String> list = new ArrayList<String>();
		
		try {
			
			list = sqlSession.selectList(namespace+"autocompleteSelect", searchMap);
			
		} catch (Exception e) {
			System.out.println("[[Error]] : map_autocompleteAjax_Dao");
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<MapVo> map_defaultLocationAjax(HashMap<String, String> searchMap){
		/*
		 * Map 클라이언트 행정동 기본 위치 정보 
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200221
		 */
		
		List<MapVo> list = new ArrayList<MapVo>();
		
		try {
			
			list = sqlSession.selectList(namespace+"defaultLocationSelect", searchMap);
			
		} catch (Exception e) {
			System.out.println("[[Error]] : map_defaultLocationAjax");
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<MapVo> map_searchLocationAjax(HashMap<String, String> searchMap){
		/*
		 * Map 검색 위치 정보 
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200221
		 */
		
		List<MapVo> list = new ArrayList<MapVo>();
		
		try {
			
			list = sqlSession.selectList(namespace+"searchLocationSelect", searchMap);
			
		} catch (Exception e) {
			System.out.println("[[Error]] : map_searchLocationAjax");
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	public List<String> circleheader_autosearch(String keyword, String searchtype){
		/*
		 * Map 검색어 자동완성
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200219
		*/
		
		/* result list */
		List<String> list = new ArrayList<String>();
		/* 검색조건 map */
		HashMap<String, String> map = new HashMap<String, String>();
		/* 키워드 수  */
		int cnt = 0;
		/* 태그 배열  */
		String[] tags = null;
		
		/* 조건  set */
		map.put("searchtype", searchtype);
		map.put("keyword", keyword);

		try {
			/* DB list get */
			list = sqlSession.selectList(namespace+"circleheader_autocompleteSelect", map);
			
			/* tag인 경우, DB list에서 Tag 분리 */
			if(!searchtype.equals("jh_searchid")) {
				List<String> tmp = new ArrayList<String>();
				
				/* Tags #, :, 공백 제거 */
				for(int i=0; i<list.size(); i++) {
					if(searchtype.equals("jh_searchfeedhtag")) {
						tags = list.get(i).split("#");
					}else {
						tags = list.get(i).split(":");
					}
					
					for(String tag:tags) {
						if(searchtype.equals("jh_searchfeedhtag")) {
							tag = tag.replace("#", "");
						}else {
							tag = tag.replace(":", "");
						}
						
						tag = tag.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "");
						
						if(tag.length()!=0 && tag.contains(keyword)) {
							tmp.add(tag);
						}
					}
				}
				
				/* Tags 중복 제거 */
				HashSet<String> distinct = new HashSet<String>(tmp);
				
				/* Tags 개수 제한 */
				List<String> tmplist = new ArrayList<String>();
				
				for(String st:distinct) {
					if(cnt==5) {
						break;
					}else{
						tmplist.add(st);
						cnt++;
					}
				}
				
 				list = new ArrayList<String>(tmplist);
			}
			
		} catch (Exception e) {
			System.out.println("[[Error]] : circleheader_autosearch_Dao");
			e.printStackTrace();
		}
		return list;
	}
}
