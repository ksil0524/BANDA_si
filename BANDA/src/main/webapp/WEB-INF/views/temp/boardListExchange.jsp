<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>

	<!-- ==============================================
	Styles
	=============================================== -->
	<link href="<%=request.getContextPath() %>/resources/temp/assets/css/custom-boardlist.css" rel="stylesheet" />
	<link href="<%=request.getContextPath() %>/resources/temp/assets/css/custom-page.css" rel="stylesheet" />
	<!-- index_circle_custom CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">
	
</head>
<body style="background-color: #f4f4f4;">
<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>

	<!-- ==============================================
	HeaderSection
	=============================================== -->
	<jsp:include page="/WEB-INF/views/circle-header.jsp"></jsp:include>

	 <!-- ==============================================
	 Navbar Second Section + Style
	 =============================================== -->
	<section class="nav-sec" style="margin-top: 15px; height: 60px;">
	  <div class="d-flex justify-content-between">
	   <div class="p-2 nav-icon-lg clean-black"style="height: 59px;">
	   <a class="nav-icon" href="boardListFree.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>무료나눔</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg mint-green" style="height: 59px; background-color: #ff7f73 !important;">
	   <a class="nav-icon" href="boardListExchange.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>물물교환</span>
	   </a>
	   </div>
	   
	   <style>
	   .nav-icon-lg {
	   	width: 400px !important;
	   }
	   </style>
	    
	  </div>
	</section>
	
	 <!-- ==============================================
	 Button Section
	 =============================================== --> 
	 
	 <section class="button-menu">
	  <div class="container">
	  	<!-- 검색 부분 시작 -->
		<span id="searchinputBox">
		  	<select name="searchType" id="searchType">
		  		<option value="title"<c:out value="${scri.searchType eq 'title' ? 'selected' : '' }"/>>제목</option>
		  		<option value="content"<c:out value="${scri.searchType eq 'content' ? 'selected' : '' }"/>>내용</option>
		  		<option value="writer"<c:out value="${scri.searchType eq 'writer' ? 'selected' : '' }"/>>글쓴이</option>
		  	</select>
		  	<c:if test="${scri.searchType eq 'tag'}">
				<input type="text" name="keyword" id="searchKeyword" value="" placeholder="검색어를 입력하세요"/>
		  	</c:if>
		  	<c:if test="${scri.searchType ne 'tag'}">
				<input type="text" name="keyword" id="searchKeyword" value="${scri.keyword }" placeholder="검색어를 입력하세요"/>
		  	</c:if>
			<div id="searchBtn" onclick="boardSearch();"><i class="fas fa-search" style="width: 25px; height: 25px; color: #ff7f73 !important;"></i></div>
		</span>
		
		<!-- 검색 자바스크립트 -->
	 	<script type="text/javascript">
		 	function boardSearch() {
		 		var btn = document.getElementById('searchBtn');
		 		var searchType = document.getElementById('searchType');
		 		var selected = searchType.options[searchType.selectedIndex].value;
		 		var keyword = document.getElementById('searchKeyword').value;
		 		
		 		location.href="boardListExchange.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + selected + "&keyword=" + keyword;
		 		
		 	}
	 	</script>
	  	<!-- 검색 부분 끝 -->
	  	
	  	<!-- 글쓰기 버튼 시작 -->
	  	<form action="boardWriteForm.do">
		  	<input type="hidden" name="board_cate" value="EX"/>
		   	<button type="submit" class="kafe-btn pull-right btn-sm board-write-btn" onclick="location.href='boardWriteForm.do'" style="position: relative; top: -3.2em; width: 7em;">글쓰기</button>
	   	</form>
	  	<!-- 글쓰기 버튼 끝 -->
	  	
	  </div>
	 </section>
	 

	 <!-- ==============================================
	 Board List Section
	 =============================================== --> 
	 <section class="boardlist">
	  <div class="container">
	  

	   <c:if test="${(not empty list) && ((scri.searchType eq 'title') || (scri.searchType eq 'content') || (scri.searchType eq 'writer') || (scri.searchType eq 'tag'))}">
	     <div class="row">
	   	   <span style="font-size: 24px; color: #ff7f73;">&nbsp;<i class="fas fa-search"></i> 검색결과</span>
	     </div>
	   </c:if>
	  
	   <!-- 공지사항 부분 시작-->	   
	   <div class="row">
	   	<div class="upper-notice" style="padding: 1em;">
	   	  <table>
	   	  	<colgroup>
	   	  	  <col style="width: 90px;">
	   	  	  <col>
	   	  	  <col style="width: 130px;">
	   	  	  <col style="width: 100px;">
	   	  	  <col style="width: 100px;">
	   	  	</colgroup>
	   	  	<c:if test="${(not empty list) && (scri.searchType ne 'title') && (scri.searchType ne 'content') && (scri.searchType ne 'writer') && (scri.searchType ne 'tag')}">
	   	  	  <c:if test="${not empty listExchangeNotice}">
	   	  	    <thead>
		   	      <tr>
		   	  	    <th><!-- 공지 --></th>
		   	  	    <th>제목</th>
		   	  	    <th>글쓴이</th>
		   	  	    <th>작성일</th>
		   	  	    <th>조회수</th>
		   	      </tr>
	   	  	    </thead>
	   	  	    <c:forEach items="${listExchangeNotice }" var="listExNotice">	   	  	
		   	  	  <tbody>
		   	  	    <tr>
		   	  		  <td class="td_notice" style="font-weight: 700;">공지</td>
		   	  	  	  <td class="td_title"><a href="boardDetail.do?board_no=${listExNotice.board_no }">${listExNotice.board_title }</a><span> [${fn:length(listExNotice.comment_list)}]</span></td>
		   	  	  	  <td class="td_writer">${listExNotice.id }</td>
		   	  	  	  <td class="td_date"><fmt:formatDate value="${listExNotice.board_regdate }" pattern="yyyy-MM-dd"/></td>
		   	  	  	  <td class="td_view">${listExNotice.board_view }</td>
		   	  	    </tr>
		   	  	  </tbody>
	   	  	    </c:forEach>	   	  	
	   	  	  </c:if>
	   	  	</c:if>
	   	  </table>
	   	</div><!--/ upper-notice -->
	   </div><!--/ div row -->
	   <!--/ 공지사항 부분 끝 -->
	  
	   <!-- 게시글 부분 시작 -->	  
	   <div class="row">
	     <c:choose>
	       <c:when test="${empty list }">
	         <h3 style="text-align:center; color: #ff7f73;">등록된 게시물이 없습니다.</h3>
	       </c:when>
	       <c:when test="${not empty list }">
	         <c:forEach items="${list}" var="listEx">
			    <div class="col-lg-4">
				 <a href="boardDetail.do?board_no=${listEx.board_no }&page=${scri.page}&searchType=${scri.searchType}&keyword=${scri.keyword}">
				 <div class="explorebox" 
				   style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), url('<%=request.getContextPath() %>/resources/images/filemanager/board/${listEx.board_no }/boardImg.jpg'), url('<%=request.getContextPath() %>/resources/images/logo_white.png') no-repeat;
				          background-size: cover;
		                  background-position: center center;
		                  -webkit-background-size: cover;
		                  -moz-background-size: cover;
		                  -o-background-size: cover;">
				  <div class="explore-top">
				   <div class="explore-like"><i class="fas fa-eye"></i> <span>${listEx.board_view }</span></div>
				   <div class="explore-circle pull-right"><i class="fa fa-comments"></i> <span>${fn:length(listEx.comment_list)}</span></div>
		          </div>		
		
		          <div class="story-body">
		           <h3>${listEx.board_title }</h3>
		           <div class=""><img class="img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${listEx.id }/image.jpg" onerror="this.src='<%=request.getContextPath() %>/resources/images/user_default_profile.png'" alt="user"></div>
		           <h4>${listEx.id }</h4>
		           <p><fmt:formatDate value="${listEx.board_regdate }" pattern="yyyy-MM-dd"/></p>
		          </div>  
				 </div>
				 </a>
				</div><!--/ col-lg-4 -->
			 </c:forEach>
		   </c:when>
		 </c:choose>
	   </div><!--/ row -->
	   <!--/ 게시글 부분 끝 -->	  
	   
	  </div><!--/ container -->
	 </section><!--/ newsfeed -->
	 
	 <!-- ==============================================
	 Page Section
	 =============================================== -->

	 <nav aria-label="Page navigation example" style="background-color: #f4f4f4; padding-bottom:100px;">
	  <div class="container">
	 	<div class="row">
		  <ul class="pagination justify-content-end">
			  <!-- « » -->
			<c:if test="${pageMaker.prev }">
			    <li><a href="boardListExchange.do${pageMaker.makeSearch(pageMaker.startPage-1)}">❮❮</a></li>
			</c:if>	
			<c:forEach var="idx" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			  <li><a href="boardListExchange.do${pageMaker.makeSearch(idx)}">${idx}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                  <li><a href="boardListExchange.do${pageMaker.makeSearch(pageMaker.endPage+1)}">❯❯</a></li>
            </c:if>
			</ul>
	 	</div><!--/ row -->
	   </div><!--/ container -->
	 </nav>
	 
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	
     <!-- ==============================================
	 Scripts
	 =============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>

    <!-- ==============================================
	HEADER CIRCLE Scripts
	=============================================== -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/util.js"></script>
	<!-- main 외  페이지 전용 -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/circle-header.js"></script>
	<!-- Auto Script -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
  </body>
</html>
