<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
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
						<div class="user-message-details">
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
			  <div class="user-message-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" class="img-responsive img-circle" alt="" id="nchat_img">
			  </div>
			  <div class="user-message-info">
			   <h4 id="nchat_name">John Doe</h4>
			   <!-- 
			    <p>Online</p>
			    -->
			  </div><!--/ user-message-info -->
			 </div><!--/ user-message-details -->
			 <a href="#" title=""><i class="fa fa-ellipsis-v"></i>?????????????</a>
			</div><!--/ conversation-header -->
			
			<div class="conversation-container">







<!--  -->

			 <div class="convo-box pull-right">
			  <div class="convo-area">
			   <div class="convo-message">
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor.</p>
			   </div><!--/ convo-message-->
			   <span>Sat, Aug 23, 1:08 PM</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/2.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->

			 <div class="convo-box convo-left">
			  <div class="convo-area convo-left">
			   <div class="convo-message">
				<p>Cras ultricies ligula.</p>
			   </div><!--/ convo-message-->
			   <span>5 minutes ago</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->





<!-- 




 -->

			 <div class="convo-box pull-right">
			  <div class="convo-area">
			   <div class="convo-message">
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor.</p>
			   </div><!--/ convo-message-->
			   <span>Sat, Aug 23, 1:08 PM</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/2.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->

			 <div class="convo-box convo-left">
			  <div class="convo-area convo-left">
			   <div class="convo-message">
				<p>Cras ultricies ligula.</p>
			   </div><!--/ convo-message-->
			   <span>5 minutes ago</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->

			 <div class="convo-box pull-right">
			  <div class="convo-area">
			   <div class="convo-message">
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor.</p>
			   </div><!--/ convo-message-->
			   <span>Sat, Aug 23, 1:08 PM</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/2.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->

			 <div class="convo-box convo-left">
			  <div class="convo-area convo-left">
			   <div class="convo-message">
				<p>Lorem ipsum dolor sit amet</p>
			   </div><!--/ convo-message-->
			   <span>2 minutes ago</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->

			 <div class="convo-box pull-right">
			  <div class="convo-area">
			   <div class="convo-message">
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor.</p>
			   </div><!--/ convo-message-->
			   <span>Sat, Aug 23, 1:08 PM</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/2.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->

			 <div class="convo-box convo-left">
			  <div class="convo-area convo-left">
			   <div class="convo-message">
				<p>Typing...</p>
			   </div><!--/ convo-message-->
			   <span>2 minutes ago</span>
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			   <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" alt="" class="img-responsive img-circle">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->
									
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
	Scripts
	=============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
	
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
