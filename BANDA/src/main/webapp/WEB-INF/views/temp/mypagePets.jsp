<%@page import="com.mvc.banda.model.vo.PetVo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
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
		AccountVo accvo = (AccountVo)session.getAttribute("vo");
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	%>	  	  
	
	<script type="text/javascript">
			   			  	
	    function readURL2(input) {
	   	 if (input.files && input.files[0]) {
	   	  var reader = new FileReader();
						   	  
	   	  reader.onload = function (e) {
	   		  $('#updateimage').attr('src', e.target.result);  
	   		  $("#updateimgInp").attr('src', e.target.result);
	
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
	   <div class="p-2 nav-icon-lg mint-green" style="height: 59px;">
	   <a class="nav-icon" href="mypage_allselect.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
		<span>나의 반려동물</span>
	   </a>
	   </div>
	   
	   <div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
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
		뒤에배경
	 =============================================== --> 
	 <section class="profile">
	  <div class="container-fluid">
	   <div class="row">
	   	<img alt="feedbg" src="<%=request.getContextPath()%>/resources/images/bg/pet_bg.png" width="100%">
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
		     <img class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=accvo.getId() %>/image.jpg" 
		     											   alt="이미지 없음" onerror="this.src = '<%=request.getContextPath() %>/resources/images/logo_profile.png'" onclick="location.href='mypage_accountpage.do'">

		    </div><!-- /author -->
		   </div><!-- /.post-content -->		
		</div><!-- /col-sm-12 -->
		
       </div><!--/ row-->	
	  </div><!--/ container -->
	 </section><!--/ profile -->
  	
  
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
		                  onclick="change_div(this.id)" id="${pet.p_no }">
		           <div class="pet_no" id="pet_no" style="display: none">${pet.p_no }</div>
		           <div class="story-body text-center">
		           <div class=""><img class="img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/pet/pet_profile/${pet.p_no}/image.jpg" alt="petimage"></div>
		           <h4>${pet.p_Name }</h4>
		          </div>		  
				</div>
		 	</c:forEach>
		 </c:if>
<script type="text/javascript">
	
	function change_div(ele){
		
		var pno = ele;
		console.log(pno);
		
		$.ajax({
			
			type:"post",
			url:"change_pet.do",
			data:JSON.stringify(pno),
			//data:{"pno" : pno},
			contentType:"application/json",
			dataType:"json",
			success : function(data){
				console.log("success");	
				
				var class_list = ['선택','포유류','조류','파충류,양서류','어류','절지류','기타'];
				var species_list = ['선택','개','고양이','패럿','기니피그','다람쥐,하늘다람쥐','햄스터','토끼','고슴도치','돼지','말','영장류','원숭이','여우','너구리','사자','새','닭,병아리','오리','메추라기','십자매','거북','도마뱀','뱀','개구리,도롱뇽','물고기','새우','가재','게','거미','기타곤충','달팽이','문어','해파리','기타','기타','기타','기타','기타','기타'];
				var petVo = data.petVo;
				var path = "<%=request.getContextPath()%>";
				
				console.log(path);
				console.log(petVo);
				console.log(petVo.p_Name);
				
				var birth = new Date(petVo.p_birth);
				
				var s_birth = getFormatDate(birth);
				
				
				$("#detailname").val(petVo.p_Name);
				$("#detailbirth").val(s_birth);
				$("#detailspecies").val(petVo.p_kind);
				$("#detaillike").val(petVo.p_like);
				$("#detailhate").val(petVo.p_hate);
				$("#detailabout").val(petVo.p_about);
				$("#detailimage").prop("src",path+"/resources/images/filemanager/pet/pet_profile/"+petVo.p_no+"/image.jpg");
				
				$("#view_category1").html("");
				$("#view_category1").append($("<option>").val(petVo.class_no).text(class_list[petVo.class_no]));
				
				$("#view_category2").html("");
				$("#view_category2").append($("<option>").val(petVo.species_no).text(species_list[petVo.species_no]));

				
				//------------------------------------------------------------------------------------------------
				
				
				$("#updatepno").val(petVo.p_no);
				$("#updatename").val(petVo.p_Name);
				$("#updatebirth").val(s_birth);
				$("#updatespecies").val(petVo.p_kind);
				$("#updatelike").val(petVo.p_like);
				$("#updatehate").val(petVo.p_hate);
				$("#updateabout").val(petVo.p_about);
				$("#updateimage").prop("src",path+"/resources/images/filemanager/pet/pet_profile/"+petVo.p_no+"/image.jpg");
				//$("#updateimgInp").val("image.jpg");
				$("#updateimgInp").prop("src",path+"/resources/images/filemanager/pet/pet_profile/"+petVo.p_no+"/image.jpg");
				
				for(var i=0; i<7 ; i++){
					$("#update_category1 option:eq("+i+")").removeProp("selected");
				}
				
				$("#update_category1 option:eq("+petVo.class_no+")").prop("selected","selected");
				
				
				if(petVo.class_no == 0){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('0').text("대분류를 선택해주세요."));
				}else if(petVo.class_no == 1){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('1').text("개"));
					$("#update_category2").append($("<option>").val('2').text("고양이"));
					$("#update_category2").append($("<option>").val('3').text("패럿"));
					$("#update_category2").append($("<option>").val('4').text("기니피그"));
					$("#update_category2").append($("<option>").val('5').text("다람쥐,하늘다람쥐"));
					$("#update_category2").append($("<option>").val('6').text("햄스터"));
					$("#update_category2").append($("<option>").val('7').text("토끼"));
					$("#update_category2").append($("<option>").val('8').text("고슴도치"));
					$("#update_category2").append($("<option>").val('9').text("돼지"));
					$("#update_category2").append($("<option>").val('10').text("말"));
					$("#update_category2").append($("<option>").val('11').text("영장류"));
					$("#update_category2").append($("<option>").val('12').text("원숭이"));
					$("#update_category2").append($("<option>").val('13').text("여우"));
					$("#update_category2").append($("<option>").val('14').text("너구리"));
					$("#update_category2").append($("<option>").val('15').text("사자"));
					$("#update_category2").append($("<option>").val('34').text("기타"));
				}else if(petVo.class_no == 2){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('16').text("앵무새"));
					$("#update_category2").append($("<option>").val('17').text("닭, 병아리"));
					$("#update_category2").append($("<option>").val('18').text("오리"));
					$("#update_category2").append($("<option>").val('19').text("메추라기"));
					$("#update_category2").append($("<option>").val('20').text("십자매"));
					$("#update_category2").append($("<option>").val('35').text("기타"));
				}else if(petVo.class_no == 3){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('21').text("거북"));
					$("#update_category2").append($("<option>").val('22').text("도마뱀"));
					$("#update_category2").append($("<option>").val('23').text("뱀"));
					$("#update_category2").append($("<option>").val('24').text("개구리, 도롱뇽"));
					$("#update_category2").append($("<option>").val('36').text("기타"));
				}else if(petVo.class_no == 4){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('25').text("물고기"));
					$("#update_category2").append($("<option>").val('37').text("기타"));
				}else if(petVo.class_no == 5){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('26').text("새우"));
					$("#update_category2").append($("<option>").val('27').text("가재"));
					$("#update_category2").append($("<option>").val('28').text("게"));
					$("#update_category2").append($("<option>").val('29').text("거미"));
					$("#update_category2").append($("<option>").val('38').text("기타"));
				}else if(petVo.class_no == 6){
					$("#update_category2").html(" ");
					$("#update_category2").append($("<option>").val('31').text("달팽이"));
					$("#update_category2").append($("<option>").val('32').text("문어"));
					$("#update_category2").append($("<option>").val('33').text("해파리"));
					$("#update_category2").append($("<option>").val('39').text("기타"));
				}
				
				console.log(petVo.species_no);
				var length = $("#update_category2 option").length;
				console.log(length);
				for(var i=0; i<length; i++){
					if( $("#update_category2 option:eq("+i+")").val() == petVo.species_no ){
						$("#update_category2 option:eq("+i+")").attr("selected","selected");
					}
				}
				

			},
			error : function(){
				console.log("fail");
			}
			
		});
		
	}
	
	function getFormatDate(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
	}
	
	
