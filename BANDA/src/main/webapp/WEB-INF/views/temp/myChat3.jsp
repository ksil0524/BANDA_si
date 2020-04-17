<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.mvc.banda.model.vo.ChatVo"%>
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
	
	<!-- ==============================================
	Scripts
	=============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
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
	
</head>
<body>
<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>

	<!-- ==============================================
	HeaderSection
	=============================================== -->
	<jsp:include page="/WEB-INF/views/circle-header.jsp"></jsp:include>

<%
	AccountVo vo = (AccountVo)session.getAttribute("vo");

	List<ChatVo> vo_chatlist = vo.getChat_list();
	
	
	//뿌릴 채팅값
	List<ChatVo> select_chat = new ArrayList<ChatVo>();

	
	List<String[]> chated_vo = new ArrayList<String[]>();
	
	//중복제거를 위해 사용함.
	Set<String> chat_voSet = new HashSet<String>();
	
	
	
	String user = vo.getId();
	
	for(int i=0; i<vo_chatlist.size(); i++){
		
		String anotherUser = "";
		int tf = 0;
		
		if(vo_chatlist.get(i).getS_id().equals(user)){
			anotherUser = vo_chatlist.get(i).getG_id();
		}else if(vo_chatlist.get(i).getG_id().equals(user)){
			anotherUser = vo_chatlist.get(i).getS_id();
		}
		
		int count = 0;
		
		Iterator it = chat_voSet.iterator();

		while(it.hasNext()){
			if(it.next().equals(anotherUser)){
				count++;
			}
		}
		
		if(count == 0){
			select_chat.add(vo_chatlist.get(i));
%>
		<script type="text/javascript">
			console.log("<%=vo_chatlist.get(i) %>")
		</script>
<%			
		}
		chat_voSet.add(anotherUser);
	}
	
%>
  
	 <!-- ==============================================
	 Modal Section
	 =============================================== -->
     <section class="chat">
	  <div class="container">
	   <div class="row">
	   
        <div class="messages-box">
		 <div class="row">
		  <div class="col-lg-4 col-md-12 no-pdd">
		   <div class="messages-container">
		   
			<div class="message-header">
			 <div class="message-title">
			  <h4>Messages</h4>
			 </div><!--/ message-title-->
             <div class="search-area">  
              <div class="input-field">
               <input placeholder="Search" type="text">
               <i class="fa fa-search"></i>
              </div>
             </div><!--/ search-area-->			 
			</div><!--/ message-header-->
								
			<div class="messages-list">
			  <ul>
<!--  -->
			<c:choose>
				<c:when test="<%=select_chat.isEmpty() %>">
					<li>
					<div class="user-message-details">
					 <div class="user-message-img">
					 </div>
					 <div class="user-message-info">
				  	  <h4> </h4>
					  <p>채팅 내역이 없습니다.</p>
					  <span class="time-posted"></span>
				     </div><!--/ user-message-info -->
				    </div><!--/ user-message-details -->
				   </li>	
				</c:when>
				<c:otherwise>
					<c:set var="userid" value="<%=vo.getId() %>"></c:set>
					<c:forEach var="chatvo" items="<%=select_chat %>">
						<li>
						<div class="user-message-details" id="${(chatvo eq chatvo.s_id) ? chatvo.g_id : chatvo.s_id }" onclick="change_chatroom(this.id);">
						 <div class="user-message-img">
						  <img src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${chatvo.s_id }/image.jpg" class="img-responsive img-circle" alt="">
						 </div>
						 <div class="user-message-info">
						  <h4>${(chatvo eq chatvo.s_id) ? chatvo.g_id : chatvo.s_id }</h4>
						  <p>${chatvo.chat_content }</p>
						  <span class="time-posted"><fmt:formatDate value="${chatvo.chat_regdate }"/></span>
					     </div><!--/ user-message-info -->
					    </div><!--/ user-message-details -->
					   </li>	
					</c:forEach>
				</c:otherwise>
			</c:choose>
						
			  </ul>
			</div><!--/ messages-list -->
			
		   </div><!--/ messages-container-->
		  </div><!--/ col-lg-4 -->
		  
		  
		  <div class="col-lg-8 col-md-12 pd-right-none pd-left-none">
		   <div class="conversation-box">
		   
			<div class="conversation-header">
			 <div class="user-message-details">
			  <div class="user-message-img" style="margin: 0 0 2% 0;">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" class="img-responsive img-circle" id="nchat_img">
			  </div>
			  <div class="user-message-info" style="padding-left:2%; padding-top: 2%">
			   <h4 id="nchat_name">Please choice chat room</h4>
			   <!-- 
			    <p>Online</p>
			    -->
			  </div><!--/ user-message-info -->
			 </div><!--/ user-message-details -->
			 <!-- 			 
			 <a href="#" title=""><i class="fa fa-ellipsis-v"></i>?????????????</a>
			  -->
			</div><!--/ conversation-header -->
			
