package com.mvc.banda.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.banda.common.SearchCriteria;
import com.mvc.banda.dao.HJ_dao;
import com.mvc.banda.dao.JH_dao;
import com.mvc.banda.dao.JI_dao;
import com.mvc.banda.dao.JY_dao;
import com.mvc.banda.dao.NK_dao;
import com.mvc.banda.dao.SI_dao;
import com.mvc.banda.dao.UJ_dao;
import com.mvc.banda.model.vo.AccountVo;
import com.mvc.banda.model.vo.PetVo;
import com.mvc.banda.model.vo.FeedVo;
import com.mvc.banda.model.vo.FollowVo;
import com.mvc.banda.model.vo.LikesVo;
import com.mvc.banda.model.vo.MapVo;
import com.mvc.banda.model.vo.BoardVo;
import com.mvc.banda.model.vo.ChatVo;
import com.mvc.banda.model.vo.CommentVo;

@Service
public class BandaBiz {
	
	@Autowired
	private HJ_dao hj_dao;
	
	@Autowired
	private JH_dao jh_dao;
	
	@Autowired
	private JI_dao ji_dao;
	
	@Autowired
	private JY_dao jy_dao;
	
	@Autowired
	private NK_dao nk_dao;
	
	@Autowired
	private SI_dao si_dao;
	
	@Autowired
	private UJ_dao uj_dao;
	
	

	//------------------------------------------------------------------------------------------------------------------------------------
	// < 김성일 파트  시작 >  
	
	public AccountVo mypage_allselect(String id) {
		
		return si_dao.mypage_allselect(id);
		
	}
	
	public PetVo mypage_selectPet(int pno) {
		
		return si_dao.pet_selectOne(pno);
		
	}
	
	public int mypage_pet_update(PetVo petVo) {
		return si_dao.pet_update(petVo);
	}
	
	
	public int mypage_pet_insert(PetVo petVo) {
		return si_dao.pet_insert(petVo);
	}
	
	
	public int getLastPetSeq() {
		return si_dao.getLastPetSeq();
	}
	
	public int mypage_accountupdate(AccountVo accvo) {
		return si_dao.accountUpdate(accvo);
	}	
	
	public List<AccountVo> mypage_fd_accountSelectList(String id) {
		return si_dao.fd_accountSelectList(id);
	}

	public List<AccountVo> mypage_fr_accountSelectList(String id) {
		return si_dao.fr_accountSelectList(id);
	}
	
	public int mypage_unfollow(FollowVo fvo) {
		return si_dao.follow_unfollow(fvo);
	}
	
	public int mypage_follow(FollowVo fvo) {
		return si_dao.follow_follow(fvo);
	}
	
	public int mypage_insertfeed(FeedVo feedVo) {
		return si_dao.mypage_insertfeed(feedVo);
	}
	
	public int getLastFeedSeq() {
		return si_dao.getLastFeedSeq();
	}
	
	public int mypage_deletefeed(int deletefeed_no) {
		return si_dao.deletefeed(deletefeed_no);
	}
	
	public List<ChatVo> myChat_selectlist(String id) {
		return si_dao.myChat_selectlist(id);
	}

	public List<ChatVo> mychat_selectonelist(String userid, String otherid) {
		return si_dao.mychat_selectonelist(userid, otherid);
	}

	public int insert_chat(ChatVo vo) {
		return si_dao.insert_chat(vo);
	}

	public List<String> mychat_searchidlist() {
		return si_dao.select_allid();
	}

	
	// < 김성일 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 김재익 파트  시작 >  
	
	public  int idoverlab(String id) {
		return ji_dao.idoverlab(id);
	}

	public int joinregister(AccountVo vo) {
		// TODO Auto-generated method stub
		return ji_dao.joinregister(vo);
	}

	public int emailoverlab(String email) {
		// TODO Auto-generated method stub
		return ji_dao.emailoverlab(email);
	}
	

	
	
