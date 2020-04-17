<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mvc.banda.model.vo.AccountVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <!-- ==============================================
	Scripts
	=============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>

<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>
	<!-- ==============================================
	Styles
	=============================================== -->
	<link href="<%=request.getContextPath() %>/resources/temp/assets/css/photo_home(kim).css" rel="stylesheet" />
	<!-- index_circle_custom CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">
	
	<%
		AccountVo accvo = (AccountVo)session.getAttribute("accvo");
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	%>
	
	
			      

	 <script type="text/javascript">
	 	
	 	$(function(){
	 		
	 		
	 		
	 	});
	 </script>
	
	
	
	<!--  
	selectbox 설정 : 불러온 petVo의 species 에 맞게 view_category2 가 변하게 수정하게 하는 script 부분
  -->					  	  
  <script type="text/javascript">
	
  	$(function(){
  		
  		var viewVal = $("#view_category2 option:selected").val();
  		
  		var speciesVal = species_list[viewVal];
  		
  		$("#view_category2 option:selected").text(speciesVal);
  		
  	});
  	
  </script>
  
	
	
</head>
<body>

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
	   <div class="p-2 nav-icon-lg mint-green" style="height: 59px;">
	   <a class="nav-icon" href="mypagePets.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의 반려동물</span>
	   </a>
	   </div>
	   
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
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
	 <section class="newsfeed" style="padding: 100px 0px;">
	  <div class="container-fluid" >
	   <div id="mediaSet" class="row" style="position:absoute; left:50%; transform:translate(12.5%,0%);">
	    <div class="col-lg-3">
		

		 <div class="storybox mypetInsert" 
		   style="background-color: white; background-color: rgba(0, 0, 0, 0.59);">
          <div class="story-body text-center">
           <div class=""><img class="img-circle" src="<%=request.getContextPath() %>/resources/temp/assets/img/icon/mypagePets-plusIcon.jpg" alt="user"></div>
          	<h4 style="color:white;font-family: sans serif;">반려동물 추가</h4>
          </div>		  
		 </div>
		 
		 <c:if test="<%=accvo.getPet_list() != null %>">
		 	<% int i = 0; %>
		 	<c:forEach var="pet" items="<%=accvo.getPet_list() %>">
		 		<div class="storybox mypetListSeq" 
				   style="background: linear-gradient( rgba(34,34,34,0.78), rgba(34,34,34,0.78)), url('<%=request.getContextPath() %>/resources/images/filemanager/pet/pet_gif/<%=++i %>.gif') no-repeat;
				          background-size: cover;
		                  background-position: center center;
		                  -webkit-background-size: cover;
		                  -moz-background-size: cover;
		                  -o-background-size: cover;"
		                  onclick="#" id="storybox${i }">
		          <div class="story-body text-center">
		           <div class=""><img class="img-circle" src="<%=request.getContextPath() %>/resources/temp/assets/img/users/10.jpg" alt="user"></div>
		           <h4>${pet.p_Name }</h4>
		          </div>		  
				</div>
		 	</c:forEach>
		 </c:if>
		 
		 
		</div><!--/ col-lg-3 -->
	    <div class="col-lg-6">
			
			<div id="mypetsInsert" class="cardbox" style="border:1px solid #F4F4F4; background-color: #F4F4F4; box-shadow: 2px 2px 2px 2px lightgray; height: 712px;">
			  <form action="" method="">
			  
			  <div class="row">
			    
			    <div class="col-65">
			      <div class="row">    
			      	<div class="col-35">
			      		<label for="name">NAME</label>
			    	</div>
			   		<div class="col-65">
			      		<input type="text" id="name" name="name" placeholder="이름을 입력하세요..">
			        </div>
			      </div>
			      
			      <div class="row">    
			      	<div class="col-35">
			      		<label for="birth">BIRTH</label>
			    	</div>
			   		<div class="col-65">
			      		<input type="date" id="birth" name="birth" placeholder="이름을 입력하세요..">
			        </div>
			      </div>
			      
			      <div class="row">
			    	<div class="col-35">
			      		<label for="category1">CLASS</label>
			      	</div>
			      	<div class="col-65">
			      	  <select id="category1" name="category1">
			      	  	<option value="0">선택해주세요</option>
			        	<option value="1">포유류</option>
					    <option value="2">조류</option>
					    <option value="3">파충류,양서류</option>
					    <option value="4">어류</option>
					    <option value="5">절지류</option>
					    <option value="6">기타</option>			      	  
					  </select>
			        </div>
			  	  </div>
	
	 
	 			      
			      <div class="row">
			    	<div class="col-35">
			      		<label for="category2">SPECIES</label>
			      	</div>
			      	<div class="col-65">
			      	  <select id="category2" name="category2">
					    <option value="0" selected="selected">대분류를 선택해주세요</option>
			      	  </select>
			        </div>
			  	  </div>
			      
			    </div> <!--/ col-65 -->
			    
				<div class="col-35" style="padding-left: 4px; padding-top: 10px; overflow: hidden; cursor:pointer;">
			      <input type="file" id="imgInp" style="display: none;">
			     <!--  <img id="image_section" src="https://www.w3schools.com/css/img_5terre.jpg" /> -->
			      <img id="image_section" style="width: 90%; height: 90%; border-radius: 70%;" src="<%=request.getContextPath() %>/resources/temp/assets/img/icon/profile_default.jpg" alt="user">
			    </div> <!--/ col-35 -->
			    
			    
			  </div><!--/ row -->
			  </form>
			
			  <div class="row">
			    <div class="col-25">
			      <label for="species">KIND</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="species" name="species" placeholder="종을 입력하세요..">
			    </div>
			  </div> 
			  
			  <div class="row">
			    <div class="col-25">
			      <label for="like">LIKE</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="like" name="like" placeholder="좋아하는 것을 입력하세요..">
			    </div>
			  </div> 
			  
			  <div class="row">
			    <div class="col-25">
			      <label for="hate">HATE</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="hate" name="hate" placeholder="싫어하는 것을 입력하세요..">
			    </div>
			  </div> 
			  
			  <div class="row">
			    <div class="col-25">
			      <label for="introduce">ABOUT</label>
			    </div>
			    <div class="col-75">
			      <textarea id="introduce" name="introduce" placeholder="소개를 입력하세요.." style="height:200px"></textarea>
			    </div>
			  </div>
			</div><!--/ container -->
			
			
