package com.mvc.banda.dao;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.banda.common.SearchCriteria;
import com.mvc.banda.model.vo.BoardVo;
import com.mvc.banda.model.vo.CommentVo;

@Repository
public class NK_dao {
	private String NAMESPACE = "NK-mapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//페이징검색/////////////////////////////////////////////////////////////////////////
	
	//무료나눔 게시글 갯수
	public int listCountSh(SearchCriteria scri) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"listCountSh", scri);
		} catch(Exception e) {			
			e.printStackTrace();
		}
		
		return res;
	}
	
	//무료나눔 게시판 페이징
	public List<BoardVo> pagingListSh(SearchCriteria scri) {
		List<BoardVo> list = new ArrayList<BoardVo>();
	
		try {
			list = sqlSession.selectList(NAMESPACE+"pagingListSh", scri);
			
			for(BoardVo vo : list) {
				List<CommentVo> cList = selectBoardComList(vo.getBoard_no());
				vo.setComment_list(cList);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	//물물교환 게시글 갯수
	public int listCountEx(SearchCriteria scri) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"listCountEx", scri);
		} catch(Exception e) {			
			e.printStackTrace();
		}
		
		return res;
	}
	
	//물물교환 게시판 페이징
	public List<BoardVo> pagingListEx(SearchCriteria scri) {
		List<BoardVo> list = new ArrayList<BoardVo>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"pagingListEx", scri);
			
			for(BoardVo vo : list) {
				List<CommentVo> comList = selectBoardComList(vo.getBoard_no());
				vo.setComment_list(comList);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//페이징검색끝/////////////////////////////////////////////////////////////////////////
		
	//무료나눔 공지 목록 불러오기
	public List<BoardVo> selectListShNotice() {
		List<BoardVo> list = new ArrayList<BoardVo>();
			
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListShNotice");
			
			for(BoardVo vo : list) {
				List<CommentVo> cList = selectBoardComList(vo.getBoard_no());
				vo.setComment_list(cList);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		return list;
	}
	
	//물물교환 공지 목록 불러오기
	public List<BoardVo> selectListExNotice() {
		List<BoardVo> list = new ArrayList<BoardVo>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListExNotice");
			
			for(BoardVo vo : list) {
				List<CommentVo> comList = selectBoardComList(vo.getBoard_no());
				vo.setComment_list(comList);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//게시글 detail
	public BoardVo selectOneBoard(int board_no) {
		BoardVo vo = null;
		
		try {
			vo = sqlSession.selectOne(NAMESPACE+"selectOneBoard", board_no);
			
			List<CommentVo> comList = selectBoardComList(vo.getBoard_no());
			vo.setComment_list(comList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	//게시글을 공지로 등록하기
	public int boardSetNotice(int board_no) {
		int res = 0;
			
		try {
			res = sqlSession.update(NAMESPACE+"updateBoardToNotice", board_no);
		} catch(Exception e) {		
			e.printStackTrace();
		}
			
		return res;
	}

	//공지글을 일반 게시글로 내리기
	public int boardNoticeCancel(int board_no) {
		int res = 0;
			
		try {
			res = sqlSession.update(NAMESPACE+"updateNoticeToBoard", board_no);
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		return res;
	}	
	
	//마지막 시퀀스 번호 가져오기
	public int getLastBoardSeq() {
		int boardno = 0;
		
		try {
			boardno = sqlSession.selectOne(NAMESPACE+"getLastBoardSeq");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		//시퀀스는 nextval에서 대기하고 있으므로 -1해줘야함
		boardno--;
		
		return boardno;
	}
	
	//게시글 쓰기
	public int boardWrite(BoardVo vo) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insertBoard", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}	
	
	//게시글 수정
	public int boardUpdate(BoardVo vo) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updateBoard", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	//게시글 삭제
	public int boardDelete(int board_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"deleteBoard", board_no);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	//조회수
	public void boardViewCnt(int board_no) {
		sqlSession.update(NAMESPACE+"boardViewCnt", board_no);
	}
	
	//댓글 목록
	public List<CommentVo> selectBoardComList(int board_no) {
		List<CommentVo> list = new ArrayList<CommentVo>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectBoardCom", board_no);
		} catch(Exception e) {			
			e.printStackTrace();
		}
		
		return list;
	}
	
	//댓글 작성
	public int boardComWrite(CommentVo vo) {
		int res=0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insertBoardCom", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	//댓글 수정
	public int boardComUpdate(CommentVo vo) {
		int res=0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"updateBoardCom", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	//댓글 삭제
	public int boardComDelete(int com_no) {
		int res=0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"deleteBoardCom", com_no);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
}
