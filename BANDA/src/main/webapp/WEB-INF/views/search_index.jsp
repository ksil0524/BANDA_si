<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import = "com.mvc.banda.model.vo.AccountVo" %>
<%@ page import = "com.mvc.banda.model.vo.FeedVo" %>
<%@ page import = "java.util.*" %>
<%@ page session = "true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML>
<html>
	<head>
<title>Radius by TEMPLATED</title>
		<meta charset="utf-8" />
	    <!-- ==============================================
		LOGIN CSS
		=============================================== -->
		<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
		<link href="<%=request.getContextPath() %>/resources/assets/css/custom-modal.css" rel="stylesheet" />
		<link href="<%=request.getContextPath() %>/resources/temp/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link href="<%=request.getContextPath() %>/resources/assets/css/login-register.css" rel="stylesheet" />
	    <!-- ==============================================
		CSS
		=============================================== -->
		<link href="<%=request.getContextPath() %>/resources/assets/icon/all.min.css" rel="stylesheet" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/custom.css" />
		
		<!-- Bootstrap core CSS -->
 		 <link href="<%=request.getContextPath() %>/resources/assets/css/bootstrap.min.css" rel="stylesheet">
 		 <link type="text/css" href="<%=request.getContextPath() %>/resources/temp/assets/css/custom-follower.css" rel="stylesheet" />
		
		<!-- favicon -->
		<link rel="icon" href="/favicon.ico"> 
		
		<!-- ==============================================
		Auto CSS
		=============================================== -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<!-- index_circle_custom CSS -->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/index_circle_custom.css">
		<!-- Login css -->
		<!-- <link href="login/assets/css/bootstrap.css" rel="stylesheet" /> -->
		<!-- <script src="login/assets/js/login-register.js" type="text/javascript"></script> -->
		
		<style type="text/css" >
		::-webkit-scrollbar {

		display:none;

		} 
		</style>

	</head>
	<body style="overflow-y: auto" style = "-ms-overflow-style: none;">
	<!-- TOP Button -->
	<a id="back-to-top" href="#" class="back-to-top" role="button" data-placement="left" data-toggle="modal" data-target="#myModal2" >
	<i class="fas fa-plus-circle"></i></a>	
	<!-- Header -->
	<jsp:include page="./circle-header.jsp"></jsp:include>	
	
	<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>
	
							<!-- 피드이미지 -->


<%

	List feed = new ArrayList();
	String str[] = null;

	AccountVo real_vo = null;
	String id = null;
	
	real_vo = (AccountVo)session.getAttribute("vo");
    id = real_vo.getId();

		List<FeedVo> feed_list = (List)request.getAttribute("frvo");	
		String keyword = request.getAttribute("keyword").toString();
		
		for(FeedVo f : feed_list){
			
			List rfeed_image = new ArrayList();
			List rfeed_file = new ArrayList();
			
			rfeed_image.add(f.getFeed_no());
			
			str = f.getFeed_file().split("@");
			rfeed_image.add(str[1]);
			rfeed_image.add(f.getFeed_file());
			
			rfeed_image.add(f.getId());
			rfeed_image.add(f.getFeed_content());
			rfeed_image.add(f.getFeed_ptag());
			rfeed_image.add(f.getFeed_hteg());
			rfeed_image.add(f.getFeed_regdate());
			rfeed_image.add(f.getLike_list());
			rfeed_image.add(f.getComment_list());
			
			feed.add(rfeed_image);

		}
		
%>
<script type="text/javascript">
	$(function(){
		$("#circle_header_bg").css("background","#ff7f73");
	})