	// < 김재익 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 정유진 파트  시작 >  
	
	//login
	public AccountVo login(AccountVo vo) {

		
		
		return uj_dao.login(vo);
	}
	
	public int register(AccountVo vo) {
		
		
		return uj_dao.register(vo);
		
	}


	
	
	
	// < 정유진 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 정재호 파트  시작 >  
	
	// < 정재호 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 최주예 파트  시작 >  
	
		//login
		public AccountVo jy_login(AccountVo vo) {
			
			return jy_dao.jy_login(vo);
		}
		
		//naverlogin - register
		public int naver_register(AccountVo vo) {
			
			return jy_dao.naver_register(vo);
		}
		
		//main_selectList - 로그인시
		public AccountVo main_selectList(String id) {
			
			return jy_dao.main_selectList(id);
		}
	
		//main_selectListN - 비로그인/ 팔로우없을떄/ 
		public List<FeedVo> main_selectListN() {
			
			return jy_dao.main_selectListN();
		}
		
		//main_selectFollow - 로그인시 팔로우 판단
		public List<FollowVo> main_selectFollow(String id) {
			return jy_dao.main_selectFollow(id);
		}
		
		//팔로우들의 피드 가져오기
		public List<FeedVo> main_follow_feed(List<FollowVo> fvo){
			return jy_dao.main_follow_feed(fvo);
		}
		
		//내피드가져오기
		public List<FeedVo> my_feedList(String id){
			return jy_dao.my_feedList(id);
		}
		
		//피드하나가져오기
		public FeedVo each_feed(int feedno) {
			return jy_dao.each_feed(feedno);
		}
		
		//타인 피드 가져오기
		public Map<String, Object> main_otherfeed(String id){
			return jy_dao.main_otherfeed(id);
		}
		
		//답글 가져오기
		public List<CommentVo> main_select_comment(int feedno) {
			return jy_dao.main_select_comment(feedno);
		}
		
		//댓글 삽입
		public int main_insert_comment(CommentVo c) {
			return jy_dao.main_insert_comment(c);
		}

		//댓글 삭제
		public int main_delete_comment(CommentVo c) {
			return jy_dao.main_delete_comment(c);
		}
		
		//댓글 갱신
		public int main_update_comment(CommentVo c) {
			return jy_dao.main_update_comment(c);
		}

		//좋아요 삽입
		public int feed_like_insert(LikesVo l) {
			return jy_dao.feed_like_insert(l);
		}
		
		//좋아요 삭제
		public int feed_like_delete(LikesVo l){
			return jy_dao.feed_like_delete(l);
		}
		
		//좋아요 리스트
		public List<LikesVo> main_like_list(int feedno){
			return jy_dao.main_like_list(feedno);
		}
		
		//아이디 찾기
		public AccountVo find_id(String email) {
			return jy_dao.find_id(email);
		}
		
		//아이디 이메일로 계정 찾기
		public AccountVo find_vo(AccountVo vo) {
			return jy_dao.find_vo(vo);
		}
		
		//비밀번호찾기에서 비밀번호 업데이트
		public int pwdfind_update(AccountVo vo) {
			return jy_dao.pwdfind_update(vo);
		}
		
		//아이디 검색
		public List<FeedVo> search_id(String keyword){
			return jy_dao.search_id(keyword);
		}
		
		//ptag 검색
		public List<FeedVo> search_ptag(String keyword){
			return jy_dao.search_ptag(keyword);
		}
		
		//htag로 검색
		public List<FeedVo> search_htag(String keyword){
			return jy_dao.search_htag(keyword);
		}
		
		//회원 삭제
		public Map<String, Object> delete_user(String id) {
			return jy_dao.delete_user(id);
		}
		
		//팔로우 삽입
		public int detail_follow_insert(FollowVo fvo) {
			return jy_dao.detail_follow_insert(fvo);
		}
		
