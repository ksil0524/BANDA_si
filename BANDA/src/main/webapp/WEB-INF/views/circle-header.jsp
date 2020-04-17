<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.mvc.banda.model.vo.AccountVo" %>
<link href="icheck-bootstrap.css" rel="stylesheet">
			<header id="header">

				<div id="circle_header_bg" class="inner" style="position:relative; background: url(<%=request.getContextPath()%>/resources/images/logo_pink_nt.png);
    background-size: contain;">
	               <div class="closeBtn">
	                  <a href="#" id="closeBtn" class=""><i class="fas fa-times-circle"></i></a>
	               </div>                
	               <div id="content" class="content">
	                  <img id="testlogo" src="<%=request.getContextPath()%>/resources/images/logo_text.png" style="width: 80%; height: 50%; margin-top: 120px;">
	                  <!-- <h1>Radius</h1> -->
	                  <h2></h2>
	                  
	                  <!-- 닫힘 버튼 -->
	                  <a id="loginBtn" class="button big alt" onclick = "reset_login()" style="background: none; color:white;"><span>Login</span></a>
	                  
	                  <a href="#" id="feedBtn" class="feedBtn button big alt" style="background: none; color:white;"><span>Feed</span></a>
	               </div>

					
					<div id="logincontent" style="display: none;" >
						<div class="content">
                                <div class="social">
                                    <a class="circle github" href="${naver_url}" >
                                        <img src = "<%=request.getContextPath() %>/resources/images/naver.png" style = "width:23px;height:25px" id="naverlogo">
                                    </a>
                                    <a id="google_login" class="circle google" href="#" onclick="onSignIn();">
                                        <i class="fa fa-google-plus fa-fw"></i>
                                    </a>
                                    <a id="facebook_login" class="circle facebook" href="#" onclick="alert('현재 준비중인 기능입니다.')">
                                        <i class="fa fa-facebook fa-fw"></i>
                                    </a>
                                </div>
                                <div class="division">
                                    <div class="line l"></div>
                                      <span>or</span>
                                    <div class="line r"></div>
                                </div>
                                <div class="error"></div>
                                
                                <!-- 로그인 -->
                                <div class="form loginBox" id = "login" style = "display:block">
                                    <form id="loginForm" method="" action="login.do" accept-charset="UTF-8">
                                    <input id="login-email" class="form-control" type="text" placeholder="Id" name="email">
                                    <input id="login-password" class="form-control" type="password" placeholder="Password" name="password">
                                    <p id = "error_login" style = "color:red;display:none"></p>
                                    <a href = "#" style = "color:lightgray" id = "idFind" onclick = "idFind()">아이디찾기</a>&nbsp;&nbsp;
                                    <a href = "#" style = "color:lightgray" id = "pwdFind" onclick = "pwdFind()">비밀번호찾기</a>
                                    <input id="login-loginBtn" class="btn btn-default btn-login" type="button" value="Login" onclick="loginChk()">                         
                                    <input id="joinBtn" class="btn btn-default btn-login" type="button" value="Join" onclick="joinUser()">
                                    </form>
                                </div>
                                
                                <!-- 어아다찾기 -->
                                <div class="form loginBox" id = "idfind" style = "display:none;">
                                    <form method="" action="" accept-charset="UTF-8">
                                    <input class="form-control" type="email" placeholder="Email" name="email" id = "findid" required="required">
                                    <input class="form-control" type="text" placeholder="Email" name="email" id = "findid_res" style = "display:none;color:red;font-weight:bold">
                                    <input class="btn btn-default btn-login" type="button" value="아이디찾기" onclick="idFindChk_res()" id = "idFindChk_res_id">
                                    <input class="btn btn-default btn-login" type="button" value="돌아가기" onclick="return_login()" id = "return_login_id2" style ="background-color: #e8e8e8 !important;    font-family: 'BMHANNAAir' !important;font-size: 13px;    font-weight: 540; margin-top:3%">
                                    <input class="btn btn-default btn-login" type="button" value="로그인" onclick="return_login()" id = "return_login_id" style = "display:none">
                                    </form>
                                </div>
                                
                                <!-- 비밀번호찾기 -->
                                <div class="form loginBox" id = "pwdfind" style = "display:none;vertical-align:middle">
                                    <form method="" action="login.do" accept-charset="UTF-8">
                                    <input class="form-control" type="text" placeholder="아이디" name="id" id = "findpwd_id">
                                    <input class="form-control" type="email" placeholder="이메일" name="email" id = "findpwd_email">
                                    <p style = "color:red;font-weight:bold;display:none" id = "findpwd_res"></p>
                                    <input class="btn btn-default btn-login" type="button" value="비밀번호찾기" onclick="pwdFindChk_res()" id = "idFindChk_res_pwd">
                                    <input class="btn btn-default btn-login" type="button" value="돌아가기" onclick="return_login2()" id = "return_login_pwd2" style ="display:inline; background-color: #e8e8e8 !important;    font-family: 'BMHANNAAir' !important;font-size: 13px;    font-weight: 540; margin-top:3%">
                                    <input class="btn btn-default btn-login" type="button" value="로그인" onclick="return_login2()" id = "return_login_pwd" style = "display:none;background-color: #e8e8e8 !important;    font-family: 'BMHANNAAir' !important;font-size: 13px;    font-weight: 540; margin-top:3%">
                                    </form>
                                </div>
                             </div>
					</div>
					
					<div id="joincontent" style="display: none;" >
						<div class="content">
                                <div class="division">
                                      <span id="joinIcon"><i class="fas fa-user-edit"></i></span>
                                </div>
                                <div class="error"></div> 
                                <div class="form loginBox">
                                    <form id="joinForm" method="" action="register.do" accept-charset="UTF-8">
                                    <input id="email" class="form-control" type="text" placeholder="Email" name="email">
                                    <input id="id" class="form-control" type="text" placeholder="Id" name="id">
                                    <input id="password" class="form-control" type="password" placeholder="Password" name="password">
                                    <input id="phone" onKeyup="inputPhoneNumber(this);" maxlength="13"  class="form-control" type="text" placeholder="Phone" name="phone">
                                    <input id="join-loginBtn" class="btn btn-default btn-login" type="button" value="Join" onclick="joinChk()">
                                    </form>
                                </div>
                             </div>
					</div>
					
					<div class="content" id="isLogin" style="display: none">
						<div style="margin-top: 30px;">
							<!-- 알림  -->
							<a class="islogin-icon-left">
								<i class="fa fa-bell noti-icon" style="color: #ff7f73"></i>
								<!-- 
								<span class="badge badge-danger badge-pill noti-icon-badge">4</span>
								 -->
							</a>

							
							<%
								String id = null;
							
								if(session.getAttribute("vo") != null){
									AccountVo vo = (AccountVo)session.getAttribute("vo");
									id = vo.getId();
								}
							%>
							<!-- 프로필사진 -->
							<a href="mypage_accountpage.do"><img class="img-fluid img-circle" src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/<%=id %>/image.jpg" alt="Image" onerror="this.src = '<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/image.jpg'"></a>
							<!-- 메일 -->
							
							<a id="chaticon" class="islogin-icon-right" href="myChatpage.do" style="color: white;">
								<i class="fas fa-comments"></i>
								<!-- 
								 <span class="badge badge-success badge-pill noti-icon-badge">6</span>
								 -->
							</a>
						</div>
						<div class="iconBox" style="margin-top: 15px; margin-bottom: 30px;">
							<a href="index_go.do" id="menuBtn1" class="" style="color:#21b77b;"><img alt="menuhome" id="menuhome" class="menubar" src="<%=request.getContextPath() %>/resources/images/zoo/outline_png/004-bear.png" width="18%"></a>
							<a href="boardListFree.do" id="menuBtn2" class="" style="color:#80b8ff;"><img alt="menuboard" id="menuboard" class="menubar" src="<%=request.getContextPath() %>/resources/images/zoo/outline_png/020-monkey.png" width="18%"></a>
							<a href="mapHospital.do" id="menuBtn3" class="" style="color:#f79689;"><img alt="menumap" id="menumap" class="menubar" src="<%=request.getContextPath() %>/resources/images/zoo/outline_png/017-lion.png" width="18%"></a>
							<a href="mypage_followpage.do" id="menuBtn4" class="" style="color:#ec3d6e;"><img alt="menumypage" id="menumypage" class="menubar" src="<%=request.getContextPath() %>/resources/images/zoo/outline_png/006-chameleon.png" width="18%"></a>
						</div>
						
						<div id="searchinputBox">
					        <div id="autoArea" style="text-align: left;"></div><!-- 자동완성 @author 주희진 -->
							<input type="text" id="searchinput" name="keyword" value="" >
							<div id="searchBtn" class="searchBtn" onclick = "searchFunction()"><i class="fas fa-search" style="color:white"></i></div>					
							  <div class="radio icheck-default">
						        <input type="radio" class="jh_searchtype" name="jh_searchtype" value="jh_searchid" id="jh_searchid" style="display: none;"><label for="jh_searchid" style="font-size: 15pt; color:white;"> 계정</label>
						        <input type="radio" class="jh_searchtype" name="jh_searchtype" value="jh_searchfeedptag" id="jh_searchfeedptag" style="display: none;"><label for="jh_searchfeedptag" style="font-size: 15pt; color:white;"> 반려동물</label>
						        <input type="radio" class="jh_searchtype" name="jh_searchtype" value="jh_searchfeedhtag" id="jh_searchfeedhtag" style="display: none;"><label for="jh_searchfeedhtag" style="font-size: 15pt; color:white;"> 해시태그</label>
						      </div>
						</div>
				      
						
					</div>				
					<div id="logOut">
						<button onclick = "logout();" style = "background : none;"><i class="fas fa-sign-out-alt" style="color:white"></i></button>
					</div>
					
					<!-- 닫혔을때 열기 버튼  -->
					<a href="#" class="button hidden"><span>Let's Go</span></a>
				</div>
			</header>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
		$(function(){
			//성일 써클헤더에서 메뉴바 이미지 변경하기
			$(".menubar").mouseenter(function(){
				var id = $(this).attr("id");
				if(id == "menuhome"){
					$("#menuhome").attr("src","<%=request.getContextPath()%>/resources/images/zoo/color_png/004-bear.png");
				}else if(id=="menuboard"){
					$("#menuboard").attr("src","<%=request.getContextPath()%>/resources/images/zoo/color_png/020-monkey.png");
				}else if(id=="menumap"){
					$("#menumap").attr("src","<%=request.getContextPath()%>/resources/images/zoo/color_png/017-lion.png");
				}else if(id == "menumypage"){
					$("#menumypage").attr("src","<%=request.getContextPath()%>/resources/images/zoo/color_png/006-chameleon.png");
				}
			});
			
			$(".menubar").mouseleave(function(){
				var id = $(this).attr("id");
				if(id == "menuhome"){
					$("#menuhome").attr("src","<%=request.getContextPath()%>/resources/images/zoo/outline_png/004-bear.png");
				}else if(id=="menuboard"){
					$("#menuboard").attr("src","<%=request.getContextPath()%>/resources/images/zoo/outline_png/020-monkey.png");
				}else if(id=="menumap"){
					$("#menumap").attr("src","<%=request.getContextPath()%>/resources/images/zoo/outline_png/017-lion.png");
				}else if(id == "menumypage"){
					$("#menumypage").attr("src","<%=request.getContextPath()%>/resources/images/zoo/outline_png/006-chameleon.png");
				}
			});
			

			
		});
