package com.mvc.banda.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.banda.model.vo.AccountVo;
import com.mvc.banda.model.vo.ChatVo;
import com.mvc.banda.model.vo.FeedVo;
import com.mvc.banda.model.vo.FollowVo;
import com.mvc.banda.model.vo.PetVo;

@Repository
public class SI_dao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String NAMESPACE = "SI-mapper.";

	public AccountVo mypage_allselect(String id) {
		
		List<PetVo> petlist = pet_selectlist(id);
		List<FeedVo> feedlist = feed_selectlist(id);
		List<FollowVo> followlist = follow_selectlist(id);
		
		AccountVo vo = sqlSession.selectOne(NAMESPACE+"acc_selectone",id);
		vo.setPet_list(petlist);
		vo.setFeed_list(feedlist);
		vo.setFollow_list(followlist);
		
		return vo;
	}
	
	public AccountVo acc_selectone(String id) {
		
		AccountVo vo = null;
		
		try {
			vo = sqlSession.selectOne(NAMESPACE+"acc_selectone", id);			
		} catch (Exception e) {
			System.out.println("[error] : acc_selectone");
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public List<PetVo> pet_selectlist(String id){
		
		List<PetVo> list = null;
		
		try {
			
			list = sqlSession.selectList(NAMESPACE+"pet_selectlist",id);
			
		} catch (Exception e) {
			System.out.println("[error] : pet_selectlist");
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<FeedVo> feed_selectlist(String id){
		
		List<FeedVo> list = null;
		
		try {
			
			list = sqlSession.selectList(NAMESPACE+"feed_selectlist", id);
			
		} catch (Exception e) {
			System.out.println("[error] : feed_selectlist");
			e.printStackTrace();		
		}
		
		return list;
	}
	
	public List<ChatVo> chat_selectlist(String id){
		return null;
	}
	
	public List<FollowVo> follow_selectlist(String id){
		
		List<FollowVo> list = null;
		
		try {
			
			list = sqlSession.selectList(NAMESPACE+"follow_selectlist", id);
			
		} catch (Exception e) {
			System.out.println("[error] : follow_selectlist");
			e.printStackTrace();		
		}
		
		return list;
	}

	public PetVo pet_selectOne(int p_no) {

		PetVo pet = null;
		
		try {
			
			pet = sqlSession.selectOne(NAMESPACE+"pet_selectOne", p_no);
			
		} catch (Exception e) {
			System.out.println("[error] : pet_selectOne");
			e.printStackTrace();	
		}
		
		return pet;
	}

	
	
	public int pet_update(PetVo petVo) {

		int res = 0;
		
		try {
			
			res = sqlSession.update(NAMESPACE+"pet_update",petVo);
			
		} catch (Exception e) {
			System.out.println("[error] : pet_update");
			e.printStackTrace();			
		}
		
		return res;
	}

	public int pet_insert(PetVo petVo) {

		int res = 0;
		
		try {
			
			res = sqlSession.update(NAMESPACE+"pet_insert",petVo);
			
		} catch (Exception e) {
			System.out.println("[error] : pet_insert");
			e.printStackTrace();			
		}
		
		return res;
	}

	public int getLastPetSeq() {

		int lastpseq = 0;
		
		try {
			
			lastpseq = sqlSession.selectOne(NAMESPACE+"getLastPetSeq");
			
		} catch (Exception e) {
			System.out.println("[error] : getLastPetSeq");
			e.printStackTrace();			
		}
		
		lastpseq--;
		
		return lastpseq;
	}

	public int accountUpdate(AccountVo accvo) {

		int res = 0;
		
		try {
			
			res = sqlSession.update(NAMESPACE+"acc_update",accvo);
			
		} catch (Exception e) {
			System.out.println("[error] : accountUpdate");
			e.printStackTrace();			
		}
		
		return res;
	}
	
	

	public List<AccountVo> fd_accountSelectList(String fd_id) {

		List<AccountVo> fd_accountlist = null;
		
		try {
			
			fd_accountlist = sqlSession.selectList(NAMESPACE+"fd_accountSelectList", fd_id);	
			
		} catch (Exception e) {
			System.out.println("[error] : fd_accountSelectList");
			e.printStackTrace();
		}
		
		if(fd_accountlist != null) {
			
			List<PetVo> tmpPetList = null;
			
			for(AccountVo tmp : fd_accountlist) {
				String tmpid = tmp.getId();
				tmpPetList = pet_selectlist(tmpid);
				tmp.setPet_list(tmpPetList);
			}
		
		}

		return fd_accountlist;
	}

	public List<AccountVo> fr_accountSelectList(String fr_id) {
		List<AccountVo> fr_accountlist = null;
		
		try {
			
			fr_accountlist = sqlSession.selectList(NAMESPACE+"fr_accountSelectList", fr_id);	
			
		} catch (Exception e) {
			System.out.println("[error] : fr_accountSelectList");
			e.printStackTrace();
		}
		
		if(fr_accountlist != null) {
			
			List<PetVo> tmpPetList = null;
			
			for(AccountVo tmp : fr_accountlist) {
				String tmpid = tmp.getId();
				tmpPetList = pet_selectlist(tmpid);
				tmp.setPet_list(tmpPetList);
			}
		
		}

		return fr_accountlist;
	}

	
	public int follow_unfollow(FollowVo fvo) {
		
		int res = 0;
		
		try {
			
			res = sqlSession.delete(NAMESPACE+"follow_unfollow",fvo);
			
		} catch (Exception e) {
			System.out.println("[error] : follow_unfollow");
			e.printStackTrace();			
		}
		
		return res;
	}

	public int follow_follow(FollowVo fvo) {

		int res = 0;
		
		try {
			
			res = sqlSession.insert(NAMESPACE+"follow_follow",fvo);
			
		} catch (Exception e) {
			System.out.println("[error] : follow_follow");
			e.printStackTrace();			
		}
		
		return res;
	}

	public int mypage_insertfeed(FeedVo feedVo) {
		

		int res = 0;
		
		try {
			
			res = sqlSession.insert(NAMESPACE+"feed_insert",feedVo);
			
		} catch (Exception e) {
			System.out.println("[error] : mypage_insertfeed");
			e.printStackTrace();			
		}
		
		return res;
	}

	public int getLastFeedSeq() {

		int lastpseq = 0;
		
		try {
			
			lastpseq = sqlSession.selectOne(NAMESPACE+"getLastFeedSeq");
			
		} catch (Exception e) {
			System.out.println("[error] : getLastPetSeq");
			e.printStackTrace();			
		}
		
		lastpseq--;
		
		return lastpseq;
	}

	public int deletefeed(int feed_no) {
		
		int cres = 0;
		int lres = 0;
		int fres = 0;
		
		try {
			
			cres = sqlSession.delete(NAMESPACE+"comment_delete",feed_no);
			lres = sqlSession.delete(NAMESPACE+"like_delete",feed_no);
			fres = sqlSession.delete(NAMESPACE+"feed_delete",feed_no);
			
		} catch (Exception e) {
			System.out.println("[error] : mypage_insertfeed");
			e.printStackTrace();			
		}
		
		return fres;	
	}

	public List<ChatVo> myChat_selectlist(String id) {
		
		List<ChatVo> chat_list = null;
		
		try {
			
			chat_list = sqlSession.selectList(NAMESPACE+"chat_selectlist", id);	
			
		} catch (Exception e) {
			System.out.println("[error] : chat_selectlist");
			e.printStackTrace();
		}
		

		return chat_list;
	}

	public List<ChatVo> mychat_selectonelist(String userid, String otherid) {
		
		List<ChatVo> chat_list = null;
		
		Map<String, String> usermap = new HashMap<String, String>();
		usermap.put("userid", userid);
		usermap.put("otherid", otherid);
		
		System.out.println("usermap : "+usermap);
		
		try {
			
			chat_list = sqlSession.selectList(NAMESPACE+"mychat_selectonelist", usermap);	
			
		} catch (Exception e) {
			System.out.println("[error] : mychat_selectonelist");
			e.printStackTrace();
		}
		

		return chat_list;
	}

	public int insert_chat(ChatVo vo) {
		
		int res = 0;
		
		try {
			
			res = sqlSession.insert(NAMESPACE+"chat_insert",vo);
			
		} catch (Exception e) {
			System.out.println("[error] : insert_chat");
			e.printStackTrace();			
		}
		
		return res;
	}

	public List<String> select_allid() {
		
		List<String> res = null;
		
		try {
			
			res = sqlSession.selectList(NAMESPACE+"select_allid");	
			
		} catch (Exception e) {
			System.out.println("[error] : select_allid");
			e.printStackTrace();
		}
		

		return res;
	}
	
	
	
	
	
}
