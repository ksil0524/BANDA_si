<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import = "com.mvc.banda.model.vo.AccountVo" %>
<%@ page import = "com.mvc.banda.model.vo.FeedVo" %>
<%@ page import = "java.util.*" %>
<%@ page session = "true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<link href="<%=request.getContextPath() %>/resources/assets/css/custom-modal.css" rel="stylesheet" />
<!-- index_circle_custom CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">

<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>


</head>
<body>
<input type = "hidden" id = "hidden_session" value = '<%=session.getAttribute("vo") %>'>

	<!-- ==============================================
	HeaderSection
	=============================================== -->
	<jsp:include page="/WEB-INF/views/circle-header.jsp"></jsp:include>
	
	<!-- ==============================================
	Navbar Second Section
	=============================================== -->
	<section class="nav-sec" style="margin-top: 15px; height: 60px;">
	  <div class="d-flex justify-content-between">
	   <div class="p-2 nav-icon-lg clean-black"style="height: 59px;">
	   <a class="nav-icon" href="mypageFollw.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>F / F</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	   <a class="nav-icon" href="mypagePets.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의 반려동물</span>
	   </a>
	   </div>
	   
	   <div class="p-2 nav-icon-lg mint-green" style="height: 59px;">
	   <a class="nav-icon" href="mypageFeed.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의피드</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg dark-black" style="height: 59px;">
	   <a class="nav-icon" href="mypageAccount.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>내계정</span>
	   </a>
	   </div>
	  </div>
	</section>	
			
  
	 <!-- ==============================================
	 News Feed Section
	 =============================================== --> 
	 
	 <%
	 	
		AccountVo vo = (AccountVo)session.getAttribute("vo");
	 	String id = vo.getId();
	 	
	 	
	 	
	 	List<FeedVo> fvo = (List)request.getAttribute("fvo");

	 	
	 	String str[] = null;
	 	List feed = new ArrayList();
	 
		for(FeedVo f : fvo){
			
			List rfeed_image = new ArrayList();
			List rfeed_file = new ArrayList();
			
			rfeed_image.add(f.getFeed_no());
			
			str = f.getFeed_file().split("@");
			rfeed_image.add(str[1]);
			
			rfeed_image.add(f.getLike_list().size());
			
			feed.add(rfeed_image);
			
		}
	 	
	 	
	 
	 %>
	 
	 <!-- ==============================================
		뒤에배경
	 =============================================== --> 
	 <section class="profile">
	  <div class="container-fluid">
	   <div class="row">
	   
	   <div class="col-lg-3">
		 <div class="profilebox hidden-xs hidden-sm" 
		   style="background: linear-gradient( rgba(34,34,34,0.45), rgba(34,34,34,0.45)), url('<%=request.getContextPath() %>/resources/temp/assets/img/posts/4.jpg') no-repeat;
		          background-size: cover;
                  background-position: center center;
                  -webkit-background-size: cover;
                  -moz-background-size: cover;
                  -o-background-size: cover;">		  
		 </div>
		 <div class="profilebox hidden-xs hidden-sm" 
		   style="background: linear-gradient( rgba(34,34,34,0.45), rgba(34,34,34,0.45)), url('<%=request.getContextPath() %>/resources/temp/assets/img/posts/1.jpg') no-repeat;
		          background-size: cover;
                  background-position: center center;
                  -webkit-background-size: cover;
                  -moz-background-size: cover;
                  -o-background-size: cover;">		  
		 </div>
	   </div>
	   <div class="col-lg-6">
		 <div class="profilebox-large hidden-xs hidden-sm" 
		   style="background: linear-gradient( rgba(34,34,34,0.45), rgba(34,34,34,0.45)), url('<%=request.getContextPath() %>/resources/temp/assets/img/posts/9.jpg') no-repeat;
		          background-size: cover;
                  background-position: center center;
                  -webkit-background-size: cover;
                  -moz-background-size: cover;
                  -o-background-size: cover;">		  
		 </div>
	   </div>
	   <div class="col-lg-3">
		 <div class="profilebox hidden-xs hidden-sm" 
		   style="background: linear-gradient( rgba(34,34,34,0.45), rgba(34,34,34,0.45)), url('<%=request.getContextPath() %>/resources/temp/assets/img/posts/11.jpg') no-repeat;
		          background-size: cover;
                  background-position: center center;
                  -webkit-background-size: cover;
                  -moz-background-size: cover;
                  -o-background-size: cover;">		  
		 </div>
		 <div class="profilebox" 
		   style="background: linear-gradient( rgba(34,34,34,0.6), rgba(34,34,34,0.6)), url('<%=request.getContextPath() %>/resources/temp/assets/img/posts/12.jpg') no-repeat;
		          background-size: cover;
                  background-position: center center;
                  -webkit-background-size: cover;
                  -moz-background-size: cover;
                  -o-background-size: cover;">		  
		 </div>
	   </div>
		
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  
	 <!-- ==============================================
	 	사람사진
	 =============================================== --> 
	 <section class="user-profile">
	  <div class="container-fluid">
	   <div class="row">
	   
	    <div class="col-lg-12">
		   <div class="post-content">
		    <div class="author-post text-center">
		     <a href="#"><img class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/<%=id %>/profile.jpg" 
		     											   alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'"></a>

		    </div><!-- /author -->
		   </div><!-- /.post-content -->		
		</div><!-- /col-sm-12 -->
		
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  
	 <!-- ==============================================
	 	글올리기
	 =============================================== --> 
	 <section class="details">
	  <div class="container">
	   
	   <div class="row">
	    <div class="col-lg-12">  
		
	     <div class="box">
		  <form>
		   <textarea class="form-control no-border" rows="3" placeholder="Type something..."></textarea>
		  </form>
		  <div class="box-footer clearfix">
		   <button class="kafe-btn kafe-btn-mint-small pull-right btn-sm">Upload</button>
		   <ul class="nav nav-pills nav-sm">
			<li class="nav-item"><a class="nav-link" href=""><i class="fa fa-camera text-muted"></i></a></li>
			<li class="nav-item"><a class="nav-link" href=""><i class="fa fa-video text-muted"></i></a></li>
		   </ul>
		  </div>
		 </div>	
		 
		</div>
	   </div>
	  
	  </div><!--/ container -->
	 </section><!--/ profile -->	
    
	 <!-- ==============================================
	  피드부분
	 =============================================== --> 
	 <section class="newsfeed">
	  <div class="container">
	  
	  
	   <div class="row">
	   
	   <c:choose>
	   <c:when test = "${not empty fvo}">
	   
			<c:forEach items="<%=feed %>" var="list">
					<c:set var = "file" value = "${list.get(1)}"/>
					<c:set var = "file_length" value = "${fn:length(file)}"/>
					<c:set var = "file_type" value = "${fn:substring(file, file_length-3 , file_length)}" />
					
					<c:choose>
					<c:when test = "${file_type ne 'mp4'}">	
						<div class="col-lg-4">
						 <a href="#myModal" data-toggle="modal" data-title = "${list.get(0)}">
						 
						 <!-- 사진 -->
						 <div class="explorebox" 
						   style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), url('<%=request.getContextPath() %>/resources/images/filemanager/feed/${list.get(0)}/${list.get(1)}') no-repeat;
						          background-size: cover;
				                  background-position: center center;
				                  -webkit-background-size: cover;
				                  -moz-background-size: cover;
				                  -o-background-size: cover;">
				          
				          <!-- 좋아요수 --> 
						  <div class="explore-top">
						   <div class="explore-like"><i class="fa fa-heart"></i> <span>${list.get(2)}</span></div>
				          </div>	
				          	  
						 </div>
						 </a>
						</div><!--/ col-lg-4 -->
		            </c:when>
		            <c:otherwise>
		            <div class="col-lg-4">
					 <a href="#myModal" data-toggle="modal" data-title = "${list.get(0)}">
					 
					 <!-- 동영상 -->
					 <div>
					 <video class="explorebox" 
					 		style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)),  no-repeat;
					          background-size: cover;
			                  background-position: center center;
			                  -webkit-background-size: cover;
			                  -moz-background-size: cover;
			                  -o-background-size: cover;" autoplay loop>
			               <source src="<%=request.getContextPath() %>/resources/images/filemanager/feed/${list.get(0)}/${list.get(1)}" type="video/mp4">    
			          </video>
			          
			          <!-- 좋아요수 --> 
					  <div class="explore-top" style = "margin-top:-121%;color:black">
						   <div class="explore-like"><i class="fa fa-heart"></i> <span>${list.get(2)}</span></div>
			     	  </div>
			          	  
					 </div>
					 </a>
					</div><!--/ col-lg-4 -->
			            
		            </c:otherwise>
		            </c:choose>
			</c:forEach>
	
		</c:when>
		
		<c:otherwise>
	            	<div style = "color : rgb(5,203,149);font-weight:bold;text-align : center;font-size : 20px; width : 100%;">
	            		<br>
	            		피드가 존재하지 않습니다.
	            		<br><br><br>
	    
	            	</div>
	    </c:otherwise>
		
		</c:choose>
		
	   </div>

	   
	   
	  </div><!--/ container -->
	 </section><!--/ newsfeed -->
  
	 <!-- ==============================================
	 Modal Section
	 =============================================== -->
          <div id="myModal" class="modal fade">
      <div class="modal-dialog">
       <div class="modal-content" style = "width:160%;margin-left:-28%;margin-top:-20%">
        <div class="modal-body">
      
         <div class="row" style = "float:left;display:block" id = "first">
       
          <div class="col-md-8">
           <!-- --------------------------------------------------- -->
		  <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
          
          <div class="carousel-inner" role="listbox" id = "modal_image">
           

          </div>
          
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
          
          <!-- 좋아요 -->
		        <div style = "float:left;width:20%;margin-left:3%;margin-top: -1%;" id = "feed_heart">
			 	 
			 	</div>
			 	
        </div>
	<!-- --------------------------------------------------- -->
          </div><!--/ col-md-8 -->
          
          
          <div class="col-md-4 modal-meta">
           <div class="modal-meta-top">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
          		<span aria-hidden="true">×</span><span class="sr-only">Close</span>
         	</button><!--/ button -->
         	
         	<!-- 작성자 -->
            <div class="img-poster clearfix" style = "padding-top:10%">
            
             <a href="">
             	<img id = "feed_p_image" class="img-responsive img-circle" src="" alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'">
             </a>
             <strong><a href="#" id = "feed_id"></a></strong>
		     <a href="" class="kafe kafe-btn-mint-small"><i class="fa fa-check-square"></i> Following</a>
            </div><!--/ img-poster -->
           
          <!-- 내용 -->
			<div style = "height:15vh">
            <ul class="img-comment-list" >
             <li>
              <div class="comment-text">
               <p style = "font-size : 8px;color:rgb(5,203,149)" id = "feed_ptag"></p>
               <p style = "font-size : 8px;color:rgb(5,203,149)" id = "feed_htag"></p>
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
			   <div class="comment-body" style = "width:115%;margin-top:10%">
				 <input class="form-control input-sm" type="text" placeholder="Write your comment..." style = "float:left" name = "comment" id = "comment">
				 <div style = "float:left;margin-left:2%;margin-top:8%">
				 	<a class="modal-comment" href="#" style = "float:right" name = "insertcomment" id = "insertcomment"><i class="fa fa-comments"></i></a>
				 </div>
			   </div><!--/ comment-body -->	
              </li>
              				
             </ul>				
            </div><!--/ modal-meta-bottom -->
           
           </div><!--/ modal-meta-top -->
          </div><!--/ col-md-4 -->
        
         </div><!--/ row -->
         
                  <!-- -------------------팔로워 ---------------------------------------------------------------------------------------- -->   
      <div style = "display:none;" id = "second">
	  
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
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>	   
	   

     <!-- ==============================================
	 Scripts
	 =============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/follwer.js"></script>


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
	
	<script src="<%=request.getContextPath() %>/resources/assets/jquery/jquery.min.js"></script>
  	<script src="<%=request.getContextPath() %>/resources/assets/js/bootstrap.bundle.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="<%=request.getContextPath() %>/resources/assets/jquery/jquery.min.js"></script>
       <script>
  			
  			
  			$(document).ready(function(){ 	
  				
  				
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
  					
  				 var button = $(e.relatedTarget);
  				 feedno = button.data('title');
  				 var modal = $(this);
  				 
  				 var feed_set = {
  						
  					'name' : 'name',
  					'feedno' : feedno
  						 
  				 };
  				alert(feedno);
  				  				 
				$.ajax({
					
					url : 'each_feed.do',
					type : 'post',
					data : JSON.stringify(feed_set),
  					contentType: "application/json",
  					dataType:"json",
  					success : function(data){
  						
  						if(data.chk){
  							
  							var arr = data.feed;
  							console.log(arr);
  							
  							file = arr['feed_file'];
  							id = arr['id'];
  							content = arr['feed_content'];
  							ptag = arr['feed_ptag'];
  							htag = arr['feed_hteg'];
  							regdate = arr['feed_regdate'];
  							
  							//regdate = getFormatDate(regdate);

  							var c = arr['comment_list'];
  							
  							
  							for(var i = 0; i<c.length; i++){
  								comment_list[i] = c[i];
  							}
  							
  							//내용들 넣기
  							$('#feed_id').html(id);
  							$('#feed_content').html(content);
  							$('#feed_htag').html(htag);
  							$('#feed_ptag').html(ptag);
  							$('#feed_regdate').html(regdate);
  							document.getElementById('feed_p_image').src = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+ id +'/profile.jpg';
  							
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
  										var url_real = '<div class = "carousel-item active" ><video class="d-block img-fluid"  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), no-repeat; background-size: cover; background-position: center center;width:474.9px;height:474.9px;" autoplay loop><source src="'+url+'" type="video/mp4">  </video><br></div>';
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
  										var url_real = '<div class = "carousel-item active" ><video class="d-block img-fluid"  style="background: linear-gradient( rgba(34,34,34,0.2), rgba(34,34,34,0.2)), no-repeat; background-size: cover; background-position: center center;width:474.9px;height:474.9px;" autoplay loop><source src="'+url+'" type="video/mp4">  </video><br></div>';
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
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
	  											'<a href = "#" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
	  											'</div>'+
	  											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
	  											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
	  											'</div>'+
	  											'</li>';
										//console.log(real_url);  									
  									} else {
  										var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
	  									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
	  									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+list['com_regdate']+'</span></div></li>';
	  									//console.log(real_url);
  									}
  								
  											
  									str2 += real_url;
  								}
  								
  							}
  							
  							$('#feed_comment').append(str2);
  							
							//하트여부  							
  							var l = new Array();
  							l = arr['like_list'];
  							
  							var str4 = '';
  							var real_url = '<a class="modal-like" href="#"  name = "heart_before'+feedno+'" style = "display:block" onclick = "changeheart_b()"><i class="far fa-heart" style = "float:left;padding-top:6%;color:rgb(5,203,149)"></i></a>'+
  							'<a href = "#" style = "color:rgb(5,203,149);margin-left:3%" id = "feed_follow" onclick = "look_like()"></a>';
  							
  							
							if(l == null){
  								
  								like_list = null;
  								
  							} else {
  								

  								for(var i =0; i<l.length; i++){
  	  							
  									var list2 = l[i];
  									like_list[i] = l[i];
  	  								  	  								
  	  								var idid = list2['id'];

  		  							if(idid == session_id){
  										
  		  								alert('같음');
  										real_url = '<a class="modal-like" href="#"  name = "heart_after'+feedno+'"  style = "display:block" onclick = "changeheart_a()"><i class="fa fa-heart" style = "float:left;padding-top:6%;color:rgb(5,203,149);display:block"></i></a>' + 
  										'<a href = "#" style = "color:rgb(5,203,149);margin-left:3%" id = "feed_follow" onclick = "look_like()"></a>';
	
  									} 
  		  						}
  							}
  							

  							str4 += real_url;
  							console.log(str4 + "str"); 							
  							$('#feed_heart').append(str4);
  							console.log(like_list.length);
  							$('#feed_follow').html(like_list.length);
  							
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
	  							
	  							alert('좋아요 삽입 성공');
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
	  							
	  							alert('좋아요 삭제 성공');
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
  			look_like = function(){
  				$('#first').hide();
  				$('#second').show();
  			}
  			
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
	  							
	  							alert('삽입성공');
	  							
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
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
	  											'<a href = "#" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
	  											'</div>'+
	  											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
	  											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
	  											'</div>'+
	  											'</li>';
 									
  									} else {
  										var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
	  									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
	  									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+list['com_regdate']+'</span></div></li>';
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
  							alert('삭제성공');
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
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
	  											'<a href = "#" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
	  											'</div>'+
	  											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
	  											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
	  											'</div>'+
	  											'</li>';
										//console.log(real_url);  									
  									} else {
  										var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
	  									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
	  									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+list['com_regdate']+'</span></div></li>';
	  									//console.log(real_url);
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
  				
  				alert(i);
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
  							
  							alert('갱신성공'); 
  							
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
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "update_comment('+i+')" style = "font-size:10px">수정</a>&nbsp;'+
	  											'<a href = "#" onclick = "delete_comment('+list['com_no']+','+list['com_pno']+');" style = "font-size:10px">삭제</a>'+
	  											'</div>'+
	  											'<div class="comment-text" style = "display:none" name = "after_update'+i+'"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong>'+
	  											'<input name = "change_content'+i+'" value = "'+list['com_content']+'" style = "width:80%;font-size:11px;border:none">'+
	  											'<span class="date sub-text">'+list['com_regdate']+'</span>&nbsp;<a href = "#" onclick = "updateres_comment('+list['com_no']+','+list['com_pno']+','+i+')" style = "font-size:10px">수정완료</a>&nbsp;'+
	  											'</div>'+
	  											'</li>';
										//console.log(real_url);  									
  									} else {
  										var img_url = '<%=request.getContextPath() %>/resources/images/filemanager/account/'+list['id']+'/profile.jpg';
	  									var onerr = "'<%=request.getContextPath() %>/resources/images/logo_profile.png'";									
	  									var real_url = '<li><div class="comment-img"><img src="'+img_url+'" class="img-responsive img-circle" alt="Image" onerror="this.src ='+onerr+'"/></div><div class="comment-text"><strong><a href="main_otherfeed.do?id='+list['id']+'">'+list['id']+'</a></strong><p>'+list['com_content']+'</p> <span class="date sub-text">'+list['com_regdate']+'</span></div></li>';
	  									//console.log(real_url);
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
  			
  			getFormatDate = function(date){
  				
  				var year = date.getFullYear();              //yyyy
   		       var month = (1 + date.getMonth());          //M
   		       month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
   		       var day = date.getDate();                   //d
   		       day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
   		       return  year + '-' + month + '-' + day;
  				
  				
  			}
  			

  			
  					
  			
  			});
  			
  			</script>
	   
  </body>
</html>
