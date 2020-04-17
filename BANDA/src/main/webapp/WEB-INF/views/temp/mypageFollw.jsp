<%@page import="com.mvc.banda.model.vo.PetVo"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="javax.swing.Box.Filler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mvc.banda.model.vo.FollowVo"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.banda.model.vo.AccountVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>
     <!-- index_circle_custom CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">
     <style type="text/css">
     	a:hover, a.active{
     		color:#ff7f73 !important;
     	}
     </style>
     <!-- ==============================================
	 Scripts
	 =============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/follwer.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/assets/js/custom-mypage-accountProfileImage.js"></script>
	
	<%
		AccountVo accvo = (AccountVo)session.getAttribute("vo");
	%>	  	  
	
	
	<script type="text/javascript">
		
	$(function(){
		
		$("#loadBtn").click(function(){
			location.href='mypage_followpage.do';
		});
		
		
	});
	
	
		function follow_func(fuf, frid, fdid){
			
			var fr_id = frid;
			var fd_id = fdid;
			
			var idarr = [frid, fdid];
			
			
			console.log(idarr);
			
			if(fuf == 'uf'){
				
				$.ajax({
					
					type:"post",
					url:"mypage_unfollow.do",
					data:JSON.stringify(idarr),
					contentType:"application/json",
					dataType:"json",
					success : function(data){	
						var res = data.res;

						if(res){
							$("#followbtn_fd_"+fdid).css("background","#ff7f73");							
							$("#followbtn_fd_"+fdid).attr("onclick","follow_func('f','"+frid+"','"+fdid+"')");
							$("#followbtn_fd_"+fdid).text("add follow");							
						}else{
							alert("false");	
						}

					},
					error : function(){
						alert("fail");
					}
					
				});
				
			}else if(fuf == 'f'){
				
				$.ajax({
					type:"post",
					url:"mypage_follow.do",
					data:JSON.stringify(idarr),
					contentType:"application/json",
					dataType:"json",
					success : function(data){	
						var res = data.res;

						if(res){
							$("#followbtn_fd_"+fdid).css("background","lightgray");							
							$("#followbtn_fd_"+fdid).attr("onclick","follow_func('uf','"+frid+"','"+fdid+"')");
							$("#followbtn_fd_"+fdid).text("following");							
						}else{
							alert("false");	
						}
						

					},
					error : function(){
						alert("fail");
					}
					
				});
				
			}
			
			
		};
	
	</script>

</head>
<body>
<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>

	<!-- ==============================================
	HeaderSection
	=============================================== -->
	<jsp:include page="/WEB-INF/views/circle-header.jsp"></jsp:include>
	
	<!-- ==============================================
	Navbar Second Section
	=============================================== -->
	<section class="nav-sec" style="margin-top: 15px; height: 60px;">
	  <div class="d-flex justify-content-between">
	   <div class="p-2 nav-icon-lg mint-green"style="height: 59px;">
	   <a class="nav-icon" href="mypage_followpage.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>F / F</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	   <a class="nav-icon" href="mypage_allselect.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의 반려동물</span>
	   </a>
	   </div>
	   
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	   <a class="nav-icon" href="mypageFeed.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의피드</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	   <a class="nav-icon" href="mypage_accountpage.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>내계정</span>
	   </a>
	   </div>
	  </div>
	</section>		
  
	 <!-- ==============================================
	 News Feed Section
	 =============================================== --> 
	 <section class="profile">
	  <div class="container-fluid">
	   <div class="row" >
	   	<img alt="ffbg" src="<%=request.getContextPath()%>/resources/images/bg/ff_bg.png" width="100%">
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  
	 <!-- ==============================================
	 User Profile Section
	 =============================================== --> 
	 <section class="user-profile">
	  <div class="container-fluid">
	   <div class="row">
	   
	    <div class="col-lg-12">
		   <div class="post-content">
		    <div class="author-post text-center">
				 <img class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=accvo.getId() %>/image.jpg" 
		     											   alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'" onclick="location.href='mypage_accountpage.do'">
			</div><!-- /author -->
		   </div><!-- /.post-content -->		
		</div><!-- /col-sm-12 -->
		
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  
	 <!-- ==============================================
	 User Profile Section
	 =============================================== --> 
	 <section class="details">
	  <div class="container">
	   <div class="row">
	    <div class="col-lg-12">
		 
          <div class="details-box row">
		   <div class="col-lg-12">
           <div class="content-box">
		     <h4>@<%=accvo.getId() %> <i class="fa fa-check" style="background: #ff7f73"></i></h4>
		     <!-- 
             <p>Welcome to the offical account of Anna Morgan. Success is in the PIXELS,(후에 소개 추가 예정) <span class="hashtag">#pixels</span></p>
		      -->
			 <small><span class="hashtag" style="color:#ff7f73;">
			 	<c:choose>
			 		<c:when test="<%=accvo.getPet_list().isEmpty() %>">
			 		( 반려동물을 추가해주세요. )
			 		</c:when>
			 		<c:otherwise>
			 			<c:forEach var="petvo" items="<%=accvo.getPet_list() %>">
			 				 : ${petvo.p_Name }
			 			</c:forEach>
			 		</c:otherwise>
			 	</c:choose>

			</span></small>
           </div><!--/ media -->
		   </div> 
		   <!-- <div class="col-lg-3">
           <div class="follow-box">
		    <a href="" class="kafe-btn kafe-btn-mint"><i class="fa fa-check"></i> Following</a>
           </div>/ dropdown
		   </div> -->
          </div><!--/ details-box -->
		  
		</div>
	   </div>
	  </div><!--/ container -->
	 </section><!--/ profile -->

	 <!-- ==============================================
	 Home Menu Section
	 =============================================== -->	
     <section class="home-menu">
      <div class="container">
       <div class="row">

        <div class="menu-category">
         <ul class="menu">
          <!-- <li class="current-menu-item"><a href="photo_profile.html">Posts <span>1.7k</span></a></li> -->
