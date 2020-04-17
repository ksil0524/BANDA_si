<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mvc.banda.model.vo.AccountVo"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>

	<%
		AccountVo accvo = (AccountVo)session.getAttribute("vo");
	%>
	
	<!-- ==============================================
	Styles
	=============================================== -->
	<link href="<%=request.getContextPath() %>/resources/temp/assets/css/custom-boardwrite.css" rel="stylesheet" />
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
	   <c:set var="prevPage" value="${category }"/>
	     <c:if test="${fn:contains(prevPage, 'SH')}">
	       <div class="p-2 nav-icon-lg mint-green"style="height: 59px; background-color: #ff7f73 !important;">
	         <a class="nav-icon" href="boardListFree.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		       <span>무료나눔</span>
	         </a>
	       </div>
	       <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	         <a class="nav-icon" href="boardListExchange.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		       <span>물물교환</span>
	         </a>
	       </div> 
	     </c:if>
	     <c:if test="${fn:contains(prevPage, 'EX')}">
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
	     </c:if>
	   
	   <style>
	   .nav-icon-lg {
	   	width: 400px !important;
	   }
	   </style>
	    
	  </div>
	</section>
  
	 <!-- ==============================================
	 News Feed Section
	 =============================================== --> 
	 <section class="newsfeed">
	  <div class="container" style="width: auto;">
	  	<div class="col-lg-3" ></div><!--/ col-lg-3 -->
	   <!-- <div class="row"> -->
	    <div class="col-lg-6" style="">
	    <!-- style="width: inherit;" -->
		
         <div class="cardbox" style="color: #88898a; padding-bottom:86px !important;">
		  
		  <div class="board-form-title" style="padding: 20px;">
		  	<span style="border-bottom: 1px;"><h3>글쓰기</h3></span>
		  </div><!--/ board-form-title -->
		  <div class="board-form">
			<form:form method="post" enctype="multipart/form-data" name="insertForm" modelAttribute="BoardVo" action="boardWriteRes.do">
<!-- 			  <input type="hidden" value="<accvo.getId() %>" name="id"/>	 -->
 			  <input type="hidden" value="<%=accvo.getId() %>" name="id"/>
			  <div class="row" style="padding-left: 5% !important; padding-right: 5% !important;">
			    <div class="col-25">
			      <label for="boardtab">게시판선택</label>
			    </div>
			    <div class="col-75">
			      <select id="boardtab" name="board_cate">
			        <option value="SH" <c:if test="${category eq 'SH' }"> selected</c:if>>무료나눔</option>
			        <option value="EX" <c:if test="${category eq 'EX' }"> selected</c:if>>물물교환</option>
			      </select>
			    </div>
			  </div>
			  <div class="row" style="padding-left: 5% !important; padding-right: 5% !important;">
			    <div class="col-25">
			      <label for="title">제목</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="title" name="board_title" placeholder="제목을 입력하세요" required>
			    </div>
			  </div> 
			  <div class="row" style="padding-left: 5% !important; padding-right: 5% !important;">
			    <div class="col-25">
			      <label for="content">내용</label>
			    </div>
			    <div class="col-75">
			      <textarea id="content" name="board_content" placeholder="내용을 입력하세요" style="height:200px" required></textarea>
			    </div>
			  </div>
			  
			  <!-- 해시태그 -->		  
			  <div class="row" style="padding-left: 5% !important; padding-right: 5% !important;">
			    <div class="col-25">
			      <label for="hashtag">해시태그</label>
			    </div>
			    <div class="col-75">
			     <input type="text" id="tag-input1">
			     <input type="hidden" name="board_hash" id="board_hash" value="">
			      <script src="<%=request.getContextPath() %>/resources/temp/assets/js/index.js"></script>
			      <script>
			        var tagInput1 = new TagsInput({
			            selector: 'tag-input1',
			            duplicate : false,
			            max : 10
			       	 
			        });
			
			        tagInput1.addData('#tag-input1');
			        
//			        document.getElementById("board_hash").value=tagInput1.arr;
			       
			      </script>
			    </div>
			  </div>
			  <!--/ 해시태그 -->
			  
			  <div class="row" style="padding-left: 5% !important; padding-right: 5% !important;">
			    <div class="col-25">
			      <label for="board_file">첨부파일</label>
			    </div>
			    <div class="custom-file col-75 ">
			      <input type="file" class="custom-file-input" id="board_file" name="boardfile" required>
			      <label class="custom-file-label" for="board_file"></label>
			    </div>
			  </div>
			  
			  <!-- 버튼 -->
			  <div class="row btns" style="padding-left: 5% !important; padding-right: 5% !important;">
			    <input type="submit" value="작성">
			    <c:if test="${category eq 'SH' }">
			      <input type="button" value="목록" onclick="location.href='boardListFree.do'">
			    </c:if>
			    <c:if test="${category eq 'EX' }">
			      <input type="button" value="목록" onclick="location.href='boardListExchange.do'">
			    </c:if> 
			  </div>
			  <!--/ 버튼 끝 -->
			  
			  </form:form>
		  </div><!--/ board-form -->
          			        
		 </div><!--/ cardbox -->	
		
		</div><!--/ col-lg-6 -->
	 	
	 	<div class="col-lg-3" ></div><!--/ col-lg-3 -->
	 	
	   <!-- </div> --><!--/ row -->
	  </div><!--/ container -->
	 </section><!--/ newsfeed -->
     
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