<!-- testtest -->			
			<c:if test="<%=accvo.getPet_list() != null %>">
				<c:forEach var="pet" items="<%=accvo.getPet_list() %>">
				
				<div>
					
						<!-- 저장된 프로필 보기 -->
					<div id="mypetsDetail" class="cardbox" style="display:none; border:1px solid #F4F4F4; background-color: #F4F4F4; box-shadow: 2px 2px 2px 2px lightgray; height: 712px;">
					  <form action="" method="">
					  <div class="row">
					    <div class="col-65">
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="name">NAME</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="text" id="name" name="name" value="${pet.p_Name }" disabled="disabled">
					        </div>
					      </div>
					      
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="birth">BIRTH</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="text" id="birth" name="birth" value="<fmt:formatDate value="${pet.p_birth }" pattern="yyyy-MM-dd"/>" disabled="disabled" >
					        </div>
					      </div>
					      
					      <div class="row">
					    	<div class="col-35">
					      		<label for="view_category1">CLASS</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="view_category1" name="view_category1" disabled="disabled">
					      	  
					      	  <c:choose>
					      	  	<c:when test="${pet.class_no == 1 }">
					        		<option value="1" selected="selected">포유류</option>
					      	  	</c:when>
					      	  	<c:when test="${pet.class_no == 2 }">
					        		<option value="1" selected="selected">조류</option>
					      	  	</c:when>
					      	  	<c:when test="${pet.class_no == 3 }">
					        		<option value="1" selected="selected">파충류,양서류</option>
					      	  	</c:when>
					      	  	<c:when test="${pet.class_no == 4 }">
					        		<option value="1" selected="selected">어류</option>
					      	  	</c:when>
					      	  	<c:when test="${pet.class_no == 5 }">
					        		<option value="1" selected="selected">절지류</option>
					      	  	</c:when>
					      	  	<c:when test="${pet.class_no == 6 }">
					        		<option value="1" selected="selected">기타</option>
					      	  	</c:when>
					      	  </c:choose>
					      	  
					      	  </select>
					        </div>
					  	  </div>
					  
					  	  
					      <div class="row">
					    	<div class="col-35">
					      		<label for="view_category2">SPECIES</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="view_category2" name="view_category2" disabled="disabled">
					        	<option value="${pet.species_no }" selected="selected"></option>
					      	  </select>
					        </div>
					  	  </div>
					      
					    </div> <!--/ col-65 -->
					    
						<div class="col-35" style="padding-left: 4px; padding-top: 10px; overflow: hidden; cursor:pointer;">
					     <!--  <img id="image_section" src="https://www.w3schools.com/css/img_5terre.jpg" /> -->
					      <img src="<%=request.getContextPath() %>/resources/images/filemanager/pet/pet_profile/${pet.p_no }/image.jpg" style="width: 90%; height: 90%; border-radius: 70%;">
					    </div> <!--/ col-35 -->
					    
					    
					  </div><!--/ row -->
					  </form>
					
					  <div class="row">
					    <div class="col-25">
					      <label for="species">KIND</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="species" name="species" value="${pet.p_kind }" disabled="disabled">
					    </div>
					  </div> 
					  
					  <div class="row">
					    <div class="col-25">
					      <label for="like">LIKE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="like" name="like" value="${pet.p_like }" disabled="disabled">
					    </div>
					  </div> 
					  
					  <div class="row">
					    <div class="col-25">
					      <label for="hate">HATE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="hate" name="hate" value="${pet.p_hate }" disabled="disabled">
					    </div>
					  </div> 
					  
					  <div class="row">
					    <div class="col-25">
					      <label for="introduce">ABOUT</label>
					    </div>
					    <div class="col-75">
					      <textarea id="introduce" name="introduce" style="height:200px" disabled="disabled">${pet.p_about }</textarea>
					    </div>
					  </div>
					  
					  
					</div><!--/ container -->
					
					
					<!-- 저장된 프로필  수정-->
					<div id="mypetsUpdate" class="cardbox" style="display:none; border:1px solid #F4F4F4; background-color: #F4F4F4; box-shadow: 2px 2px 2px 2px lightgray; height: 712px;">
					  <form action="" method="">
					  <div class="row">
					    <div class="col-65">
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="name">NAME</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="text" id="name" name="name" value="${pet.p_Name }" >
					        </div>
					      </div>
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="birth">BIRTH</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="date" id="birth" name="birth" value="<fmt:formatDate value="${pet.p_birth }" pattern="yyyy-MM-dd"/>">
					        </div>
					      </div>
					      <div class="row">
					    	<div class="col-35">
					      		<label for="update_category1">CLASS</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="update_category1" name="update_category1" >
					      	  	<option value="0">선택해주세요</option>
					        	<option value="1">포유류</option>
							    <option value="2">조류</option>
							    <option value="3">파충류,양서류</option>
							    <option value="4">어류</option>
							    <option value="5">절지류</option>
							    <option value="6">기타</option>		
					      	  </select>
					        </div>
					  	  </div>
					      <div class="row">
					    	<div class="col-35">
					      		<label for="update_category2">SPECIES</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="update_category2" name="update_category2" >
					        	<option value="0">대분류를 선택해주세요</option>
					      	  </select>
					        </div>
					  	  </div>
					    </div> <!--/ col-65 -->
						<div class="col-35" style="padding-left: 4px; padding-top: 10px; overflow: hidden; cursor:pointer;">
					     <!--  <img id="image_section" src="https://www.w3schools.com/css/img_5terre.jpg" /> -->
					      <img src="<%=request.getContextPath() %>/resources/images/filemanager/pet/pet_profile/${pet.p_no }/image.jpg" style="width: 95%; height: 95%">
					    </div> <!--/ col-35 -->
					  </div><!--/ row -->
					  </form>
					  <div class="row">
					    <div class="col-25">
					      <label for="species">KIND</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="species" name="species" value="${pet.p_kind }" >
					    </div>
					  </div> 
					  <div class="row">
					    <div class="col-25">
					      <label for="like">LIKE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="like" name="like" value="${pet.p_like }">
					    </div>
					  </div> 
					  <div class="row">
					    <div class="col-25">
					      <label for="hate">HATE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="hate" name="hate" value="${pet.p_hate }">
					    </div>
					  </div> 
					  <div class="row">
					    <div class="col-25">
					      <label for="introduce">ABOUT</label>
					    </div>
					    <div class="col-75">
					      <textarea id="introduce" name="introduce" style="height:200px">${pet.p_about }</textarea>
					    </div>
					  </div>
					</div><!--/ container -->
					
					<div id="subBtn" class="row btns">
					    <input id="submitBtn" type="submit" value="저장">
					    <input id="updateBtn" type="button" value="수정">
					 </div><!--/ row btns -->	
					
				</div>
				
				</c:forEach>

			</c:if>
			
			
			
			
			
<!-- ---------------------------------------------------------------ctrl x -------------------------------------- -->
			
			
			
			
			

        </div><!--/ col-lg-6 -->
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
           <img class="img-responsive" src="<%=request.getContextPath() %>/resources/temp/assets/img/posts/1.jpg" alt="Image"/>
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
				<img class="img-responsive img-circle" src="http://bootdey.com/img/Content/user_3.jpg" alt="Image">
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
	<script src="<%=request.getContextPath() %>/resources/assets/js/circle-header.js"></script>
	<!-- custom script -->
	 <script src="<%=request.getContextPath() %>/resources/assets/js/custom-mypage-pets.js"></script>
	<!-- Auto Script -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
  </body>
</html>