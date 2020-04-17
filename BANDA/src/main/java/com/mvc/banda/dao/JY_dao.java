package com.mvc.banda.dao;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.banda.model.vo.AccountVo;
import com.mvc.banda.model.vo.BoardVo;
import com.mvc.banda.model.vo.CommentVo;
import com.mvc.banda.model.vo.FeedVo;
import com.mvc.banda.model.vo.FollowVo;
import com.mvc.banda.model.vo.LikesVo;
import com.mvc.banda.model.vo.PetVo;

@Repository
public class JY_dao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	String NAMESPACE = "JY-mapper.";
	
		//login
		public AccountVo jy_login(AccountVo vo) {
			return sqlSession.selectOne(NAMESPACE+"jy_login", vo);
		}
		
		//naver_register
		public int naver_register(AccountVo vo) {
			return sqlSession.insert(NAMESPACE+"naver_register", vo);
		}
		
		//main_selectList -> 로그인 시 ACCOUNTVO 반환
		public AccountVo main_selectList(String id) {
			
			int count = feed_count();
			//System.out.println(count);
			
			List<FollowVo> follow_list = null;
			List<FeedVo> feed_list = null;
			List<String> follow_name = new ArrayList<String>();
			
			follow_list = follow_list(id);
			
			for(int i = 0; i<follow_list.size();i++) {
				follow_name.add(follow_list.get(i).getFd_id());
			}
				
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("name", follow_name);
			m.put("count", count);
			
			feed_list = feed_list(m);
			count = feed_list.size();
			//System.out.println(count);
			
			if(count < 4) {

			}
			else if(count % 4 != 0) {
				count = count - (count%4);
			}
			
			m.put("count", count);
			
			feed_list = feed_list(m);
			
			List<Integer> feedno =new ArrayList<Integer>();
			
			for(FeedVo v : feed_list) {
				
				List<CommentVo> c = select_comment(v.getFeed_no());
				v.setComment_list(c);
				
				List<LikesVo> l = select_like(v.getFeed_no());
				v.setLike_list(l);
				
			}		
			
			AccountVo vo = new AccountVo();
			vo.setId(id);
			vo.setFeed_list(feed_list);
			vo.setFollow_list(follow_list);
			
			return vo;
		}
		
		//main_selectListN -> 로그인이 없거나 팔로우가 없는 경우 FEEDVO 반환
		public List<FeedVo> main_selectListN() {
			
			int count = feed_count();
			
			if(count % 4 != 0) {
				count = count - (count%4);
			}
			
			List<FeedVo> feed_list = feed_list_random(count);
			
			for(FeedVo v : feed_list) {
				
				List<CommentVo> c = select_comment(v.getFeed_no());
				v.setComment_list(c);
				
				List<LikesVo> l = select_like(v.getFeed_no());
				v.setLike_list(l);
				
			}
			
			return feed_list;
		}
		
		
		
		//main_selectFollow - 로그인시 팔로우 여부 판단
		public List<FollowVo> main_selectFollow(String id){
			
			return follow_list(id);
		}
		
		//main_follow_feed - 로그인 o, 팔로우 o후에 팔로우들의 피드 반환
		public List<FeedVo> main_follow_feed(List<FollowVo> fvo){
			
			List<String> fd_list = new ArrayList<String>();
			
			for(FollowVo f : fvo) {
				
				fd_list.add(f.getFd_id());
				
			}
			
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("fd_name", fd_list);
			
			return main_follow_feed_sql(m);
		}
		
		//my_feedList - 내 피드가져오기
		public List<FeedVo> my_feedList(String id){
			
			int count = feed_count();
			
			List<String> list = new ArrayList<String>();
			list.add(id);
			
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("name", list);
			m.put("count", count);
			
			List<FeedVo> fvo = feed_list(m);
			
			for(FeedVo v : fvo) {
				
				List<CommentVo> c = select_comment(v.getFeed_no());
				v.setComment_list(c);
				
				List<LikesVo> l = select_like(v.getFeed_no());
				v.setLike_list(l);
			}
			
					
			return fvo;
		}
		
		//각각 피드 가져오기
		public FeedVo each_feed(int feedno) {
			
			FeedVo f = select_each_feed(feedno);
			
			List<LikesVo> like_list= select_like(feedno);
			f.setLike_list(like_list);
			
			List<CommentVo> comment_list = select_comment(feedno);
			f.setComment_list(comment_list);			

			
			return f;
		}

		//타인피드가져오기
		public Map<String, Object> main_otherfeed(String id){
			
			Map<String, Object> m = new HashMap<String, Object>();
			
			//사람계정
			AccountVo vo = select_account(id);
			
			//동물계정
			List<PetVo> pvo = select_pet_list(id);
			vo.setPet_list(pvo);
			
			//피드
			List<FeedVo> fvo = feed_list_nocount(id);

			for(FeedVo f : fvo) {
				
				List<CommentVo> c = select_comment(f.getFeed_no());
				f.setComment_list(c);
				
				List<LikesVo> l = select_like(f.getFeed_no());
				f.setLike_list(l);
				
			}
			
			vo.setFeed_list(fvo);
			
			m.put("acc", vo);
			m.put("follow_count", follow_count(id));
			m.put("follower_count", follower_count(id));
			
			return m;
		}
		
		//댓글 삽입
		public int main_insert_comment(CommentVo c) {
			
			int res = insert_comment_sql(c);
			
			return res;
		}
		
		//댓글 삭제
		public int main_delete_comment(CommentVo c) {
			
			int comment_no = c.getCom_no();
			
			return delete_comment(comment_no);
		}
		
		//댓글 수정
		public int main_update_comment(CommentVo c) {
			
			return update_comment(c);
		}
		
		//댓글 리스트 반환 
		public List<CommentVo> main_select_comment(int feedno) {
			
			return select_comment(feedno);
		}
		
		//좋아요 삽입
		public int feed_like_insert(LikesVo l) {
			
			return feed_like_insert_sql(l);
		}
		
		//좋아요 삭제
		public int feed_like_delete(LikesVo l) {
			
			return feed_like_delete_sql(l);
		}
		
		//좋아요 리스트
		public List<LikesVo> main_like_list(int feedno){
		
			return select_like(feedno);
		}
		
		//아이디찾기
		public AccountVo find_id(String email) {
			
			return find_id_sql(email);
		}
		
		//아이디 이메일로 계정 찾기
		public AccountVo find_vo(AccountVo vo) {
			
			return find_vo_sql(vo);
		}
		
		//비밀번호 찾기에서 비밀번호 업데이트
		public int pwdfind_update(AccountVo vo) {
			
			return pwdfind_update_sql(vo);
		}
		
		//search_id
		public List<FeedVo> search_id(String keyword){
			
			List<FeedVo> flist = search_id_sql(keyword);
		
			int count = flist.size();
			
			if(count < 4) {

			}
			else if(count % 4 != 0) {
				count = count - (count%4);
			}
			
			Map m = new HashMap();
			m.put("keyword", keyword);
			m.put("count", count);
			
			flist = search_id_count(m);
			
			for(FeedVo v : flist) {
				
				List<CommentVo> c = select_comment(v.getFeed_no());
				v.setComment_list(c);
				
				List<LikesVo> l = select_like(v.getFeed_no());
				v.setLike_list(l);

			}

			return flist;
		}
		
		//search_htag
		public List<FeedVo> search_ptag(String keyword){
			
			List<FeedVo> flist = search_ptag_sql(keyword);
			
			int count = flist.size();
			
			if(count < 4) {

			}
			else if(count % 4 != 0) {
				count = count - (count%4);
			}
			
			Map m = new HashMap();
			m.put("keyword", keyword);
			m.put("count", count);
			
			flist = search_ptag_count(m);
			
			for(FeedVo v : flist) {
				
				List<CommentVo> c = select_comment(v.getFeed_no());
				v.setComment_list(c);
				
				List<LikesVo> l = select_like(v.getFeed_no());
				v.setLike_list(l);
			}
			
			return flist;			
		}
		
		//search_htag
		public List<FeedVo> search_htag(String keyword){
			
			List<FeedVo> flist = search_htag_sql(keyword);
			
			int count = flist.size();
			
			if(count < 4) {

			}
			else if(count % 4 != 0) {
				count = count - (count%4);
			}
			
			Map m = new HashMap();
			m.put("keyword", keyword);
			m.put("count", count);
			
			flist = search_htag_count(m);
			
			for(FeedVo v : flist) {
				
				List<CommentVo> c = select_comment(v.getFeed_no());
				v.setComment_list(c);
				
				List<LikesVo> l = select_like(v.getFeed_no());
				v.setLike_list(l);
			}
			
			return flist;	
			
		}
		
		//delete_user
		public Map<String, Object> delete_user(String id) {

			//좋아요, 팔로우, 댓글, 채팅 삭제
			int count = 0;
			
			//db삭제후 해당 파일 삭제 위한 과정
			//feed, board - db에 파일존재, pet은 db에 파일 존재하지않음, acount는 파일 존재하지 않음
			Map<String, Object> res = new HashMap<String, Object>();

			//feed
			List<FeedVo> fvo = feed_list_nocount(id);
			List<Integer> fvo_feedno = new ArrayList<Integer>();
			
			for(FeedVo f : fvo) {
				fvo_feedno.add(f.getFeed_no());
			}

			res.put("feed_no", fvo_feedno);
			
			//pet
			List<PetVo> pvo = select_pet_list(id);
			List<Integer> pvo_pno = new ArrayList<Integer>();
			
			for(PetVo p : pvo) {
				
				pvo_pno.add(p.getP_no());
			}
			
			res.put("pet_no", pvo_pno);	
			
			//board
			List<BoardVo> bvo = select_board_list(id);
			List<Integer> bvo_boardno = new ArrayList<Integer>();
			
			for(BoardVo b : bvo) {
				bvo_boardno.add(b.getBoard_no());
			}
			
			res.put("board_no", bvo_boardno);
			
			//account
			res.put("id",id);
			
			count = delete_user_sql(id);			
			res.put("count", count);
			
			return res;
		}
		
		//follow_insert
		public int detail_follow_insert(FollowVo fvo) {
			return detail_follow_insert_sql(fvo);
		}
		
		//deatil_follow_delete
		public int deatil_follow_delete(FollowVo fvo) {
			return deatil_follow_delete_sql(fvo);
		}
		
		//follow_list_yn
		public int follow_list_yn(FollowVo fvo) {
			
			int followNum = 0;
			
			FollowVo fvo2 = follow_list_yn_sql(fvo);
			
			if(fvo2 != null) {
				followNum = 1;
			} 
			
			return followNum;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////
		//sql
		
		//follow list
		public List<FollowVo> follow_list(String id){
			
			return sqlSession.selectList(NAMESPACE+"main_selectList", id);
			
		}
		
		//feed list - follow
		public List<FeedVo> feed_list(Map<String, Object> m){
			
			return sqlSession.selectList(NAMESPACE+"main_selectList_feed", m);
		}
		
		//feed list - random
		public List<FeedVo> feed_list_random(int count){
			
			return sqlSession.selectList(NAMESPACE + "main_selectList_feed_random", count);
		}
		
		//main_follow_feed
		public List<FeedVo> main_follow_feed_sql(Map<String, Object> fvo){
			
			
			return sqlSession.selectList(NAMESPACE+"main_follow_feed", fvo);
		}
		
		//feed count - default
		public int feed_count() {
			
			return sqlSession.selectOne(NAMESPACE + "feed_count");
		}
		
		//commnet list
		public List<CommentVo> select_comment(int feedno){
			
			return sqlSession.selectList(NAMESPACE+"select_comment", feedno);
		}
		
		//like list
		public List<LikesVo> select_like(int feedno){
				
			return sqlSession.selectList(NAMESPACE+"select_like",feedno);
		}
		
		//one feed
		public FeedVo select_each_feed(int feedno) {
			return sqlSession.selectOne(NAMESPACE + "each_feed", feedno);
		}
		
		//Account
		public AccountVo select_account(String id) {
			return sqlSession.selectOne(NAMESPACE+"select_account", id);
		}
		
		//PET
		public List<PetVo> select_pet_list(String id) {
			return sqlSession.selectList(NAMESPACE+"select_pet_list", id);
		}
		
		//feed - count x 
		public List<FeedVo> feed_list_nocount(String id){
			return sqlSession.selectList(NAMESPACE+"feed_list_nocount", id);
		}
		
		//follow count
		public int follow_count(String id) {
			return sqlSession.selectOne(NAMESPACE+"follow_count", id);
		}
		
		//follower count
		public int follower_count(String id) {
			return sqlSession.selectOne(NAMESPACE+"follower_count", id);
		}
		
		//insert_comment
		public int insert_comment_sql(CommentVo c) {
			return sqlSession.insert(NAMESPACE+"insert_comment", c);
		}
		
		//delete_comment
		public int delete_comment(int comment_no) {
			return sqlSession.delete(NAMESPACE+"delete_comment", comment_no);
		}
		
		//update_comment
		public int update_comment(CommentVo c) {
			return sqlSession.update(NAMESPACE+"update_comment", c);
		}
		
		//feed_like_insert
		public int feed_like_insert_sql(LikesVo l) {
			return sqlSession.insert(NAMESPACE+"feed_like_insert", l);
		}
		
		//feed_like_delete
		public int feed_like_delete_sql(LikesVo l) {
			return sqlSession.delete(NAMESPACE+"feed_like_delete", l);
		}
		
		//find_id
		public AccountVo find_id_sql(String email) {
			return sqlSession.selectOne(NAMESPACE+"find_id",email);
		}
		
		//find_vo
		public AccountVo find_vo_sql(AccountVo vo) {
			return sqlSession.selectOne(NAMESPACE+"find_vo", vo);
		}
		
		//pwdfind_update
		public int pwdfind_update_sql(AccountVo vo) {
			return sqlSession.update(NAMESPACE+"pwdfind_update", vo);
		}
		
		//search_id
		public List<FeedVo> search_id_sql(String keyword){
			return sqlSession.selectList(NAMESPACE+"search_id", keyword);
		}
		
		//search_ptag
		public List<FeedVo> search_ptag_sql(String keyword){
			return sqlSession.selectList(NAMESPACE+"search_ptag", keyword);
		}
		
		//search_htag
		public List<FeedVo> search_htag_sql(String keyword){
			return sqlSession.selectList(NAMESPACE+"search_htag", keyword);
		}
		
		//search_id_count
		public List<FeedVo> search_id_count(Map m){
			return sqlSession.selectList(NAMESPACE+"search_id_count", m);
		}
		
		//search_ptag_count
		public List<FeedVo> search_ptag_count(Map m){
			return sqlSession.selectList(NAMESPACE+"search_ptag_count", m);
		}
		
		//search_ptag_count
		public List<FeedVo> search_htag_count(Map m){
			return sqlSession.selectList(NAMESPACE+"search_htag_count", m);
		}
		
		//select_board_list
		public List<BoardVo> select_board_list(String id){
			return sqlSession.selectList(NAMESPACE+"select_board_list",id);
		}
		
		//delete_user_chat
		public int delete_user_sql(String id) {
			
			int count = 0;
			int res = 0;
			
			
			sqlSession.delete(NAMESPACE+"delete_user_chat", id);			
			sqlSession.delete(NAMESPACE+"delete_user_follow", id);
			sqlSession.delete(NAMESPACE+"delete_user_like", id);
			sqlSession.delete(NAMESPACE+"delete_user_comment", id);
			sqlSession.delete(NAMESPACE+"delete_user_feed", id);
			sqlSession.delete(NAMESPACE+"delete_user_pet",id);
			sqlSession.delete(NAMESPACE+"delete_user_board", id); 
			
			res = sqlSession.delete(NAMESPACE + "delete_user_account", id);
			if(res>0) {
				count++;
			}

			return count;
		}
		
		//detail_follow_insert
		public int detail_follow_insert_sql(FollowVo fvo) {
			return sqlSession.insert(NAMESPACE+"detail_follow_insert", fvo);
		}
		
		//deatil_follow_delete
		public int deatil_follow_delete_sql(FollowVo fvo) {
			return sqlSession.delete(NAMESPACE+"deatil_follow_delete", fvo);
		}
		
		
		//follow_list_yn
		public FollowVo follow_list_yn_sql(FollowVo fvo) {
			return sqlSession.selectOne(NAMESPACE+"follow_list_yn",fvo);
		}

}
