<%@page import="com.mvc.banda.model.vo.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mvc.banda.model.vo.AccountVo"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>
<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>

	<%
		AccountVo accvo = (AccountVo)session.getAttribute("vo");
		pageContext.setAttribute("br", "<br/>");
	    pageContext.setAttribute("cn", "\n");
	%>
	
	<!-- ==============================================
	Styles
	=============================================== -->
	<link href="<%=request.getContextPath() %>/resources/temp/assets/css/custom-boarddetail.css" rel="stylesheet" />
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
	   <c:set var="boardCate" value="${detail.board_cate}"/>
	   <c:choose>
	     <c:when test="${fn:contains(boardCate, 'SH')}">
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
	     </c:when>
	     <c:when test="${fn:contains(boardCate, 'EX')}">
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
	     </c:when>
	   </c:choose>
	  
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
	  <div class="container">
	  	<div class="col-lg-3" ></div><!--/ col-lg-3 -->
	   <!-- <div class="row"> -->
	    <div class="col-lg-6" >
	    <!-- style="width: inherit;" -->
		
         <div class="cardbox">
         
         <form name="readForm" role="form" method="post">
         	<input type="hidden" id="bno" name="board_no" value="${detail.board_no}" />
  			<input type="hidden" id="page" name="page" value="${scri.page}">  
  			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		 
          <div class="cardbox-heading">
           <!-- START dropdown-->
           
           <c:if test='${("ADMIN" eq vo.id)||(detail.id eq vo.id)}'>
           
           <div class="dropdown pull-right">
            <button class="btn btn-secondary btn-flat btn-flat-icon" type="button" data-toggle="dropdown" aria-expanded="false">
		     <em class="fa fa-ellipsis-h"></em>
			</button>
            <div class="dropdown-menu dropdown-scale dropdown-menu-right" role="menu" style="position: absolute; transform: translate3d(-136px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
             <c:set var="boardtf" value="${(detail.id eq vo.id)?'y':'n' }"/>
             <c:if test="${'y' eq boardtf }">
	         <a class="dropdown-item" href="boardUpdateForm.do?board_cate=${detail.board_cate}&board_no=${detail.board_no }">수정</a>
             </c:if>
			 <c:set var="noticeChk" value="${detail.board_nyn}"/>
			 <c:if test='${("ADMIN" eq vo.id)||(detail.id eq vo.id)?true:false}'>
			 <a class="dropdown-item" href="boardDelete.do?board_cate=${detail.board_cate}&board_no=${detail.board_no }">삭제</a>
             </c:if>
			 <c:if test='${("ADMIN" eq vo.id)?true:false}'>
			 <c:choose>
			   <c:when test="${fn:contains(noticeChk, 'Y')}">
	         	 <a class="dropdown-item" href="boardSetNoticeCancel.do?board_cate=${detail.board_cate}&board_no=${detail.board_no }">공지해제</a>
	           </c:when>
			   <c:when test="${fn:contains(noticeChk, 'N')}">
	         	 <a class="dropdown-item" href="boardSetNotice.do?board_cate=${detail.board_cate}&board_no=${detail.board_no }">공지등록</a>
	           </c:when>
	         </c:choose>    
			 </c:if>
            </div>
           </div><!--/ dropdown -->
           
           </c:if>
           
           <!-- END dropdown-->
           <script type="text/javascript">
           $(function(){
        	   var a = '${detail.id}';
        	   var b = '${vo.id}';
        	   console.log(a+b);
        	   });
           </script>
           
           <!-- 게시글 정보 - 제목, 글쓴이, 작성일자, 조회수 -->
           <div class="detail-info" style="margin-top: 10px; margin-bottom: 10px; padding-left: 10px;">
           <!-- TITLE -->
            <span class="detail-title">${detail.board_title }</span>   
           <!-- END title -->
            <div class="media m-0">
             <div class="d-flex mr-3">
			  <img class="img-responsive img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${detail.id }/image.jpg" onerror="this.src='<%=request.getContextPath() %>/resources/images/user_default_profile.png'" alt="User">
			 </div>
             <div class="media-body">
              <p class="m-0"><a href="main_otherfeed.do?id=${detail.id }" style="color: #88898A;">${detail.id }</a></p>
			  <small><span><fmt:formatDate value="${detail.board_regdate }" pattern="yyyy-MM-dd"/></span></small>
			  <div class="detail-view">
			 	<i class="fas fa-eye"></i><span> ${detail.board_view }</span>
			  </div>
             </div>
            </div><!--/ media -->
           </div><!--/detail-info  -->
          </div><!--/ cardbox-heading -->
          
          <!-- 본문 -->
		  <div class="cardbox-item">
		    <div class="cardbox-img">
		      <img class="img-responsive" src="<%=request.getContextPath() %>/resources/images/filemanager/board/${detail.board_no }/boardImg.jpg" onerror="this.src='<%=request.getContextPath() %>/resources/images/logo_profile.png'" alt="MaterialImg">
		    </div>
		    <div class="cardbox-content">
		     <div class="cardbox-text">
		       	${fn:replace(detail.board_content, cn, br) }
		     </div>
		     <div class="cardbox-hashtag">
		      <p id="pHash">
		      	<span id="pHashIcon"></span>
		      	<span id="pHashTags"></span>
		      </p>
		     </div><!--/ cardbox-hashtag -->
		    </div>
		   </form><!--/ form -->
          </div><!--/ cardbox-item -->
	      
	      <!-- 구분선  -->
	      <div>
	      <div class="img-poster" style="margin-left: 15px; margin-right: 15px;"></div>
	      </div>
	      
	      <!-- 댓글 -->
          <div class="cardbox-comments">     
          
		    <div class="cardbox-comment-count">
  		      <span class="com"><i class="fa fa-comments"></i></span> <span class="span-last">Comments</span><p/>
		    </div><!--/ cardbox-comment-count  -->
		    
		  <div class="cardbox-comment-list">
		   <ul class="img-comment-list">
		    <c:choose>
		      <c:when test="${empty detail.comment_list }">
		        <li style="text-align: center;">등록된 댓글이 없습니다. 댓글을 달아주세요!</li>
		      </c:when>
		      <c:otherwise>
		        <c:forEach items="${detail.comment_list }" var="comments">
		          <li>
                    <div class="comment-img">
                      <img src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${comments.id }/image.jpg" onerror="this.src='<%=request.getContextPath() %>/resources/images/user_default_profile.png'" class="img-responsive img-circle" alt="User"/>
                    </div>
                    <div class="comment-text">
                      <strong><a href="main_otherfeed.do?id=${comments.id }">${comments.id }</a></strong> <span class="date sub-text">on <fmt:formatDate value="${comments.com_regdate }" pattern="yyyy-MM-dd"/></span>
                      <c:set var="commenttf" value="${(comments.id eq vo.id)?'y':'n' }"/>
             		  <c:if test="${'y' eq commenttf }">
                      <span class="comment-edit-del"> <i class="fas fa-pen" id="boardComUpdate" onclick="commentEdit('${comments.com_content}', ${comments.com_no}, ${comments.com_pno})"></i></span>
                      <span class="comment-edit-del"> <i class="fas fa-times" onclick="location.href='boardComDelete.do?board_no=${detail.board_no }&com_no=${comments.com_no}'"></i></span>
                      </c:if>
                      <p>${comments.com_content }</p> 
                    </div>
                  </li><!--/ li -->
		        </c:forEach>
		      </c:otherwise>
		     </c:choose>
            </ul><!--/ comment-list -->
           </div><!--/ cardbox-comment-list -->
		   
		   <div class="comment-bottom">  
			<div class="comment-put" id="comment-put" style="">
			   <table style="width: 800px;">
		   	    <tr>
		   	     <td style="width: 50px;">
		   	     <img class="align-self-end mr-3 img-responsive img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${vo.id }/image.jpg" onerror="this.src='<%=request.getContextPath() %>/resources/images/user_default_profile.png'" alt="Image" style="position: absolute; margin-left:0.5em;">
    			 </td>
		   	     <td>
		   	       <form name="commentForm" id="commentForm" action="boardComWrite.do">
		   	         <input type="hidden" name="com_cate" value="B"/>
		   	         <input type="hidden" name="id" value="${vo.id }"/>
		   	         <input class="form-control input-sm" type="text" name="com_content" id="comInput" placeholder="댓글을 입력하세요"/>
		   	         <input type="hidden" name="com_pno" value="${detail.board_no }"/>
		   	       </form>
		   	     </td>
		   	     <td style="width: 50px;"><i class="fas fa-edit" onclick="chkComment1()"></i></td>
		   	    </tr>
		   	   </table>  
			 </div><!--/ comment-put -->
			 
			 <div class="comment-edit" id="comment-edit" style="display: none;">
			   <table style="width: 800px;">
		   	    <tr>
		   	     <td style="width: 50px;"><img class="align-self-end mr-3 img-responsive img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${vo.id }/image.jpg" onerror="this.src='<%=request.getContextPath() %>/resources/images/user_default_profile.png'" alt="Image" style="margin-left:0.5em;"></td>
		   	     <td>
		   	       <form name="commentUpdateForm" id="commentUpdateForm" action="boardComUpdate.do">
		   	         <input class="form-control input-sm" type="text" id="comEditor" name="com_content" placeholder="댓글을 입력하세요"/>
		   	         <input type="hidden" name="com_no" id="com_no" value=""/>
		   	         <input type="hidden" name="com_pno" id="com_pno" value=""/>
		   	       </form>
		   	     </td>
		   	     <td style="width: 50px;"><i class="fas fa-edit" onclick="chkComment2()"></i></td>
		   	    </tr>
		   	   </table>  
			 </div><!--/ comment-edit -->
			 
			 <!-- comment js start -->
             <script type="text/javascript">
            	function commentEdit(com_content, com_no, com_pno) {
            		var comPut = document.getElementById("comment-put");
            		var comEdit = document.getElementById("comment-edit");
            		var comEditor = document.getElementById("comEditor");
            		var comNo = document.getElementById("com_no");
            		var comPNo = document.getElementById("com_pno");
            		
            		comPut.setAttribute("style", "display: none;");
            		comEdit.setAttribute("style", "display: flex;");
					comEditor.value=com_content;
					comNo.value=com_no;
					comPNo.value=com_pno;
            	}
            	
			 	function chkComment1() {
			 		var comContent = document.getElementById("comInput").value;
			 		var comForm = document.commentForm;
			 		
			 		if(!comContent) {
			 			alert('내용을 입력해주세요!');
			 		} else {
			 			comForm.submit();
			 		}
			 	}
			 	
			 	function chkComment2() {			 		
			 		var comContent = document.getElementById("comEditor").value;
			 		var comForm = document.commentUpdateForm;
			 		
			 		if(!comContent) {
			 			alert('내용을 입력해주세요!');
			 		} else {
			 			comForm.submit();
			 		}
			 	}
             </script>
			 <!-- comment js end-->
			 
			 <div class="list-btn">
			   <c:if test="${detail.board_cate eq 'SH' }">
		         <button class="kafe-btn kafe-btn-mint-small pull-right btn-sm" onclick="location.href='boardListFree.do?page=${scri.page}&searchType=${scri.searchType}&keyword=${scri.keyword}'">목록</button>
			   </c:if>
			   <c:if test="${detail.board_cate eq 'EX' }">
		         <button class="kafe-btn kafe-btn-mint-small pull-right btn-sm" onclick="location.href='boardListExchange.do?page=${scri.page}&searchType=${scri.searchType}&keyword=${scri.keyword}'">목록</button>
			   </c:if>			   
		     </div><!--/ list-btn -->
		   
          </div><!--/ cardbox-comments -->			  
                
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
	
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
	<script type="text/javascript">
		var category = '${detail.board_cate}';
		var hashtags = '${detail.board_hash }';
		var hash = hashtags.split(",");
		var inner ='';
		      
		console.log('해시태그 : '+hash);
		console.log('카테고리 : '+category);

		for(var i=0 ; i<hash.length ; i++) {
			if (category == 'SH') {
				inner += '<a href="boardListFree.do?page=1&searchType=tag&keyword='+hash[i]+'" class="tagSearch" style="margin: 0 0.2em;"><span class="boardtag tagtext">'+hash[i]+'</span></a>';		
			} else if (category == 'EX') {
				inner += '<a href="boardListExchange.do?page=1&searchType=tag&keyword='+hash[i]+'" class="tagSearch" style="margin: 0 0.2em;"><span class="boardtag tagtext">'+hash[i]+'</span></a>';						
			}
		}
		
		if(hash=='' || hash==null) {	
			document.getElementById("pHashIcon").innerHTML='';
			document.getElementById("pHashTags").innerHTML = '';
		} else {
			document.getElementById("pHashIcon").innerHTML='<i class="fas fa-tag" style="color: #ff7f73 !important;"></i>';
			document.getElementById("pHashTags").innerHTML = inner;
		}
		      
	</script>
	
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