		//팔로우 삭제
		public int deatil_follow_delete(FollowVo fvo) {
			return jy_dao.deatil_follow_delete(fvo);
		}
	
		//팔로우 여부
		public int follow_list_yn(FollowVo fvo) {
			return jy_dao.follow_list_yn(fvo);
		}
	// < 최주예 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 주희진 파트  시작 >  
	public List<String> map_autocompleteAjax(HashMap<String, String> searchMap){
		/*
		 * 검색어 자동완성
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200213
		*/
		
		return hj_dao.map_autocompleteAjax(searchMap);
		
	}

	public List<MapVo> map_defaultLocationAjax(HashMap<String, String> searchMap){
		/*
		 * Map 클라이언트 행정동 기본 위치 정보 
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200221
		 */
		
		return hj_dao.map_defaultLocationAjax(searchMap);
	}
	
	public List<MapVo> map_searchLocationAjax(HashMap<String, String> searchMap){
		/*
		 * Map 검색 위치 정보 
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200221
		 */
		
		return hj_dao.map_searchLocationAjax(searchMap);
		
	}


	public List<String> circleheader_autosearch(String keyword, String searchtype){
		/*
		 * 검색어 자동완성
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200219
		*/
		return hj_dao.circleheader_autosearch(keyword, searchtype);
	}
	

	
	// < 주희진 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 하나경 파트  시작 >  
	
	//페이징검색//////////////////////////////////////////
	//무료나눔
	public List<BoardVo> pagingListSh(SearchCriteria scri) throws Exception {
		return nk_dao.pagingListSh(scri);
	}
	
	public int listCountSh(SearchCriteria scri) throws Exception {
		return nk_dao.listCountSh(scri);
	}
	
	//물물교환
	public List<BoardVo> pagingListEx(SearchCriteria scri) throws Exception {
		return nk_dao.pagingListEx(scri);
	}
	
	public int listCountEx(SearchCriteria scri) throws Exception {
		return nk_dao.listCountEx(scri);
	}	
	
	//페이징검색끝///////////////////////////////////////////
	
	//무료나눔 공지목록 출력
	public List<BoardVo> selectListShNotice() {
		return nk_dao.selectListShNotice();
	}

	//물물교환 공지목록 출력
	public List<BoardVo> selectListExNotice() {
		return nk_dao.selectListExNotice();
	}
	
	//게시글 상세 보기
	public BoardVo selectOneBoard(int board_no) throws Exception {
		nk_dao.boardViewCnt(board_no);
		return nk_dao.selectOneBoard(board_no);
	}	

	//게시글을 공지로 등록하기
	public int boardSetNotice(int board_no) {
		return nk_dao.boardSetNotice(board_no);
	}

	//공지글을 일반 게시글로 내리기
	public int boardNoticeCancel(int board_no) {
		return nk_dao.boardNoticeCancel(board_no);
	}

	//마지막 시퀀스 번호 가져오기
	public int getLastBoardSeq() {
		return nk_dao.getLastBoardSeq();
	}
	
	//게시글 쓰기
	public int boardWrite(BoardVo vo) {
		return nk_dao.boardWrite(vo);
	}

	//게시글 수정
	public int boardUpdate(BoardVo vo) {
		return nk_dao.boardUpdate(vo);
	}

	//게시글 삭제
	public int boardDelete(int board_no) {
		return nk_dao.boardDelete(board_no);
	}
	
	
	//댓글 목록
	public List<CommentVo> selectBoardComList(int board_no) {
		return nk_dao.selectBoardComList(board_no);
	}

	//댓글 작성
	public int boardComWrite(CommentVo vo) {
		return nk_dao.boardComWrite(vo);
	}
	
	//댓글 수정
	public int boardComUpdate(CommentVo vo) {
		return nk_dao.boardComUpdate(vo);
	}
	
	//댓글 삭제
	public int boardComDelete(int com_no) {
		return nk_dao.boardComDelete(com_no);
	}








	
	// < 하나경 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	
	
}