<%
	List<FollowVo> followlist =  accvo.getFollow_list();

	//현 계정이 팔로우 한사람의 수
	int fr_count=0;
	List<AccountVo> fr_acclist = (List<AccountVo>)request.getAttribute("fr_acclist");
	List<FollowVo> followerlist = new ArrayList<FollowVo>();
	
	//현 계정을 팔로우 한사람의 수
	int fd_count=0;
	List<AccountVo> fd_acclist = (List<AccountVo>)request.getAttribute("fd_acclist");
	List<FollowVo> followinglist = new ArrayList<FollowVo>();
	
	
	for(int i=0; i<followlist.size(); i++){
		if(followlist.get(i).getFr_id().equals(accvo.getId())){
			fr_count++;
			followerlist.add(followlist.get(i));
		}
		if(followlist.get(i).getFd_id().equals(accvo.getId())){
			fd_count++;
			followinglist.add(followlist.get(i));
		}
	}
	
%>
          <li id="followersNum">
          	<a id="FollowersTab" class="" href="#frends" data-toggle="tab">Followers<span style="background-color: #ff7f73"><%=fd_count %></span></a>
          </li>
          <li>
          	<a id="FollowingTab" class="" href="#frends-req" data-toggle="tab">Following<span style="background-color: #ff7f73"><%=fr_count %></span></a>
          </li>
         </ul>
		</div>
		
	   </div><!--/row -->
      </div><!--/container -->
     </section><!--/home-menu -->	


	 <!-- ==============================================
	 News Feed Section
	 =============================================== --> 
	 <section id="follwList" class="newsfeed">
	  <div class="container">
	  
	   <div class="row" style="margin-bottom: 200px;">
		<div class="col-lg-12" style="background: #fff;">
			<div class="frnds">
				<!-- <ul class="frnds-nav frnds-nav-tabs">
					 <li class="frnds-nav-item"><a id="FollowersTab" class="active" href="#frends" data-toggle="tab"><b>My Friends</b></a> <span> 55</span></li>
					 <li class="frnds-nav-item"><a id="FollowingTab" class="" href="#frends-req" data-toggle="tab"><b>Friend Requests</b></a><span> 60</span></li>
				</ul> -->
				<!-- Tab panes -->
				<div class="tab-content">
				  <div class="tab-pane active frnds-fade frnds-show" id="frends">
					<ul class="nearby-contct">
					<!-- 나를 팔로우 한사람 -->
					
					
					