</script>
		</div><!--/ col-lg-3 -->
	    <div class="col-lg-6">
			
			<form:form action="mypage_pet_insert.do" method="post" enctype="multipart/form-data" modelAttribute="petVo">				
			<div id="mypetsInsert" class="cardbox" style="border:1px solid #F4F4F4; background-color: #F4F4F4; box-shadow: 2px 2px 2px 2px lightgray; height: 712px;">
			  <input type="hidden" value="<%=accvo.getId()%>" name="id">
			  <input type="hidden" value="-" name="p_character" id="character">
					  
			  <div class="row">
			    <div class="col-65">
			      <div class="row">    
			      	<div class="col-35">
			      		<label for="name">NAME</label>
			    	</div>
			   		<div class="col-65">
			      		<input type="text" id="name" name="p_Name" placeholder="이름을 입력하세요.." required="required">
			        </div>
			      </div>
			      
			      <div class="row">    
			      	<div class="col-35">
			      		<label for="birth">BIRTH</label>
			    	</div>
			   		<div class="col-65">
			      		<input type="date" id="birth" name="p_birthtmp" placeholder="이름을 입력하세요.." required="required">
			        </div>
			      </div>
			      
			      <div class="row">
			    	<div class="col-35">
			      		<label for="category1">CLASS</label>
			      	</div>
			      	<div class="col-65">
			      	  <select id="category1" name="class_no">
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
			      	  <select id="category2" name="species_no">
					    <option value="0" selected="selected">대분류를 선택해주세요</option>
			      	  </select>
			        </div>
			  	  </div>
			      
			    </div> <!--/ col-65 -->
			    
				<div class="col-35" style="padding-left: 4px; padding-top: 10px; overflow: hidden; cursor:pointer;">
			      <input type="file" id="imgInp" name="insertimgInp" style="display: none;" required="required">
			     <!--  <img id="image_section" src="https://www.w3schools.com/css/img_5terre.jpg" /> -->
			      <img id="image_section" style="width: 90%; height: 90%; border-radius: 70%;" src="<%=request.getContextPath() %>/resources/temp/assets/img/icon/profile_default.jpg" alt="user">
			    </div> <!--/ col-35 -->
			    
			    
			  </div><!--/ row -->
			
			  <div class="row">
			    <div class="col-25">
			      <label for="species">KIND</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="species" name="p_kind" placeholder="종을 입력하세요.." required="required">
			    </div>
			  </div> 
			  
			  <div class="row">
			    <div class="col-25">
			      <label for="like">LIKE</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="like" name="p_like" placeholder="좋아하는 것을 입력하세요.." required="required">
			    </div>
			  </div> 
			  
			  <div class="row">
			    <div class="col-25">
			      <label for="hate">HATE</label>
			    </div>
			    <div class="col-75">
			      <input type="text" id="hate" name="p_hate" placeholder="싫어하는 것을 입력하세요.." required="required">
			    </div>
			  </div> 
			  
			  <div class="row">
			    <div class="col-25">
			      <label for="introduce">ABOUT</label>
			    </div>
			    <div class="col-75">
			      <textarea id="about" name="p_about" placeholder="소개를 입력하세요.." style="height:200px" required="required"></textarea>
			    </div>
			  </div>
			</div><!--/ container -->
			
			  <div id="subBtn" class="row btns">
				<input id="submitBtn" type="submit" value="저장">
			  </div><!--/ row btns -->	
			 </form:form>			  
			
			
