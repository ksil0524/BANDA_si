<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>
</head>
<body>
<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>

	<!-- ==============================================
	HeaderSection
	=============================================== -->
	<jsp:include page="/WEB-INF/views/circle-header.jsp"></jsp:include>

  
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
			   <li class="active">
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/6.jpg" class="img-responsive img-circle" alt="">
				  <span class="user-online"></span>
				 </div>
				 <div class="user-message-info">
				  <h4>Anthony McCartney</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
				 <span class="message-notification">1</span>
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/10.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Sean Coleman</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/3.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Vanessa Wells</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/4.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Clifford Graham</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/5.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Grace Karen</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/14.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Alex Grantte</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/7.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Anna Morgan</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/8.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Francis Long</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
			   <li>
				<div class="user-message-details">
				 <div class="user-message-img">
				  <img src="<%=request.getContextPath() %>/resources/temp/assets/img/users/9.jpg" class="img-responsive img-circle" alt="">
				 </div>
				 <div class="user-message-info">
				  <h4>Eleanor Harper</h4>
				  <p>Lorem ipsum dolor ...</p>
				  <span class="time-posted">1:55 PM</span>
			     </div><!--/ user-message-info -->
			    </div><!--/ user-message-details -->
			   </li>
										
			  </ul>
			</div><!--/ messages-list -->
			
		   </div><!--/ messages-container-->
		  </div><!--/ col-lg-4 -->
		  
		  <div class="col-lg-8 col-md-12 pd-right-none pd-left-none">
		   <div class="conversation-box">
			<div class="">
			  <video id="localVideo" autoplay playsinline></video>
  			  <video id="remoteVideo" autoplay playsinline></video>
  			  <!-- 
				<img alt="image" src="<%=request.getContextPath()%>/resources/images/animal_icon_c/chicken.png" width="100%">
  			   -->
			</div><!--/ conversation-container -->
            <div class="type_messages">  
             <div class="input-field">
                <button id="startButton">Start</button>
    			<button id="callButton">Call</button>
   				<button id="hangupButton">Hang Up</button>
             <!-- 
              <textarea placeholder="Type something &amp; press enter"></textarea>
			  <ul class="imoji">
			   <li><a href="#"><i class="fa fa-smile"></i></a></li>
			   <li><a href="#"><i class="fa fa-image"></i></a></li>
			   <li><a href="#"><i class="fa fa-paperclip"></i></a></li>
			  </ul><!--/ imoji -->
              -->
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
	
	
	<!-- webRTC -->
	  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
 	  <script src="<%=request.getContextPath() %>/resources/js/main.js"></script>
	
  </body>
</html>