</script>
		<!-- Main -->
		
			<c:set var = "feed_list2" value = "<%=feed%>"/>
			<c:choose>
				
			<c:when test = "${not empty feed_list2}">
			
			<div id="main">
				<div class="inner">
				
					<div style = "color:lightgray;font-size:30px;font-weight:bold;padding-top:2%;padding-bottom:2%"><p style ="color:#ff7f73;font-weight:bold;float:left">${keyword}</p>(으)로 검색한 결과입니다.</div>
				
					<div class="columns">
					
					<c:forEach items = "<%=feed %>" var = "list">
					<c:set var = "file" value = "${list.get(1)}"/>
					<c:set var = "file_length" value = "${fn:length(file)}"/>
					<c:set var = "file_type" value = "${fn:substring(file, file_length-3 , file_length)}" />
					<c:choose>
					<c:when test = "${file_type ne 'mp4'}">	
						<div id="imgfit">
							
							<!-- modal -->
							<a data-toggle="modal" data-target="#myModal" data-title = "${list.get(0) }">
								<img class="testexplorebox" 
						  		  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), url('<%=request.getContextPath() %>/resources/images/filemanager/feed/${list.get(0)}/${list.get(1)}') no-repeat; background-size: cover; background-position: center center;">
			               	</a>
			               	
		                </div>
		            </c:when>
		            <c:otherwise>
		           		<div id="imgfit">
		           		
		           			<!-- modal -->
							<a data-toggle="modal" data-target="#myModal" data-title = "${list.get(0) }">
								<video class="testexplorebox"
						  		  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), no-repeat; background-size: cover; background-position: center center;" autoplay loop muted>
						  		  		<source src="<%=request.getContextPath() %>/resources/images/filemanager/feed/${list.get(0)}/${list.get(1)}" type="video/mp4"> 
						  		</video>
			               	</a>
			               	
		                </div>		            
		            </c:otherwise>
		            </c:choose>
		            </c:forEach>
		            
		            </div>
				</div>
			</div>
						
			</c:when>
					
					<c:otherwise>
						<div style = "color : #ff7f73;font-weight:bold;text-align : center;font-size : 20px; width : 100%;margin-top:20%">
		            		<br>
		            		검색결과가 존재하지 않습니다.
		            		<br><br><br>
	    
	            		</div>
		            </c:otherwise>
		            
		            </c:choose>


					
			
	 <!-- ==============================================
	 Modal Section
	 =============================================== -->
	 	 
    <div id="myModal" class="modal fade" role="dialog" >
      <div class="modal-dialog">
       <div class="modal-content" style = "width:160%;margin-left:-28%;margin-top:-20%">
        <div class="modal-body" >
		
         <div class="row" style = "float:left;display:block" id = "first">
		
		<!-- --------------------------------------------------------------------------------------------------------------- --> 
		<!-- 이미지 -->
	    <div class="container" style = "width:60%;height:auto;float:left">
	
		    <div class="row" style = "width:150%">
					
			<div class="col-lg-9">
		
		        <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
		         
		          <div class="carousel-inner" role="listbox" id = "modal_image" style = "width:474.9px;height:474.9px;margin-left:3%">
		          
	
				
		            
		          </div>
		          
		          <!-- 앞 -->
		          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
		            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		            <span class="sr-only">Previous</span>
		          </a>
		          
		           <!-- 뒤 -->
		          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
		            <span class="carousel-control-next-icon" aria-hidden="true" style = "margin-left: 50%;"></span>
		            <span class="sr-only">Next</span>
		          </a>
		        </div>
		        
		        <!-- 좋아요 -->
		        <div style = "float:left;width:20%;margin-left:3%;margin-top: -4%;" id = "feed_heart">

			 	</div>
							      
		       </div>
					
			</div>
		
		</div>
		<!-- --------------------------------------------------------------------------------------------------------------- --> 
          
          
          <div class="col-md-4 modal-meta" style = "margin-left:6.6%;padding-left:3%;width:280px">
           <div class="modal-meta-top">
           
           <!-- x -->
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			 <span aria-hidden="true">×</span><span class="sr-only">Close</span>
			</button><!--/ button -->
			
			<!-- 작성자 -->
            <div class="img-poster clearfix" style = "padding-top:10%">
            
             <div>
             	<img id = "feed_p_image" class="img-responsive img-circle" src="" alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'">
             </div>
             <strong><a href="#" id = "feed_id"></a></strong>
             
             <c:set var = "sessionid" value = "<%=id%>"/>
             <c:choose>
				<c:when test = "${not empty sessionid}">
					<div id="following_section" style = "display:inline">
						
					</div>
				</c:when>
			</c:choose>
		     
            </div><!--/ img-poster -->
			 
			<!-- 내용 -->
			<div style = "height:15vh">
            <ul class="img-comment-list" >
             <li>
              <div class="comment-text">
               <p style = "font-size : 8px;color:#ff7f73" id = "feed_ptag"></p>
               <p style = "font-size : 8px;color:#ff7f73" id = "feed_htag"></p>
               <p id = "feed_content"></p> 
               <span class="date sub-text" id = "feed_regdate"></span>
              </div>
             </li><!--/ li -->
            </ul><!--/ comment-list -->
            </div>
            
            <hr>
            
            <!-- 댓글 -->
            <div style = "height:32vh" >
         	   <ul class="img-comment-list2" id = "feed_comment">
         	   
         	   	
         	   
               </ul>
            </div>
			  
            <div class="modal-meta-bottom">
			 <ul>
			  
			  <!-- 댓글쓰기 -->
			  <li>
			   <div class="comment-body" style = "width:105%;margin-top:10%">
				 <input class="form-control input-sm" type="text" placeholder="Write your comment..." style = "float:left" name = "comment" id = "comment">
				 <div style = "float:left;margin-left:2%;margin-top:8%">
				 	<a class="modal-comment" href="javascript:void(0)" name = "insertcomment" id = "insertcomment"><i class="fa fa-comments" style = "float:left"></i></a>
				 </div>
				 
			   </div><!--/ comment-body -->	
              </li>		
             </ul>				
            </div><!--/ modal-meta-bottom -->
			  
           </div><!--/ modal-meta-top -->
          </div><!--/ col-md-4 -->
          <!-- --------------------------------------------------------------------------------------------------------------- --> 
		  
         </div><!--/ row -->
      <!-- -------------------팔로워 ---------------------------------------------------------------------------------------- -->   
      <div class="container" style = "display:none;" id = "second">
	  
	   <div class="row">
		<div class="col-lg-12" style="background: #fff;">
			<div class="frnds">
				<!-- <ul class="frnds-nav frnds-nav-tabs">
					 <li class="frnds-nav-item"><a id="FollowersTab" class="active" href="#frends" data-toggle="tab"><b>My Friends</b></a> <span> 55</span></li>
					 <li class="frnds-nav-item"><a id="FollowingTab" class="" href="#frends-req" data-toggle="tab"><b>Friend Requests</b></a><span> 60</span></li>
				</ul> -->
				<!-- Tab panes -->
				<div>
				<h2 style = "color:lightgray;font-weight:bold;text-align:center;margin-top:4%"> LIKE LIST </h2>
				<button type="button" class="close" aria-hidden="true" id = "go_detail" style = "margin-top:-10%">
					 <span aria-hidden="true">×</span><span class="sr-only">Close</span>
				  </button><!--/ button -->
				 </div>
				<div class="tab-content">
				  <div class="tab-pane active frnds-fade frnds-show" id="frends">
					
					<ul class="nearby-contct" id = "feed_like">

					
					</ul>
				
					
				  
				</div>
			</div>
		</div>

	   </div><!--/ row -->
	   	</div>
	  </div><!--/ container -->
	  <!-- -------------------팔로워 ---------------------------------------------------------------------------------------- --> 
        </div><!--/ modal-body -->
		
       </div><!--/ modal-content -->
      </div><!--/ modal-dialog -->
     </div><!--/ modal -->
     

		<!-- Footer -->
			<footer id="footer">
					<a id="footerOn" href="#" class="info fa fa-info-circle"><span>About</span></a>
					<div class="inner">
						<div class="content">
							<h3>PROJECT BANDA</h3>
							<p>현재 국내 1인가구 5가구중 한 가구는 반려동물을 키우는 만큼 반려동물은 우리 삶에 밀접하게 자리했다.
				반려동물관련 물건이나 보험등 사람들은 반려동물에게 아낌없이 투자하고 있고, 주인들은 세상에서 하나 뿐인 내 반려동물들을 자랑하고 보여주고 싶은 욕구를 항상 느끼고 있다.
				이 프로젝트로 하여금 주인이 반려동물에게 쏟는 시간이 더 많아질 것이고 상호간의 유대감 증가와 추억을 만들 수 있는 인터넷 상의 공간을 마련한다.</p>
						</div>
						<div class="copyright">
							<h3>PEOPLE</h3>
							<ul class="icons">
								<li><a href="#" class="icon"><span class="">PM 김성일</span></a></li>
								<br>
								<li><a href="#" class="icon"><span class="">김재익</span></a></li>
								<li><a href="#" class="icon"><span class="">정유진</span></a></li>
								<li><a href="#" class="icon"><span class="">정재호</span></a></li>
								<li><a href="#" class="icon"><span class="">주희진</span></a></li>
								<li><a href="#" class="icon"><span class="">최주예</span></a></li>
								<li><a href="#" class="icon"><span class="">하나경</span></a></li>
							</ul>
							&copy; PROJECT BANDA. Design: <a href="#">TEMPLATED</a>. Images: <a href="#">Unsplash,</a> <a href="#">Instagram</a>.
						</div>
					</div>
			</footer>

			<!-- Scripts -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
			<script src="<%=request.getContextPath() %>/resources/assets/js/jquery.min.js"></script>
			<script src="<%=request.getContextPath() %>/resources/assets/js/skel.min.js"></script>
			<script src="<%=request.getContextPath() %>/resources/assets/js/util.js"></script>
			<script src="<%=request.getContextPath() %>/resources/assets/js/main.js"></script>
			<script src="<%=request.getContextPath() %>/resources/assets/jquery/jquery.min.js"></script>
  			<script src="<%=request.getContextPath() %>/resources/assets/js/bootstrap.bundle.min.js"></script>

		<!-- Auto Script -->
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	

  			<script src="<%=request.getContextPath() %>/resources/temp/assets/js/follwer.js"></script>
			<script src="<%=request.getContextPath() %>/resources/assets/js/modal.js"></script>
		 <script>	
		 $(function(){
				$("#searchinput").autocomplete({
						appendTo: "#autoArea",
					    source: function(request, response){
					    	var searchtype=$("input[name='jh_searchtype']:checked").val();
					    	
					    	if(searchtype == null || searchtype == ""){
					    		alert("검색 카테고리를 선택해주세요.");
					    		$("#searchform #searchinput").val("");
					    		return;
					    	}
					    	
					       $.ajax({
					          type:"post",
					          url:"circleheader_autosearch.do",
					          data:{keyword:request.term, searchtype:searchtype},
					          dataType:"json",
					          success: function(result){
					             if(result.success==true){
					                response(
					                   $.map(result.list, function(item){
					                      return{
					                         label:item,
					                         value:item
					                      }
					                   })
					                )
					             }
					          },
					          error: function(){
					             alert("ajax 서버와 통신 실패");
					          }
					          
					       })
					    },
					    minLength:1,
					    select:function(event, ui){
					    
					    }
					 });
				    
				 });
		
		$(document).ready(function(){ 	
			
			var feed_no = null;
			var id = null;
			var file = null;
			var content = null;
			var ptag = null;
			var htag = null;
			var regdate = null;
			var feedno = null;
			var comment_list = [];
			var session_id = '<%=id%>';
		
			$('#myModal').on('show.bs.modal', function(e){
				
	  			var like_list = [];
	  			comment_list = [];
	  			
				
				$('#modal_image * ').remove();
				$('#feed_comment * ').remove();
				$('#feed_like * ').remove();
				$('#feed_heart * ').remove();
				$('#following_section * ').remove();
				
			 var button = $(e.relatedTarget);
			 feedno = button.data('title');
			 var modal = $(this);
			 
			 
			 var feed_set = {
					
				'name' : 'name',
				'feedno' : feedno
					 
			 };
			  				 
		$.ajax({
			
			url : 'each_feed.do',
			type : 'post',
			data : JSON.stringify(feed_set),
				contentType: "application/json",
				dataType:"json",
				success : function(data){
					
					if(data.chk){
						var arr = data.feed;
						
						feed_no = arr['feed_no'];
						file = arr['feed_file'];
						id = arr['id'];
						content = arr['feed_content'];
						ptag = arr['feed_ptag'];
						htag = arr['feed_hteg'];
						regdate = new Date(arr['feed_regdate']);
						
						var chregdate = getFormatDate(regdate);
						
						console.log(feed_no);
						
//						var l = arr['like_list'];
//						
//						if(l == null){
//							
//							like_list = null;
//							
//						} else {
//							for(var i = 0; i<arr['like_list'].length; i++){
//								like_list[i] = l[i];
//							}
//						}
						
					
						var c = arr['comment_list'];
						
						
						for(var i = 0; i<c.length; i++){
							comment_list[i] = c[i];
						}
						
						//내용들 넣기
						$('#feed_id').html(id);
						$('#feed_content').html(content);
						$('#feed_htag').html(htag);
						$('#feed_ptag').html(ptag);
						$('#feed_regdate').html(chregdate);
						$('#feed_follow').html(like_list.length);
						console.log('<%=request.getContextPath() %>/resources/images/filemanager/account/'+ id.trim() +'/profile.jpg');
						document.getElementById('feed_p_image').src = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+ id +'/profile.jpg';
						
						//피드 번호 넣기
						$('#delfeed_no').text(feed_no);						
						
						//이미지 동영상 넣기
						var file_list = file.split('@');
						
						var str = "";
						
						for(var i = 1; i <file_list.length;i++){
							
							
							var ext = null;
							
							 if(i == 1){
								
								ext = file_list[1].substr(file_list[1].length-3,3);
								
								if(ext != 'mp4'){
								
	  							var url = "url('<%=request.getContextPath() %>/resources/images/filemanager/feed/" + feedno + "/" + file_list[1] + "')";
	  							var url_real = '<div class = "carousel-item active" ><img class="d-block img-fluid"  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), ' +url + ' no-repeat; background-size: cover; background-position: center center;width:474.9px;height:474.9px;"> <br></div>';
	  							str += url_real;
	  							
								} else {
									
									var url = "<%=request.getContextPath() %>/resources/images/filemanager/feed/" + feedno + "/" + file_list[1];
									var url_real = '<div class = "carousel-item active" ><video class="d-block img-fluid"  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), no-repeat; background-size: cover; background-position: center center;width:474.9px;height:474.9px;" autoplay loop muted><source src="'+url+'" type="video/mp4">  </video><br></div>';
	  							str += url_real;

								}
							} else {
							ext = file_list[i].substr(file_list[i].length-3,3);
								
								if(ext != 'mp4'){
									var url = "url('<%=request.getContextPath() %>/resources/images/filemanager/feed/" + feedno + "/" + file_list[i] + "')";
	  							var url_real = '<div class = "carousel-item" ><img class="d-block img-fluid"  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), ' +url + ' no-repeat; background-size: cover; background-position: center center;width:474.9px;height:474.9px;"> <br></div>';
	  							str += url_real;  	
								} else {
									
									var url = "<%=request.getContextPath() %>/resources/images/filemanager/feed/" + feedno + "/" + file_list[i];
									var url_real = '<div class = "carousel-item" ><video class="d-block img-fluid"  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), no-repeat; background-size: cover; background-position: center center;width:474.9px;height:474.9px;" autoplay loop muted><source src="'+url+'" type="video/mp4">  </video><br></div>';
	  							str += url_real;

								}
							}
						}
						
						
						$('#modal_image').append(str);
						
						var str2 = "";
						
						//댓글 넣기
							
						if(comment_list.length == 0){
							var url = '<ul class="img-comment-list2"><li><div class="comment-img" style = "font-size:8px;color:gray;margin-top:5%;margin-left:45%">댓글없음</div></li></ul>'
							str2 += url;
						} else {
							
							for(var i =0; i<comment_list.length;i++){
								
								var list = comment_list[i];
								
								if(session_id == 'ADMIN' || session_id == list['id']){
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div>'+
									'<div class="comment-text" style = "display:block" name = "before_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<p>'+list['com_content']+'</p>'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
											'<a href = "javascript:void(0)" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
											'</div>'+
											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
											'</div>'+
											'</li>';
								console.log(real_url);  									
								} else {
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span></div></li>';
									console.log(real_url);
								}
							
										
								str2 += real_url;
							}
							
						}
						
						$('#feed_comment').append(str2);
						
						/////////////////
						//하트여부  							
							var l = new Array();
							l = arr['like_list'];
							
							var str4 = '';
							var real_url = '<a class="modal-like" href="#"  name = "heart_before'+feedno+'" style = "display:block" onclick = "changeheart_b()"><i class="far fa-heart" style = "float:left;padding-top:6%;color:#ff7f73"></i></a>'+
							'<a href = "#" style = "color:#ff7f73;margin-left:3%" id = "feed_follow" onclick = "look_like()"></a>';
							
							
						if(l == null){
								
								like_list = null;
								
							} else {
								

								for(var i =0; i<l.length; i++){
	  							
									var list2 = l[i];
									like_list[i] = l[i];
	  								  	  								
	  								var idid = list2['id'];

		  							if(idid == session_id){

										real_url = '<a class="modal-like" href="#"  name = "heart_after'+feedno+'"  style = "display:block" onclick = "changeheart_a()"><i class="fa fa-heart" style = "float:left;padding-top:6%;color:#ff7f73;display:block"></i></a>' + 
										'<a href = "#" style = "color:#ff7f73;margin-left:3%" id = "feed_follow" onclick = "look_like()"></a>';

									} 
		  						}
							}
							

							str4 += real_url;
							console.log(str4 + "str"); 							
							$('#feed_heart').append(str4);
							console.log(like_list.length);
							$('#feed_follow').html(like_list.length);
						/////////////////
						
						//팔로우 여부
						var fstr = "";
						
						var following_set_yn = {
								'fr_id' : session_id,
								'fd_id' : id
						};
						
						
						$.ajax({
							
							url : 'follow_list_yn.do',
							type : 'post',
							data : JSON.stringify(following_set_yn),
							contentType: "application/json",
							dataType:"json",
							success : function(data){
								
								if(data.chk){
									var fstr = '<a onclick = "unfollowing()" id = "unfollowing"><i class="fa fa-check-square" style = "color:#ff7f73;cursor:pointer"></i></a>';
									$('#following_section').append(fstr);
									
								} else {
									
									if(session_id == id){
										var nfstr = '<a><i class="fas fa-user-alt" style = "color:#ff7f73;"></i></a>';
									} else{
									
										var nfstr = '<a onclick = "following()" id = "following"><i class="fa fa-check-square" style = "cursor:pointer"></i></a>';
									}
									
									$('#following_section').append(nfstr);
								}
								
							},
							error:function(request,status,error){
		  						
		  						alert("통신실패");
		  						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

		  					}						
							
						});
						
						//팔로우 목록
						var str3 = "";
						
						if(like_list.length == 0){
							var url = '<li style = "border:none"><div class="nearly-pepls"><div class="pepl-info"><h4 style = "margin-left:30%;font-weight:bold;color:rgb(5,203,149);">아직까지 좋아요한 반다가 없습니다.</h4></div></div></li>';
							str3 += url
						} else {
							
							for(var i =0; i<like_list.length;i++){
								var list = like_list[i];
								var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
								var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";	
								var url = '<li style = "border:none;border-bottom:1px solid lightgray"><div class="nearly-pepls"><figure><img style = "width:50px;height:50px"src="'+img_url+'" alt="" onerror="this.src ='+onerr+'"></figure><div class="pepl-info"><a href="main_otherfeed.do?id='+list['id']+'" title=""><h4 style = "margin-left:10%;margin-top:-8%;font-weight:bold;color:rgb(5,203,149)">'+list['id']+'</h4></a><a href="main_otherfeed?id="'+list['id']+' class="kafe kafe-btn-mint-small" style = "margin-top:-5%;float:right"><i class="fa fa-check-square"></i> Following</a></div></div></li>';
								str3 += url;
							}
						}
							
						$('#feed_like').append(str3);
						
						
					} else {
						alert('가져오기 실패');
					}
					
				},
			error:function(request,status,error){
					
					alert("통신실패");
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

				}
			
			
		});
			 

		
		});
			
			//unfollowing function : follow -> unfollow
			unfollowing = function(){
				
				var following_set = {
						'fr_id' : session_id,
						'fd_id' : id
					};
				
				$.ajax({
					
					url : 'deatil_follow_delete.do',
  					type : 'post',
					data : JSON.stringify(following_set),
  					contentType: "application/json",
  					dataType:"json",
  					success : function(data){
  						
  						if(data.chk){  							
  							$('#following_section * ').remove();
							var nfstr = '<a onclick = "following()" id = "following"><i class="fa fa-check-square" style = "cursor:pointer"></i></a>';
							$('#following_section').append(nfstr);
							
  						} else {
  							alert('팔로우 삭제실패');
  						}
  						
  					},
					error:function(request,status,error){
  						
  						alert("통신실패");
  						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

  					}
					
					
				});
				
			}
			
			//following function : unfollow -> follow
			following = function(){
				
				var following_set = {
					'fr_id' : session_id,
					'fd_id' : id
				};
				
				$.ajax({
					
					url : 'detail_follow_insert.do',
  					type : 'post',
					data : JSON.stringify(following_set),
  					contentType: "application/json",
  					dataType:"json",
  					success : function(data){
  						
  						if(data.chk){
  							$('#following_section *').remove();
							var nfstr = '<a onclick = "unfollowing()" id = "unfollowing"><i class="fa fa-check-square" style = "color:#ff7f73;cursor:pointer"></i></a>';
							$('#following_section').append(nfstr);
  							
  						} else {
  							alert('팔로우 삽입 실패');
  						}
  						
  					},
					error:function(request,status,error){
  						
  						alert("통신실패");
  						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

  					}
					
				});
				
			}
			
  			//heart : before -> after
  			changeheart_b = function(){

  				if(session_id == 'null'){
  					alert('로그인이 필요합니다.');
  				}
  				else {
	  				
	  				var insert_like = {
	  					'feed_no' : feedno,
	  					'id' : session_id
	  				};
	  				
	  				$.ajax({
	  					
	  					url : 'feed_like_insert.do',
	  					type : 'post',
						data : JSON.stringify(insert_like),
	  					contentType: "application/json",
	  					dataType:"json",
	  					success : function(data){
	  						
	  						if(data.chk){
	  							
	  							//second 넣기
	  							$('#feed_like *').remove();

	  							like_list = data['like_list'];
	  							
	  							var str3 = "";
	  							
	  							if(like_list.length == 0){
	  								var url = '<li style = "border:none"><div class="nearly-pepls"><div class="pepl-info"><h4 style = "margin-left:30%;font-weight:bold;color:rgb(5,203,149);">아직까지 좋아요한 반다가 없습니다.</h4></div></div></li>';
	  								str3 += url
	  							} else {
	  								
	  								for(var i =0; i<like_list.length;i++){
	  									var list = like_list[i];
		  								var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
		  								var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";	
		  								var url = '<li style = "border:none;border-bottom:1px solid lightgray"><div class="nearly-pepls"><figure><img style = "width:50px;height:50px"src="'+img_url+'" alt="" onerror="this.src ='+onerr+'"></figure><div class="pepl-info"><a href="main_otherfeed.do?id='+list['id']+'" title=""><h4 style = "margin-left:10%;margin-top:-8%;font-weight:bold;color:rgb(5,203,149)">'+list['id']+'</h4></a><a href="main_otherfeed?id="'+list['id']+' class="kafe kafe-btn-mint-small" style = "margin-top:-5%;float:right"><i class="fa fa-check-square"></i> Following</a></div></div></li>';
		  								str3 += url;
	  								}
	  							}
	  								
	  							$('#feed_like').append(str3);
	  							
	  							//하트, 숫자
	  							var str = '<a class="modal-like" href="#"  name = "heart_after'+feedno+'"  style = "display:block" onclick = "changeheart_a()"><i class="fa fa-heart" style = "float:left;padding-top:6%;color:rgb(5,203,149);display:block"></i></a>' + 
	  							'<a href = "#" style = "color:rgb(5,203,149);margin-left:3%" id = "feed_follow" onclick = "look_like()"></a>';
	  						
		  						$('#feed_heart * ').remove();
		  		  				$('#feed_heart').append(str);
		  		  				$('#feed_follow * ').remove();
		  		  				$('#feed_follow').html(like_list.length);
	  							
	  						} else {
	  							alert('좋아요 삽입 실패');
	  						}
	  						
	  					},
	  					error:function(request,status,error){
  						
  						alert("통신실패");
  						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

  						}
  					
	  				
	  				});
	  				
	  				
  				}
  			}
  			
  			//heart : after -> before
  			changeheart_a = function(){
  				
  					var delete_like = {
	  					'feed_no' : feedno,
	  					'id' : session_id
	  				};
 	
					$.ajax({
	  					
	  					url : 'feed_like_delete.do',
	  					type : 'post',
						data : JSON.stringify(delete_like),
	  					contentType: "application/json",
	  					dataType:"json",
	  					success : function(data){
	  						
	  						if(data.chk){
	  							
	  							//second 넣기
	  							$('#feed_like *').remove();
	  							
	  							like_list = data['like_list'];
	  							
	  							var str3 = "";
	  							
	  							if(like_list.length == 0){
	  								var url = '<li style = "border:none"><div class="nearly-pepls"><div class="pepl-info"><h4 style = "margin-left:30%;font-weight:bold;color:rgb(5,203,149);">아직까지 좋아요한 반다가 없습니다.</h4></div></div></li>';
	  								str3 += url
	  							} else {
	  								
	  								for(var i =0; i<like_list.length;i++){
	  									var list = like_list[i];
		  								var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
		  								var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";	
		  								var url = '<li style = "border:none;border-bottom:1px solid lightgray"><div class="nearly-pepls"><figure><img style = "width:50px;height:50px"src="'+img_url+'" alt="" onerror="this.src ='+onerr+'"></figure><div class="pepl-info"><a href="main_otherfeed.do?id='+list['id']+'" title=""><h4 style = "margin-left:10%;margin-top:-8%;font-weight:bold;color:rgb(5,203,149)">'+list['id']+'</h4></a><a href="main_otherfeed?id="'+list['id']+' class="kafe kafe-btn-mint-small" style = "margin-top:-5%;float:right"><i class="fa fa-check-square"></i> Following</a></div></div></li>';
		  								str3 += url;
	  								}
	  							}
	  								
	  							$('#feed_like').append(str3);
	  							
	  							//하트, 숫자
	  							var str = '<a class="modal-like" href="#"  name = "heart_after'+feedno+'"  style = "display:block" onclick = "changeheart_b()"><i class="far fa-heart" style = "float:left;padding-top:6%;color:rgb(5,203,149);display:block"></i></a>' + 
								'<a href = "#" style = "color:rgb(5,203,149);margin-left:3%" id = "feed_follow" onclick = "look_like()"></a>';
				
		  						$('#feed_heart * ').remove();
		  		  				$('#feed_heart').append(str);
		  		  				$('#feed_follow * ').remove();
		  		  				$('#feed_follow').html(like_list.length);
	  							
	  						} else {
	  							alert('좋아요 삽입 실패');
	  						}
	  						
	  					},
	  					error:function(request,status,error){
  						
  						alert("통신실패");
  						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

  						}
  					
	  				
	  				});
  				
  			}
			
		//작성자피드이동
		$("#feed_id").on('click',function(){
			
			location.href = 'main_otherfeed.do?id='+id;
			
		});
		
		//팔로우 보이기
		$('#feed_follow').on('click', function(){
			
			$('#first').hide();
			$('#second').show();
			
		});
		
		//모달로 전달
		$('#go_detail').on('click',function(){
			
			$('#first').show();
			$('#second').hide();
			
		});
		
		//댓글 삽입
		$("#insertcomment").on('click', function(){
			
		
			if(session_id == 'null'){
				
				alert('로그인이 필요합니다.');
				location.href = 'index.jsp';
				
			} else {
				  					
				var new_comment = $('#comment').val();
				var category = 'F';
				
				var comment_set = {
						
					'com_content' : new_comment,	
					'id' : session_id,
					'com_pno' : feedno,
					'com_cate' : category
						
				};
				
				$.ajax({
					
					url : 'main_insert_comment.do',
					type : 'post',
				data : JSON.stringify(comment_set),
					contentType: "application/json",
					dataType:"json",
					success : function(data){
						
						if(data.chk){
							
							comment_list = data['comment_list'];
							console.log(comment_list);	

							var str2 = '';
								
						for(var i =0; i<comment_list.length;i++){
								
								var list = comment_list[i];
								
								if(session_id == 'ADMIN' || session_id == list['id']){
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div>'+
									'<div class="comment-text" style = "display:block" name = "before_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<p>'+list['com_content']+'</p>'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
											'<a href = "javascript:void(0)" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
											'</div>'+
											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
											'</div>'+
											'</li>';
							
								} else {
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span></div></li>';
								}
							
										
								str2 += real_url;
							}
								
								$('#feed_comment * ').remove();
								$('#feed_comment').append(str2);
							
						} else {
							
							alert('삽입 실패');
							
						}
					},
					error:function(request,status,error){
						
						alert("통신실패");
						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

					}
					
					
					
				});
				
				$('#comment').val('');
			}
		});
		
		//댓글 삭제
		delete_comment = function(comment_no, feed_no){
			
			var delete_set = {
			  					
				'com_no' : comment_no,
				'com_pno' : feed_no
			};
			
			$.ajax({
				
				url : 'main_delete_comment.do',
				type : 'post',
			data : JSON.stringify(delete_set),
				contentType: "application/json",
				dataType:"json",
				success : function(data){
					
					if(data.chk){
						console.log(data.comment_list);
						
						comment_list = data.comment_list;
						
						var str2 = '';
						
						if(comment_list.length == 0){
							
							var url = '<ul class="img-comment-list2"><li><div class="comment-img" style = "font-size:8px;color:gray;margin-top:5%;margin-left:45%">댓글없음</div></li></ul>'
							str2 += url;
							
						} else {
						
						for(var i =0; i<comment_list.length;i++){
								
								var list = comment_list[i];
								
								if(session_id == 'ADMIN' || session_id == list['id']){
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div>'+
									'<div class="comment-text" style = "display:block" name = "before_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<p>'+list['com_content']+'</p>'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
											'<a href = "javascript:void(0)" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
											'</div>'+
											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
											'</div>'+
											'</li>';
								console.log(real_url);  									
								} else {
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span></div></li>';
									console.log(real_url);
								}
							
										
								str2 += real_url;
							}
						}
						
						$('#feed_comment * ').remove();
						$('#feed_comment').append(str2);
						
					} else {
						alert('삭제실패');
					}
					
				},
				error:function(request,status,error){
					
					alert("통신실패");
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

				}
				
				
				
				
			});
			
			
			
		}
		
		//댓글 수정
		update_comment = function(i){

			$('div[name=before_update'+i+']').hide();
			$('div[name=after_update'+i+']').show();
			
		}
		
		//댓글 수정 완료
		updateres_comment = function(comment_no, feed_no, i){
			
			var comment_content = $('input[name=change_content'+i+']').val();
			
			var update_set = {
				'com_no' : comment_no,
				'com_pno' : feed_no,
				'com_content' : comment_content	
			};
			
			$.ajax({
				
				url : 'main_update_comment.do',
				type : 'post',
			data : JSON.stringify(update_set),
				contentType: "application/json",
				dataType:"json",
				success : function(data){
					if(data.chk){
						
					comment_list = data.comment_list;
						
						var str2 = '';
			
						
						for(var i =0; i<comment_list.length;i++){
								
								var list = comment_list[i];
								
								if(session_id == 'ADMIN' || session_id == list['id']){
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div>'+
									'<div class="comment-text" style = "display:block" name = "before_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<p>'+list['com_content']+'</p>'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
											'<a href = "javascript:void(0)" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
											'</div>'+
											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
											'<span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span>&nbsp;<a href = "javascript:void(0)" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
											'</div>'+
											'</li>';
								console.log(real_url);  									
								} else {
									var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+getFormatDate(new Date(list['com_regdate']))+'</span></div></li>';
									console.log(real_url);
								}
							
										
								str2 += real_url;
							}
						
						
						$('#feed_comment * ').remove();
						$('#feed_comment').append(str2);
						
					} else {
						alert('갱신실패');
					}
				},
			error:function(request,status,error){
					
					alert("통신실패");
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

				}
				
			});
			
			
		}
		
		
		
		
		});
		
		</script>
		
		<script type="text/javascript">
		
		function getFormatDate(date){
		    var year = date.getFullYear();              //yyyy
		    var month = (1 + date.getMonth());          //M
		    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		    var day = date.getDate();                   //d
		    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
		    return  year + '-' + month + '-' + day;
		}
		
		
		</script>

	</body>
</html>