</script>		
	
			<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
			<script>
			
			/////////////구글 로그인 부분
			
function init(){
	console.log('init');
	gapi.load('auth2',function(){
		console.log('auth2');
		window.gauth = gapi.auth2.init({
			client_id:'846381888752-6m25mk1r1djr3grme9po411b9mh45bev.apps.googleusercontent.com'
		})
		
		gauth.then(function(){
			console.log('sucusse');
			
		},function(){
			console.log('fail');
		});
	});
}

function onSignIn() {
		console.log('askjfalksdjflaskjflkjs')
		gauth.signIn();
		console.log(gauth.isSignedIn.get());
		if(gauth.isSignedIn.get()){
			console.log('logined');
			var profile = gauth.currentUser.get().getBasicProfile();
			console.log(profile);
			var id = profile.getEmail();   		

			console.log(id);
			} else {
			console.log('logouted');
			}
			 var login_set = {
							"id":id		
					};
					
					$.ajax({
						
						url : "google.do",
						type : "post",
						data : JSON.stringify(login_set),
						contentType: "application/json",
						dataType:"json",
						success : function(msg){
							console.log(msg.chk);
							if(msg.chk){
								isLogin = 1;
								$(".closeBtn").hide();
								$("#logincontent").hide();
								$("#header").toggleClass('hide');
								$("#content").hide();
								$("#error_login").css("display","none");
								
								location.href = "index.jsp";
								
								} else {
									
									$("#error_login").css("display","block");
									
									return;
								}
								
						},
						error:function(request,status,error){
							

						}
						
						
					});
}
			
			
//////////////////////////////////////	

			reset_login = function(){
				
				//아이디찾기
				$("#findid").val('');
				$("#findid").show();
				$("#findid_res").val('');
				$("#findid_res").hide();
				$('#idFindChk_res_id').show();
				$('#return_login_id').hide();
				$('#return_login_id2').show();
				
				//비밀번호 찾기
				$("#findpwd_id").val("");
				$("#findpwd_id").show();
				$("#findpwd_email").val("");
				$("#findpwd_email").show();
				$("#findpwd_res").hide();
				$("#idFindChk_res_pwd").show();
				$('#return_login_pwd').hide();
				$('#return_login_pwd2').show();
				
				$("#error_login").css("display","none");
				$("#idfind").css("display","none");
				$("#pwdfind").css("display","none");
				$("#login").css("display","block");
				
			}
			
			
			function idFind(){
				
				$('#idfind').show();
				$('#login').hide();
				$('#pwdfind').hide();
				
			}
			
			function idFindChk_res(){
				
				var email = $('#findid').val();
				var findid_set = {
						
						'email'  : email						
				}

				
				if(findid_set.email.length != 0){
				
					$.ajax({
						
						url : 'idFind.do',
						type : 'post',
						data : JSON.stringify(findid_set),
	  					contentType: "application/json",
	  					dataType:"json",
	  					success : function(data){
	  						
	  						if(data.chk){
	  							
	  							$('#findid_res').show();
	  							$('#findid').hide();
	
	  							$('#findid_res').val(data.id);
	  							
	  							$('#idFindChk_res_id').hide();
	  							$('#return_login_id').show();
	  							$('#return_login_id2').hide();
	  							
	  							
	  						} else {
	  							alert('아이디 찾기 실패');
	  						}
	  						
	  					},
						error:function(request,status,error){
							
	
						}
						
					});
				} 
				
			}
			
			function return_login(){
				
				$('#findid_res').val('');
				$('#findid').val('');
				
				//아이디찾기이전
				$('#idfind').hide();
				$('#login').show();
				$('#pwdfind').hide();
				$("#return_login_id2").show();
				
				//아이디찾기 이후
  				$('#findid_res').hide();
  				$('#findid').show();
				$('#idFindChk_res_id').show();
				$('#return_login_id').hide();
				
			}
			
			function pwdFind(){
				
				$('#idfind').hide();
				$('#login').hide();
				$('#pwdfind').show();
				
				
			}
			
			function pwdFindChk_res(){
				
				var findpwd_id = $('#findpwd_id').val();
				var findpwd_email = $('#findpwd_email').val();
				
				var findpwd_set = {
					'id' : 	findpwd_id,
					'email' : findpwd_email						
				}
				
				if(findpwd_set.id.length != 0 && findpwd_set.email.length != 0){
					$.ajax({
						
						url : 'pwdFind.do',
						type : 'post',
						data : JSON.stringify(findpwd_set),
	  					contentType: "application/json",
	  					dataType:"json",
	  					success : function(data){
	  						
	  						if(data.chk){
	  							
	  							$('#findpwd_res').show();
	  							$('#findpwd_id').hide();
	  							$('#findpwd_email').hide();
	  							$('#return_login_pwd2').hide();
	  							
	  							$('#findpwd_res').html(data.id);
	  							$('#idFindChk_res_pwd').hide();
	  							$('#return_login_pwd').show();
	  							
	
	  						} else {
	  							alert('비밀번호 찾기 실패');
	  						}
	  						
	  					},
						error:function(request,status,error){
							
	
						}
						
					});
				}
				
				
				
			}
			
			function return_login2(){
				
				$('#findpwd_id').val('');
				$('#findpwd_email').val('');
				$('#findpwd_res').val('');
				
				//아이디찾기이전
				$('#idfind').hide();
				$('#login').show();
				$('#pwdfind').hide();
				$('#return_login_pwd2').show();
				
				//아이디찾기 이후
				$('#findpwd_res').hide();
				$('#findpwd_id').show();
				$('#findpwd_email').show();
				$('#idFindChk_res_pwd').show();
				$('#return_login_pwd').hide();
				
			}

			
			</script>
			
		<style type="text/css">
			#chaticon:hover{
				color:gray !important;
			}
		</style>