<script type="text/javascript">
	//목록 클릭시 그 상대방과 대화한 리스트 DB 에서 가져와 뿌리기
	function change_chatroom(anotheruser){
		
		var userid = "<%=vo.getId() %>";
		var otherid = anotheruser;
		console.log('otherid : '+otherid);

		$.ajax({
			
			type:'post',
			url:'change_chatroom.do',
			data:JSON.stringify(otherid),
			contentType:'application/json',
			dataType:'json',
			success : function(data){
				console.log("success");	
				
				var chatlist = data.chatlist;
				console.log(chatlist)
				
				//사진, 이름 바꾸기
				var srctag = "<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"+otherid+"/image.jpg";
				$("#nchat_img").attr("src",srctag);
				$("#nchat_name").html("");
				$("#nchat_name").html(otherid);
				
				
				//채팅뿌려주기
				$("#nchat_space").html("");
				var tagset = "";
				
				for(var i=0; i<chatlist.length ; i++){
					
					var chatvo = chatlist[i	];
					
					if(chatvo.s_id == userid){
						
						tagset += "<div class='convo-box pull-right'><div class='convo-area pull-right'><div class='convo-message'><p>"
									+chatvo.chat_content+"</p></div><span>"+getFormatDate(new Date(chatvo.chat_regdate))+
									"</span></div><div class='convo-img'><img src='<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"
									+chatvo.s_id+"/image.jpg' class='img-responsive img-circle'></div></div>";
									
					}else{
						
						tagset += "<div class='convo-box convo-left'><div class='convo-area convo-left'><div class='convo-message'><p>"
						  			+chatvo.chat_content+"</p></div><span>"
						   			+getFormatDate(new Date(chatvo.chat_regdate))
						  			+"</span></div><div class='convo-img'><img src='<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"
									+chatvo.s_id+"/image.jpg' class='img-responsive img-circle'></div></div>";
									
					}
					
				}
				
				
				
				$("#nchat_space").append(tagset);
				$("#nchat_space").scrollTop($("#nchat_space")[0].scrollHeight);
				

			},
			error : function(){
				console.log("fail");
			}
			
		});
		
		
		
	}

	


</script>						
			<div class="conversation-container" id="nchat_space">
<!-- 채팅이 들어갈 곳 -->






<!-- 채팅 내용 부분  -->
		<!-- 오른쪽(내가 보낸 메세지) -->
		
			 <div class="convo-box pull-right">
			  <div class="convo-area pull-right">
			   <div class="convo-message">
				<p> zㅋㅋㅋㅋㅋㅋ내가 말한 내용스</p>
			   </div><!--/ convo-message-->
			   <span>채팅 시간</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/2.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->


		<!-- 왼쪽 (상대방이 보낸 메세지) -->
		
			 <div class="convo-box convo-left">
			  <div class="convo-area convo-left">
			   <div class="convo-message">
				<p>상대방이 말한 내용스</p>
			   </div><!--/ convo-message-->
			   <span>채팅 시간</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->




<!--  -->
									
			</div><!--/ conversation-container -->
            <div class="type_messages">  
             <div class="input-field">
              <textarea placeholder="Type something &amp; press enter"></textarea>
			  <ul class="imoji">
			   <li><a href="#"><i class="fa fa-smile"></i></a></li>
			   <li><a href="#"><i class="fa fa-image"></i></a></li>
			   <li><a href="#"><i class="fa fa-paperclip"></i></a></li>
			  </ul><!--/ imoji -->
             </div><!--/ input-field -->
            </div><!--/ type_messages -->
								
           </div><!--main-conversation-box end-->
		  </div><!--/ col-lg-8 -->
		  
		 </div><!--/ row -->
		</div><!--/ messages-box -->	   
	  
      </div><!--/ row -->
      </div><!--/ container -->
     </section><!--/ chat -->	 

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
	
  </body>
</html>