<!-- testtest -->			
<%
	List<PetVo> pet_list = accvo.getPet_list();
%>
				
				<div>
						<!-- 저장된 프로필 보기 -->
					<div id="mypetsDetail" class="cardbox" style="display:none; border:1px solid #F4F4F4; background-color: #F4F4F4; box-shadow: 2px 2px 2px 2px lightgray; height: 712px;">
					  <div class="row">
					    <div class="col-65">
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="name">NAME</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="text" id="detailname" name="detailname" value="hi" disabled="disabled">
					        </div>
					      </div>
					      
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="birth">BIRTH</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="text" id="detailbirth" name="detailbirth" value="" disabled="disabled" >
					        </div>
					      </div>
					      
					      <div class="row">
					    	<div class="col-35">
					      		<label for="view_category1">CLASS</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="view_category1" name="view_category1" disabled="disabled">
	
					      	  </select>
					        </div>
					  	  </div>
					      <div class="row">
					    	<div class="col-35">
					      		<label for="view_category2">SPECIES</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="view_category2" name="view_category2" disabled="disabled">
					      	  
					      	  </select>
					        </div>
					  	  </div>
					      
					    </div> <!--/ col-65 -->
					    
						<div class="col-35" style="padding-left: 4px; padding-top: 10px; overflow: hidden; cursor:pointer;">
					      <img id="detailimage" src="" style="width: 90%; height: 90%; border-radius: 70%;">
					    </div> <!--/ col-35 -->
					    
					    
					  </div><!--/ row -->
					
					  <div class="row">
					    <div class="col-25">
					      <label for="species">KIND</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="detailspecies" name="detailspecies" value="" disabled="disabled">
					    </div>
					  </div> 
					  
					  <div class="row">
					    <div class="col-25">
					      <label for="like">LIKE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="detaillike" name="detaillike" value="" disabled="disabled">
					    </div>
					  </div> 
					  
					  <div class="row">
					    <div class="col-25">
					      <label for="hate">HATE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="detailhate" name="detailhate" value="" disabled="disabled">
					    </div>
					  </div> 
					  
					  <div class="row">
					    <div class="col-25">
					      <label for="introduce">ABOUT</label>
					    </div>
					    <div class="col-75">
					      <textarea id="detailabout" name="detailabout" style="height:200px" disabled="disabled"></textarea>
					    </div>
					  </div>
					  
					  
					</div><!--/ container -->
					
					
					<!-- 저장된 프로필  수정-->
					<form:form action="mypage_pet_update.do" method="post" enctype="multipart/form-data" modelAttribute="petVo">
					<div id="mypetsUpdate" class="cardbox" style="display:none; border:1px solid #F4F4F4; background-color: #F4F4F4; box-shadow: 2px 2px 2px 2px lightgray; height: 712px;">
					  <input type="hidden" value="" name="p_no" id="updatepno">
					  <input type="hidden" value="<%=accvo.getId()%>" name="id">
					  <input type="hidden" value="-" name="p_character" id="updatepcharacter">
					  
					  <div class="row">
					    <div class="col-65">
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="name">NAME</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="text" id="updatename" name="p_Name" value="" required="required">
					        </div>
					      </div>
					      <div class="row">    
					      	<div class="col-35">
					      		<label for="birth">BIRTH</label>
					    	</div>
					   		<div class="col-65">
					      		<input type="date" id="updatebirth" name="p_birthtmp" value="<fmt:formatDate value="" pattern="yyyy-MM-dd"/>" required="required">
					        </div>
					      </div>
					      <div class="row">
					    	<div class="col-35">
					      		<label for="update_category1">CLASS</label>
					      	</div>
					      	<div class="col-65">
					      	  <select id="update_category1" name="class_no" >
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
					      	  <select id="update_category2" name="species_no" >
					      	  
					      	  </select>
					        </div>
					  	  </div>
					      	  <p align="right" style="font-size: 8pt">*이미지의 확장자는 .jpg/.JPG 만 가능합니다. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </p>
					    </div> <!--/ col-65 -->
						<div class="col-35" style="padding-left: 4px; padding-top: 10px; overflow: hidden; cursor:pointer;">
			   			  <input type="file" id="updateimgInp" name="updateimgInp" src="" style="display: none;" onchange="readURL2(this);" accept=".jpg .JPG" required="required">
					      <img id="updateimage" src="" style="width: 90%; height: 90%; border-radius: 70%;">
					    </div> <!--/ col-35 -->
					  </div><!--/ row -->
					  <div class="row">
					    <div class="col-25">
					      <label for="species">KIND</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="updatespecies" name="p_kind" value="" required="required">
					    </div>
					  </div> 
					  <div class="row">
					    <div class="col-25">
					      <label for="like">LIKE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="updatelike" name=p_like value="" required="required">
					    </div>
					  </div> 
					  <div class="row">
					    <div class="col-25">
					      <label for="hate">HATE</label>
					    </div>
					    <div class="col-75">
					      <input type="text" id="updatehate" name="p_hate" value="" required="required">
					    </div>
					  </div> 
					  <div class="row">
					    <div class="col-25">
					      <label for="introduce">ABOUT</label>
					    </div>
					    <div class="col-75">
					      <textarea id="updateabout" name="p_about" style="height:200px" required="required"></textarea>
					    </div>
					  </div>
					</div><!--/ container -->
					<div id="subBtn" class="row btns">
					    <input id="submitBtnch" type="submit" value="저장" style="display: none" >					
					    <input id="updateBtn" type="button" value="수정">
					 </div><!--/ row btns -->	
				</form:form>
				
				</div>
				
			
			
			
			
			
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