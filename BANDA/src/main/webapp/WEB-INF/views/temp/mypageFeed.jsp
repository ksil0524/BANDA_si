<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import = "com.mvc.banda.model.vo.AccountVo" %>
<%@ page import = "com.mvc.banda.model.vo.FeedVo" %>
<%@ page import = "java.util.*" %>
<%@ page session = "true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>

     <!-- ==============================================
	 Scripts
	 =============================================== -->
	 <!-- jquery.min.js -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/follwer.js"></script>



		

<link href="<%=request.getContextPath() %>/resources/assets/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/resources/temp/assets/css/custom-boardwrite.css" rel="stylesheet" />

<style type="text/css">
	@font-face { font-family: 'BMHANNAAir'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.0/BMHANNAAir.woff') format('woff'); font-weight: normal; font-style: normal; }
</style>

<style type="text/css">
	
		::-webkit-scrollbar {

		display:none;

		} 

</style>

<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>

</head>
<body style = "-ms-overflow-style: none;">
<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>


<form id="delete_feed" action="mypage_deletefeed.do" method="post">
	<input type="hidden" name="deletefeed_no" id="deletefeed_no" value="">
</form>

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
	   <a class="nav-icon" href="mypage_followpage.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>F / F</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	   <a class="nav-icon" href="mypage_allselect.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의 반려동물</span>
	   </a>
	   </div>
	   
	   <div class="p-2 nav-icon-lg mint-green" style="height: 59px;">
	   <a class="nav-icon" href="mypageFeed.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의피드</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg dark-black" style="height: 59px;">
	   <a class="nav-icon" href="mypage_accountpage.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
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
	   	<img alt="feedbg" src="<%=request.getContextPath()%>/resources/images/bg/feed_bg.png" width="100%">
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
		     <img class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=id %>/image.jpg" 
		     											   alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'" onclick="location.href='mypage_accountpage.do'">

		    </div><!-- /author -->
		   </div><!-- /.post-content -->		
		</div><!-- /col-sm-12 -->
		
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  
	 <!-- ==============================================
	 	글올리기
	 =============================================== --> 
	 <script type="text/javascript">
	 	var pettaglist = new Array;
	 	var hashtaglist = new Array;
	 	
	 	function pettaginsert(val){
	 		var spantag = $("<span>").addClass("tag").html(":"+val+"<a onclick='deletepetspan(this)'>x</a>");
	 		$("#pettags").append(spantag);
	 		$("#pettaginp").val("");
	 		pettaglist.push(val);
	 		
	 	}
	 	
	 	function hashtaginsert(val){
	 		var spantag = $("<span>").addClass("tag").html("#"+val+"<a onclick='deletehashspan(this)'>x</a>");
	 		$("#hashtags").append(spantag);
	 		$("#hashtaginp").val("");
	 		hashtaglist.push(val);
	 	}
	 	
	 	function deletepetspan(atag){
	 		
	 		var pa = atag.parentNode;
	 		var patext = pa.innerText;
	 		var patextck = patext.substr(1,patext.length-2);
	 		console.log(patextck);

	 		for(var i=0 ; i<pettaglist.length ; i++){
	 			if(pettaglist[i] == patextck){
	 				pettaglist.splice(i,1);
	 			}
	 		}	 		
	 		atag.remove();
	 		pa.remove();
	 	}
	 	
	 	function deletehashspan(atag){
	 		var pa = atag.parentNode;
	 		var patext = pa.innerText;
	 		var patextck = patext.substr(1,patext.length-2);
	 		console.log(patextck);
	 		
	 		
	 		for(var i=0 ; i<hashtaglist.length ; i++){
	 			if(hashtaglist[i] == patextck){
	 				hashtaglist.splice(i,1);
	 			}
	 		}	
	 		atag.remove();
	 		pa.remove();	 	
	 	}
	 	
	 	function insertfeed(){
	 		
	 		$("#ptaglist").val(pettaglist);
	 		$("#hteglist").val(hashtaglist);
	 		
			var insert_confirm = confirm("새로운 피드를 생성하시겠습니까?");
			
			if(insert_confirm){
				$("#insertfeedform").submit();			
			}
	 		
	 	}
	 	
	 	
	 	
	 	
	 
	 </script>
	 
	 
	 <section class="details">
	  <div class="container">
	   
	   <div class="row">
	    <div class="col-lg-12">  
		
	     <div class="box">
		  <form:form action="mypage_insertfeed.do" method="post"  modelAttribute="feedVo" enctype="multipart/form-data" id="insertfeedform" >
		  <input type="hidden" id="feedid" name="id" value="<%=vo.getId() %>">
		  <table>
		  	<tr>
		  		<td colspan="2">
		  			<textarea name="feed_content" class="form-control no-border" rows="3" placeholder="내용을 입력해주세요..." ></textarea>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td class="tags-input-wrapper" id="pettags" width="30%;">
		   			<input id="pettaginp" type="text" class="form-control no-border" placeholder="태그할 반려동물을 입력해주세요..." style="width: 100%; margin-bottom: 3%;" onKeypress="javascript:if(event.keyCode==13) {pettaginsert(this.value)}"/>
		  			<input type="hidden" id="ptaglist" name="ptaglist" value="">
		  		</td>
		  		<td class="tags-input-wrapper" id="hashtags" width="70%;">
		   			<input id="hashtaginp" type="text" class="form-control no-border" placeholder="해시태그를 입력해주세요..." style="width: 100%; margin-bottom: 3%;" onKeypress="javascript:if(event.keyCode==13) {hashtaginsert(this.value)}"/>
		  			<input type="hidden" id="hteglist" name="hteglist" value="">
		  		</td>
		  	</tr>
		  </table>
		  <div class="box-footer clearfix">
		   <input type="button" class="kafe-btn kafe-btn-mint-small pull-right btn-sm" onclick="insertfeed()" value="Upload">
		   <ul class="nav nav-pills nav-sm" id="filetagpa">
		   	<li id="li1" style="display: none"><p class="kafe-btn kafe-btn-mint-small pull-right btn-sm" style="margin-top:10px; margin-bottom:5px; margin-left:5px; width: 15px; height: 15px;"></p></li>
		   	<li id="li2" style="display: none"><p class="kafe-btn kafe-btn-mint-small pull-right btn-sm" style="margin-top:10px; margin-bottom:5px; margin-left:5px; width: 15px; height: 15px;"></p></li>
		   	<li id="li3" style="display: none"><p class="kafe-btn kafe-btn-mint-small pull-right btn-sm" style="margin-top:10px; margin-bottom:5px; margin-left:5px; width: 15px; height: 15px;"></p></li>
		   	<li id="li4" style="display: none"><p class="kafe-btn kafe-btn-mint-small pull-right btn-sm" style="margin-top:10px; margin-bottom:5px; margin-left:5px; width: 15px; height: 15px;"></p></li>
		   	<li id="li5" style="display: none"><p class="kafe-btn kafe-btn-mint-small pull-right btn-sm" style="margin-top:10px; margin-bottom:5px; margin-left:5px; width: 15px; height: 15px;"></p></li>
		   </ul>
		   <ul class="nav nav-pills nav-sm">
			<li class="nav-item"><a class="nav-link" href="javascript:void(0);" id="file_select1"><i class="fa fa-camera text-muted"></i></a></li>
			<li class="nav-item"><a class="nav-link" href="javascript:void(0);" id="file_select2"><i class="fa fa-video text-muted"></i></a></li>
			
		   	<input type="file" id="file_1" name="file_1" style="display: none" accept="video/mp4, image/jpeg, image/png">
		   	<input type="file" id="file_2" name="file_2" style="display: none" accept="video/mp4, image/jpeg, image/png">
		   	<input type="file" id="file_3" name="file_3" style="display: none" accept="video/mp4, image/jpeg, image/png">
		   	<input type="file" id="file_4" name="file_4" style="display: none" accept="video/mp4, image/jpeg, image/png">
		   	<input type="file" id="file_5" name="file_5" style="display: none" accept="video/mp4, image/jpeg, image/png">
		   	
		   </ul>
		  </div>
		 </form:form>
		 </div>	
		 
		</div>
	   </div>
	  
	  </div><!--/ container -->
	 </section><!--/ profile -->	
    
    <script type="text/javascript">
    	
    	$(function(){
	
    		var filecount = 1;
    		
    		$("#file_select1").on('click', function(){
    			if(filecount > 5){
    				alert("더 이상 파일을 첨부할 수 없습니다.");
    				return false;
    			}
    			$("#file_"+filecount).click();
    		});
    		$("#file_select2").on('click', function(){
    			if(filecount > 5){
    				alert("더 이상 파일을 첨부할 수 없습니다.");
    				return false;
    			}
    			$("#file_"+filecount).click();
    		});
    		
    		
    		$("#file_1").on('change', function(){
    			console.log(this);
    			filecount = filecount+1;
    			$("#li1").css("display","block")
    		});
    		$("#file_2").on('change', function(){
    			console.log(this);
    			filecount = filecount+1;
    			$("#li2").css("display","block")

    		});
    		$("#file_3").on('change', function(){
    			console.log(this);
    			filecount = filecount+1;
    			$("#li3").css("display","block")

    		});
    		$("#file_4").on('change', function(){
    			console.log(this);
    			filecount = filecount+1;
    			$("#li4").css("display","block")

    		});
    		$("#file_5").on('change', function(){
    			console.log(this);
    			filecount = filecount+1;
    			$("#li5").css("display","block")
    		});
    		
    		
    		
    		
    		$('input[type="button"]').keydown(function() {
    			  if (event.keyCode === 13) {
    			    event.preventDefault();
    			  };
    			});

    		
    	});
    	
    	
    	
    	function deletefeed(){
    		
    		var delfeed_no = $("#delfeed_no").text();
    		
    		var delconfirm = confirm("피드를 삭제하시겠습니까?");
    		
    		if(delconfirm){
    			
    			$("#deletefeed_no").val(delfeed_no);
    			$("#delete_feed").submit();
				    			
    		}    		
    		
    		
    	}
    </script>
    
    
    
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
			                  -o-background-size: cover;" autoplay loop muted>
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
	            	<div style = "color : #ff7f73; font-weight:bold;text-align : center;font-size : 20px; width : 100%;">
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
       <div class="modal-content" style = "width:150%;margin-left:-28%;margin-top:-20%">
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
		        <div style = "float:left;width:13%;margin-left:3%;margin-top: -1%;" id = "feed_heart">
			 	
			 	</div>
			 	
			 	 <p class="kafe-btn kafe-btn-mint-small pull-right btn-sm" onclick="deletefeed()"
			 	 style="margin-top:2.5px; width: 15px; height: 15px; background-color: #ff4343; padding: 1px;font-size: 3px;">X</p>
			 	 <p id="delfeed_no" style="display: none;"></p>
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
            
             <div>
             	<img id = "feed_p_image" class="img-responsive img-circle" src="" alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'">
             </div>
             <strong><a href="#" id = "feed_id"></a></strong>
               <p class="date sub-text" id = "feed_regdate" style="font-size: 9px; text-align: right; margin: 3px 0 0;"></p>
            </div><!--/ img-poster -->
            
           
          <!-- 내용 -->
			<div style = "height:15vh">
            <ul class="img-comment-list" >
             <li>
              <div class="comment-text" style="width: 200px;">
               <p id = "feed_content"  style="margin-bottom: 10%;"></p> 
               <p style = "font-size : 12px;color:#ff7f73" id = "feed_ptag"></p>
               <p style = "font-size : 12px;color:#ff7f73" id = "feed_htag"></p>
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
				 <input class="form-control input-sm" type="text" placeholder="Write your comment..." style = "float:left; margin-left: 5%; width:82%" name = "comment" id = "comment">
				 <div style = "float:left;margin-left:2%;margin-top:8%">
				 	<a class="modal-comment" href="javascript:void(0)" style = "float:right" name = "insertcomment" id = "insertcomment"><i class="fa fa-comments"></i></a>
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
	HEADER CIRCLE Scripts
	=============================================== -->
	
   
      <script>		
		
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
		
    <!-- ==============================================
	HEADER CIRCLE Scripts
	=============================================== -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/util.js"></script>
	<!-- main 외  페이지 전용 -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/circle-header.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/jquery/jquery.min.js"></script>
  	<script src="<%=request.getContextPath() %>/resources/assets/js/bootstrap.bundle.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   <script src="<%=request.getContextPath() %>/resources/assets/jquery/jquery.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   <!-- index_circle_custom CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">
   
	<!-- Auto Script -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
  </body>
</html>
