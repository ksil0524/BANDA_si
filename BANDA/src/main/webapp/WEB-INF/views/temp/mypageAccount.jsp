<%@page import="java.text.SimpleDateFormat"%>
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
	
     <!-- ==============================================
	 Scripts
	 =============================================== -->
	 
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>

	<%
		AccountVo accvo = (AccountVo)session.getAttribute("vo");

	%>	  	  
		
		
	   <script type="text/javascript">
		  //프로필 사진 변경 스크립트
	  		function profileimg(){
	  			alert("프로필 사진은 .jpg 또는 .JPG 파일만 선택이 가능합니다.");
	  			$("#profile_img").click();
	  		}
	   			
	   			
	   		function profileimginp(){
	   			
	   			$("#profileform").submit();
	   			
	   		}
	   		
	  		function readURL3(input) {
			   	 if (input.files && input.files[0]) {
			   	  var reader = new FileReader();
								   	  
			   	  reader.onload = function (e) {
			   		  $('#profile_img').attr('src', e.target.result);  
			
			   	  }
			   	  
			   	  reader.readAsDataURL(input.files[0]);
			   	  }
			   	}	
	   	
	  	

	  		
	  		
	  		
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
	   
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
	   <a class="nav-icon" href="mypageFeed.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의피드</span>
	   </a>
	   </div>
	   <div class="p-2 nav-icon-lg mint-green" style="height: 59px;">
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
	   <div class="row">
		
		<img alt="accountbg" src="<%=request.getContextPath() %>/resources/images/bg/acc_bg.png" width="100%" >
		
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
		     <img class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=accvo.getId() %>/image.jpg" alt="Image" >
		    </div><!-- /author -->
		   </div><!-- /.post-content -->		
		</div><!-- /col-sm-12 -->
		
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  
	 <!-- ==============================================
	 User Profile Section
	 =============================================== --> 
	 
	 <script type="text/javascript">
	 	
	 	function conform(){
	 		if($("#tconform").css("display") == "none"){
	 			$("#tconform").show();
	 			$("#cfbtn").show();
	 			$("#updatebtn").html("");
	 			$("#updatebtn").text("취   소");
	 			$("#tprofile").hide();
	 		}else{
	 			$("#tconform").hide();
	 			$("#tprofile").show();
	 			$("#cfbtn").hide();
	 			$("#updatebtn").html("");
	 			$("#updatebtn").text("수   정");
	 		}
	 	};
	 	
	 	function confirm(){
	 		
	 		var email = $("#ckemail").val();
	 		var phone = $("#ckphone").val();
	 		var password = $("#ckpassword").val();
	 		var passwordck = $("#ckpasswordck").val();
	 		
	 		if(email == "" ||  phone == "" ||  password == "" || passwordck == ""){
	 			alert("수정항목을 제대로 입력해주세요.");
	 			return false;	
	 		}
	 		
	 		if(password != passwordck){
	 			
	 			alert("비밀번호가 같지 않습니다. 다시 입력해 주세요.");
	 			return false;
	 			
	 		}
	 	
	 		$("#accountupdate").submit();

	 	}
	 	
function inputPhoneNumber1(obj) {
			


		    var number = obj.value.replace(/[^0-9]/g, "");
		    var phone = "";
		
		
		
		    if(number.length < 4) {
		        return number;
		    } else if(number.length < 7) {
		        phone += number.substr(0, 3);
		        phone += "-";
		        phone += number.substr(3);
		    } else if(number.length < 11) {
		        phone += number.substr(0, 3);
		        phone += "-";
		        phone += number.substr(3, 3);
		        phone += "-";
		        phone += number.substr(6);
		    } else {
		        phone += number.substr(0, 3);
		        phone += "-";
		        phone += number.substr(3, 4);
		        phone += "-";
		        phone += number.substr(7);
		    }
		    obj.value = phone;
		}