<%
					if(fd_count == 0){
%>
					<li>
						<p align="center"> 현 계정을 팔로우한 사람이 없습니다. </p>
					</li>
<%						
					}else{
						for(int i=0 ; i<fd_acclist.size() ; i++){							
%>
						
						<li>
						<div class="nearly-pepls">
							<figure>
								<a href="#" title=""><img src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=fd_acclist.get(i).getId() %>/image.jpg" alt="" style="width: 100%; height: 100%;"></a>
							</figure>
							<div class="pepl-info">
								<h4><a href="main_otherfeed.do?id=<%=fd_acclist.get(i).getId() %>" title=""><%=fd_acclist.get(i).getId() %></a></h4>
								<span>
<%
								for(PetVo tmp : fd_acclist.get(i).getPet_list()){
%>
								:<%=tmp.getP_Name() %> &nbsp;
<%									
								}
%>
								</span>
								
<%
								// 나를 팔로우 하는 사람을 내가 팔로우 하고 있으면 팔로우 취소 버튼으로 아니면 팔로우 하기 버튼으로
								int j=0;
								while(j<=followerlist.size()){
									if(j == followerlist.size()){									
%>
										<a id="followbtn_fd_<%=fd_acclist.get(i).getId()%>" href="javascript:void(0);" class="add-butn" style="background: #ff7f73;" onclick="follow_func('f','<%=accvo.getId() %>','<%=fd_acclist.get(i).getId()%>');">add follow</a>
<%
										break;
									}
									
									if(fd_acclist.get(i).getId().equals(followerlist.get(j).getFd_id())){
%>
										<a id="followbtn_fd_<%=fd_acclist.get(i).getId()%>" href="javascript:void(0);" class="add-butn" style="background: lightgray;" onclick="follow_func('uf','<%=accvo.getId() %>','<%=fd_acclist.get(i).getId()%>');">following</a>
<%
										break;
									}
									j++;
								}
%>

								<!-- 								
								<a href="#" title="" class="add-butn more-action" data-ripple="">unfriend</a>
								<a href="#" title="" class="add-butn" data-ripple="" style="background: #0fc19e;">add friend</a>
								 -->
								
								
							</div>
						</div>
						</li>
						
<%	
						}
					}
%>					
					
				</ul>
					<div class="lodmore"><!-- <button id="loadBtn" class="btn-view btn-load-more"></button>  --><button id="loadBtn" class="fas fa-redo-alt"></button></div>
				  </div>
	<!--    -->
				  <div class="tab-pane fade" id="frends-req">
					<ul class="nearby-contct">
					<!-- 팔로우 하는 사람 -->
<%
					if(fr_count == 0){
%>
					<li>
						<p align="center"> 현 계정이 팔로우 한 사람이 없습니다. </p>
					</li>
<%						
					}else{
						for(int i=0 ; i<fr_acclist.size() ; i++){							
%>
	
						<li>
						<div class="nearly-pepls">
							<figure>
								<a href="#" title=""><img src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=fr_acclist.get(i).getId() %>/image.jpg" alt="" style="width: 100%; height: 100%;"></a>
							</figure>
							<div class="pepl-info">
								<h4><a href="main_otherfeed.do?id=<%=fr_acclist.get(i).getId()%>" title=""><%=fr_acclist.get(i).getId() %></a></h4>
								<span>
<%
								for(PetVo tmp : fr_acclist.get(i).getPet_list()){
%>
								:<%=tmp.getP_Name() %> &nbsp;
<%									
								}
%>
								</span>
																
<%
								// 나를 팔로우 하는 사람을 내가 팔로우 하고 있으면 팔로우 취소 버튼으로 아니면 팔로우 하기 버튼으로
								int j=0;
								while(j<=followerlist.size()){
									if(j == followerlist.size()){									
%>
										<a id="followbtn_fd_<%=fr_acclist.get(i).getId()%>" href="javascript:void(0);" class="add-butn" style="background: #0fc19e;" onclick="follow_func('f','<%=accvo.getId() %>','<%=fr_acclist.get(i).getId()%>');">add follow</a>
<%
										break;
									}
									
									if(fr_acclist.get(i).getId().equals(followerlist.get(j).getFd_id())){
%>
										<a id="followbtn_fd_<%=fr_acclist.get(i).getId()%>" href="javascript:void(0);" class="add-butn" style="background: lightgray;" onclick="follow_func('uf','<%=accvo.getId() %>','<%=fr_acclist.get(i).getId()%>');">following</a>
<%
										break;
									}
									j++;
								}
%>
							</div>
						</div>
						</li>	

<%	
						}
					}
%>					
				</ul>	
					  <button id="loadBtn" class="fas fa-redo-alt" onclick="location.href='mypage_followpage.do'"></button>
				  </div>
				</div>
			</div>
		</div>

	   </div><!--/ row -->
	   
	  </div><!--/ container -->
	 </section><!--/ newsfeed -->
  
	 <!-- ==============================================
	 Modal Section
	 =============================================== -->
     <div id="myModal" class="modal fade">
      <div class="modal-dialog">
       <div class="modal-content">
        <div class="modal-body">
		
         <div class="row">
		 
          <div class="col-md-8 modal-image">
           <img class="img-responsive" src="<%=request.getContextPath() %>/resources/temp/assets/img/posts/15.jpg" alt="Image"/>
          </div><!--/ col-md-8 -->
          <div class="col-md-4 modal-meta">
           <div class="modal-meta-top">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			 <span aria-hidden="true">×</span><span class="sr-only">Close</span>
			</button><!--/ button -->
            <div class="img-poster clearfix">
             <a href=""><img class="img-responsive img-circle" src="<%=request.getContextPath() %>/resources/temp/assets/img/users/18.jpg" alt="Image"/></a>
             <strong><a href="">Benjamin</a></strong>
             <span>12 minutes ago</span><br/>
		     <a href="" class="kafe kafe-btn-mint-small"><i class="fa fa-check-square"></i> Following</a>
            </div><!--/ img-poster -->
			  
            <ul class="img-comment-list">
             <li>
              <div class="comment-img">
               <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/17.jpeg" class="img-responsive img-circle" alt="Image"/>
              </div>
              <div class="comment-text">
               <strong><a href="">Anthony McCartney</a></strong>
               <p>Hello this is a test comment.</p> <span class="date sub-text">on December 5th, 2016</span>
              </div>
             </li><!--/ li -->
             <li>
              <div class="comment-img">
               <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/15.jpg" class="img-responsive img-circle" alt="Image"/>
              </div>
              <div class="comment-text">
               <strong><a href="">Vanessa Wells</a></strong>
               <p>Hello this is a test comment and this comment is particularly very long and it goes on and on and on.</p> <span>on December 5th, 2016</span>
              </div>
             </li><!--/ li -->
             <li>
              <div class="comment-img">
               <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/14.jpg" class="img-responsive img-circle" alt="Image"/>
              </div>
              <div class="comment-text">
               <strong><a href="">Sean Coleman</a></strong>
               <p class="">Hello this is a test comment.</p> <span class="date sub-text">on December 5th, 2016</span>
              </div>
             </li><!--/ li -->
             <li>
              <div class="comment-img">
               <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/13.jpeg" class="img-responsive img-circle" alt="Image"/>
              </div>
              <div class="comment-text">
               <strong><a href="">Anna Morgan</a></strong>
               <p class="">Hello this is a test comment.</p> <span class="date sub-text">on December 5th, 2016</span>
              </div>
             </li><!--/ li -->
             <li>
              <div class="comment-img">
               <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/3.jpg" class="img-responsive img-circle" alt="Image"/>
              </div>
              <div class="comment-text">
               <strong><a href="">Allison Fowler</a></strong>
               <p class="">Hello this is a test comment.</p> <span class="date sub-text">on December 5th, 2016</span>
              </div>
             </li><!--/ li -->
            </ul><!--/ comment-list -->
			  
            <div class="modal-meta-bottom">
			 <ul>
			  <li><a class="modal-like" href="#"><i class="fa fa-heart"></i></a><span class="modal-one"> 786,286</span> | 
			      <a class="modal-comment" href="#"><i class="fa fa-comments"></i></a><span> 786,286</span> </li>
			  <li>
			   <span class="thumb-xs">
				<img class="img-responsive img-circle" src="<%=request.getContextPath() %>/resources/temp/assets/img/users/13.jpeg" alt="...">
			   </span>
			   <div class="comment-body">
				 <input class="form-control input-sm" type="text" placeholder="Write your comment...">
			   </div><!--/ comment-body -->	
              </li>				
             </ul>				
            </div><!--/ modal-meta-bottom -->
			  
           </div><!--/ modal-meta-top -->
          </div><!--/ col-md-4 -->
		  
         </div><!--/ row -->
        </div><!--/ modal-body -->
		
       </div><!--/ modal-content -->
      </div><!--/ modal-dialog -->
     </div><!--/ modal -->	 
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		   

		
    <!-- ==============================================
	HEADER CIRCLE Scripts
	=============================================== -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/util.js"></script>
	<!-- main 외  페이지 전용 -->

	<script src="<%=request.getContextPath() %>/resources//assets/js/circle-header.js"></script>
	<!-- Auto Script -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	

  </body>
</html>