$(document).ready(function(){
	 	//비밀번호 4~10글자 영소 숫자
  		$("#ckpassword").blur(function(){

  			var id = $("#ckpassword").val();
  			//영문자 숫자 4~10
  			var loginIdRex =  /^[a-z0-9]{4,10}$/g;

  			if(!loginIdRex.test(id)){
  				$("#ckpassword").val("");
  				$("#ckpassword").attr("placeholder","숫자,소문자 4~10자리만 입력해주세요.");
  				$("#ckpassword").css({"font-size":"12pt"})
  				return false;
  			}
  			
  		})
  		$("#ckphone").blur(function(){
			var id = $("#ckphone").val();
			
			var loginIdRex = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
		
			if(!loginIdRex.test(id)){
				
				$("#ckphone").val("");
				
				$("#ckphone").attr("placeholder","010-0000-0000 형식으로 입력해주세요");
				$("#ckphone").css({"font-size":"12pt"})
				return false;
			}
			
		})
  		
  		
  	//비밀번호 4~10글자 영소 숫자
  		$("#ckemail").blur(function(){
  			
  			var id = $("#ckemail").val();
  			
  			//영문자 숫자 4~10
			var loginIdRex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[0-9a-zA-Z]$/i;

  			if(!loginIdRex.test(id)){
  				$("#ckemail").val("");
  				
  				$("#ckemail").attr("placeholder","이메일 형식으로 입력해주세요");
  				$("#ckemail").css({"font-size":"12pt"})
  				return false;
  			}
  			
  		})
  		
  		
		//id 중복체크로 변경된 placeholder 제자리
		$("#ckphone").focus(function(){
			$("#ckphone").attr("placeholder","phone")
			$("#ckphone").css({"font-size":"20pt"})
		})
		//id 중복체크로 변경된 placeholder 제자리
		$("#ckemail").focus(function(){
			
			$("#ckemail").attr("placeholder","email")
			$("#ckemail").css({"font-size":"20pt"})
		})
	
		//password 중복체크로 변경된 placeholder 제자리
		$("#ckpassword").focus(function(){
			$("#ckpassword").attr("placeholder","password")
			$("#ckpassword").css({"font-size":"20pt"})
		})
})
	 	
	 	
	 	
	 	
	 	
	 </script>
	 
	 
	 
	 <section class="details">
	  <div class="container">
	   <div class="row">
	    <div class="col-lg-12">
		 
          <div class="details-box row" style="margin-bottom: 200px;">
		   <div class="col-lg-9" style="width: 1140px;">
           <div class="content-box">
		     <h4 style="margin-bottom: 50px;margin-top: 30px;text-align: center;">ID.   <%=accvo.getId() %> <i class="fa fa-check" style="background: #ff7f73;"></i></h4>
             <table id="tprofile">
             	<col width="300px;">
             	<col width="300px;">
             	<tr>
					<td style="text-align: center;    padding: 3.75em 0.75em ">
            			<p style="font-size: 20pt;">PROFILE IMG</p>
            			<p style="font-size: 13pt;">수정을 원하시면 이미지를 클릭해주세요.</p>
             		</td>
             		<td style="text-align: center; padding: 3.75em 0.75em">             		
						<form:form action="mypage_acco_changeprofileimg.do" method="post" enctype="multipart/form-data" id="profileform">
					   		 <input type="hidden" name="account_id" value="<%=accvo.getId()%>"> 
					   		 <input type="file" id="profile_img" name="profile_img" src="" style="display: none;" accept=".jpg" onchange="profileimginp();">
						     <img id="changeprofileimg" class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=accvo.getId() %>/image.jpg" alt="Image" onclick="profileimg();" style="width: 200px; height: 200px; border: 7px solid #fff;">
					  	 </form:form> 
             		</td>             	
             	</tr>
             	<tr>
             		<td style="text-align: center;    padding: 3.75em 0.75em ">
            			<p style="font-size: 20pt;">EMAIL</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag"><%=accvo.getEmail() %></span><p>
             		</td>
             	</tr>
             	<tr>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
            			<p style="font-size: 20pt;">PHONE</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag"><%=accvo.getPhone() %></span><p>
             		</td>
             	</tr>
             	<!-- 
             	<tr>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
            			<p style="font-size: 20pt;">PASSWORD</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag">test</span><p>
             		</td>
             	</tr>
             	 -->
             </table>
             
             <form action="mypage_accountupdate.do" method="post" id="accountupdate">
             <input type="hidden" name="id" value="<%=accvo.getId() %>">
             <table id="tconform" style="display: none;">
             	<col width="300px;">
             	<col width="300px;">   	
             	<tr>
             		<td style="text-align: center;    padding: 3.75em 0.75em ">
            			<p style="font-size: 20pt;">EMAIL</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag"><input type="text" style="width:275px; height:35px;" id="ckemail" name="email" placeholder="Email" value="<%=accvo.getEmail() %>"></span><p>
             		</td>
             	</tr>
             	<tr>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
            			<p style="font-size: 20pt;">PHONE</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag"><input type="text" style="width:275px; height:35px;" id="ckphone" onKeyup="inputPhoneNumber1(this);" placeholder="Phone" maxlength="13" name="phone" value="<%=accvo.getPhone() %>"></span><p>
             		</td>
             	</tr>
             	<tr>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
            			<p style="font-size: 20pt;">PASSWORD</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag"><input type="password" style="width:275px; height:35px;" id="ckpassword" name="password" placeholder="Password" value=""></span><p>
             		</td>
             	</tr>
             	<tr>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
            			<p style="font-size: 20pt;">PASSWORD CHECK</p>
             		</td>
             		<td style="text-align: center;     padding: 3.75em 0.75em">
             			<p style="font-size: 20pt;"><span class="hashtag"><input type="password" style="width:275px; height:35px;" id="ckpasswordck" placeholder="Password" name="passwordck" value=""></span><p>
             		</td>
             	</tr>
             </table>
             </form>
             
             
             <!-- 
			 <small><span>www.themashabrand.com</span></small>
              -->
			 
           </div><!--/ media -->
		   </div> 
		   <div class="col-lg-3" style="width: 1140px; margin-top: 30px;">
           <div class="follow-box" style="text-align: center; margin-top: 50px; margin-bottom: 70px;">
		    <button id="updatebtn" class="kafe-btn kafe-btn-mint" onclick="conform();">수   정</button>
		    <button id="cfbtn" class="kafe-btn kafe-btn-mint" style="display: none;" onclick="confirm()">수정완료</button>
		    <button class="kafe-btn kafe-btn-mint" onclick = "delete_user('<%=accvo.getId() %>')">회원 탈퇴</button>
           </div><!--/ dropdown -->
		   </div>
          </div><!--/ details-box -->
		</div>
	   </div>
	  </div><!--/ container -->
	 </section><!--/ profile -->

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
	<!-- Auto Script -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		function delete_user(id){
			location.href = 'delete_user.do?id='+id;
		}
	</script>
	
  </body>
</html>
