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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>

<%
	AccountVo vo = (AccountVo)session.getAttribute("vo");
	List<String> id_list = (ArrayList<String>)session.getAttribute("id_list");	


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

	<link rel="stylesheet"href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- index_circle_custom CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">
	
	<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>

	<!-- 
	 ip바꿔주기
	 -->
	<script src="http://192.168.30.28:3000/socket.io/socket.io.js"></script>

	
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





<ul id="messages"></ul>


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
               <input placeholder="Search" type="text" id="searchid">
               <i class="fa fa-search" onclick="search();"></i>
              </div>
             </div><!--/ search-area-->			 
			</div><!--/ message-header-->
								
			<div class="messages-list">
			  <ul id="chat_ul">
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
						<div class="user-message-details" id="${(userid eq chatvo.s_id) ? chatvo.g_id : chatvo.s_id }" onclick="change_chatroom(this.id);">
						 <div class="user-message-img">
						  <img src="<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/${chatvo.s_id }/image.jpg" class="img-responsive img-circle" alt="">
						 </div>
						 <div class="user-message-info">
						  <h4>${(userid eq chatvo.s_id) ? chatvo.g_id : chatvo.s_id }</h4>
						  <p id="${(userid eq chatvo.s_id) ? chatvo.g_id : chatvo.s_id }_ptag">${(fn:length(chatvo.chat_content)<6) ? chatvo.chat_content : fn:substring(chatvo.chat_content,0,5)}...</p>
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
			   <img src="" class="img-responsive img-circle" id="nchat_img">
			  </div>
			  <div class="user-message-info" id="nchat_namediv" style="padding-left:30%; padding-top: 2%">
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
//ip바꿔주기

var uid = "<%=vo.getId()%>";
var oid = "otherId";

//현재 대화중인 사람의 아이디
var aotherid = "";
 
var nowRnum = 0;
  
const name = "<%=vo.getId() %>";
const socket = io("http://192.168.30.28:3000");
let room = ['room0'];
let num = 0;

socket.emit('joinRoom', num, name);

////////
$('select').change(function() {
 // socket.emit('makeRoom', uid, oid);
  socket.emit('leaveRoom', num, name);
  num++;
  num = num % 2;
  socket.emit('joinRoom', num, name);
});

socket.on('leaveRoom', function(num, name){
//  $('#messages').append($('<li>').text(name + '    leaved '
//    + room[num] + ' :('));
	console.log("leaveRoom");
});

socket.on('joinRoom', function(num, name){
//  $('#messages').append($('<li>').text(name + '    joined '
//    + room[num] + ':)'));
	console.log("joinRoom");

});
////////

$('#chatform').submit(function() {
	  return false;
});


socket.on('chat message', function(name, msg) {
  //$('#messages').append($('<li>').text(name + '  :  ' +
  //  msg));
  console.log("now aotherid : "+aotherid);
  write(name,msg);
  change_li(name, msg);
});

socket.on('change_litag', function(s_id, g_id, msg){
	
	var nowuser = "<%=vo.getId()%>";
	
	if(g_id == nowuser){
		change_li(s_id, msg);
	}
	
});

socket.on('passRoomNum', function(changedRname ,changedRnum){
	nowRnum = changedRnum;
	var rnum = changedRnum;
    joinroom(rnum,name);
});

socket.on('ontext', function(userid, textY){
	var yn = textY;
	var nowuser = "<%=vo.getId()%>";
	if(nowuser != userid && yn == 'y'){
		var textloadingtag = $("#textloading").val();
		if(textloadingtag == null){
			var tag = "<div class='convo-box convo-left' id='textloadingdiv'><input type='hidden' value='y' id='textloading'>"
						+"<div class='convo-area convo-left'><div class='convo-message'>"
						+"<img alt='chationg' src='<%=request.getContextPath() %>/resources/images/filemanager/chat/chating.gif' height='60px;' style='border-radius: 70%;'></div><span></span>"
			  			+"</div><div class='convo-img'><img src='<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"
			  			+aotherid+"/image.jpg' alt='' class='img-responsive img-circle'>"
			  			+"</div></div></div>";
			$("#nchat_space").append(tag);
			$("#nchat_space").scrollTop($("#nchat_space")[0].scrollHeight);
		}else if(textloadingtag == 'y'){
			console.log("이미 있어염")
		}
	}
})

socket.on('offtext', function(userid, textN){
	var yn = textN;
	var nowuser = "<%=vo.getId()%>";
	if(nowuser != userid && yn == 'n'){
		var textloadingtag = $("#textloading").val();
		if(textloadingtag == null){
			console.log("이미 없어염")
		}else if(textloadingtag == 'y'){
			console.log("삭제!");
			$("#textloadingdiv").remove();
		}
	}
})



function makeroom(id1, id2){
	socket.emit('leaveRoom', nowRnum, name);
    socket.emit('makeRoom', id1, id2);
}

function joinroom(rnum, nameid){
	console.log("rnum : "+rnum);
    socket.emit('joinRoom', rnum, nameid);

}

function ontexty(nowuserid, textY){
	socket.emit('ontext', nowRnum, nowuserid, textY);
}

function offtextn(nowuserid, textN){
	socket.emit('offtext', nowRnum, nowuserid, textN);
}

function change_li(userid, msg){
	var id = "#"+userid;
	//해당하는 채팅 리스트가 있는지 확인
	var fyn = $(id).length;
	console.log("fyn : "+fyn);
	
	if(fyn == 0 && userid != "<%=vo.getId()%>"){
		
		var tag = "<li><div class='user-message-details' id='"+ userid +"' onclick='change_chatroom(this.id);'><div class='user-message-img'>"
				  +"<img src='<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"+userid+"/image.jpg' class='img-responsive img-circle' alt=''>"
		 	  	  +"</div><div class='user-message-info'><h4>"+userid
				  +"</h4><p id='"+userid+"_ptag'>"+msg+"</p><span class='time-posted'></span></div></div></li>";
		
		
		//$("#chat_ul").append(tag);
		$("#chat_ul").children().eq(0).before(tag);

	}else{
	
		var ptagid = "#"+userid+"_ptag";
		$(ptagid).text(msg.substring(0,5)+"...");
		
		//closest 가장 가까운 부모 태그
		var litag = $(id).closest("li");
		$("#chat_ul").children().eq(0).before(litag);

	}
}

function gochat(){
	//ip바꿔주기
	var s_id = "<%=vo.getId()%>";
	var g_id = aotherid;
	var chat_content = $('#chat_content').val();
	var chat_fyn = 'N';
	
	var data = {s_id : s_id, g_id : g_id, chat_content : chat_content};
	
	$.ajax({
		type:'post',
		url:'insertchat.do',
		data:JSON.stringify(data),
		contentType:'application/json',
		dataType:'json',
		success:function(data){
			console.log("success");
		},
		error:function(){
			console.log("fail gochat()");
		}
		
	});
	
	socket.emit('chat message', nowRnum, name, $('#chat_content').val());
	$('#chat_content').val('');
	
	socket.emit('change_litag', s_id, g_id, chat_content);
	change_li(g_id, chat_content);
	
}

	//목록 클릭시 그 상대방과 대화한 리스트 DB 에서 가져와 뿌리기
function change_chatroom(anotheruser){
	
	var userid = "<%=vo.getId() %>";
	var otherid = anotheruser;
	aotherid = anotheruser;
	//console.log('otherid : '+otherid);
		$.ajax({
		
		type:'post',
		url:'change_chatroom.do',
		data:JSON.stringify(otherid),
		contentType:'application/json',
		dataType:'json',
		success : function(data){
			console.log("success");	
			
		    //socket.emit('makeRoom', userid, otherid);
		    
		    arrayid = [userid, otherid];
		    arrayid.sort();
		    console.log("sort() 후 arrayid : "+arrayid) 
			    makeroom(arrayid[0], arrayid[1]);
		    
			var chatlist = data.chatlist;
			//console.log(chatlist)
			
			//사진, 이름 바꾸기
			$("#nchat_namediv").css('padding-left','2%');
			var srctag = "<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"+otherid+"/image.jpg";
			$("#nchat_img").attr("src",srctag);
			$("#nchat_name").html("");
			$("#nchat_name").html(otherid);
			
			//채팅뿌려주기
			$("#nchat_space").html("");
			var tagset = "";
			
			if(chatlist == null){
				
				tagset += "<div class='convo-box pull-right'><div class='convo-area pull-right'><div class='convo-message' style='float:right;'><p style='padding:10px 10px 10px 10px; width:80%; text-align:center;'>"
							+"</p></div><span>"
							+"</span></div><div class='convo-img'></div></div>";
							
				tagset += "<div class='convo-box convo-left'><div class='convo-area convo-left'><div class='convo-message'><p>"
		  					+"</p></div><span>"
		   					+"</span></div><div class='convo-img'></div></div>";
				
				
			}else{
				
				for(var i=0; i<chatlist.length ; i++){
					
					var chatvo = chatlist[i	];
					
					if(chatvo.s_id == userid){
						tagset += "<div class='convo-box pull-right'><div class='convo-area pull-right'><div class='convo-message' style='float:right;'><p style='padding:10px 10px 10px 10px; width:80%; text-align:center;'>"
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
			}
			
			$("#nchat_space").append(tagset);
			$("#nchat_space").scrollTop($("#nchat_space")[0].scrollHeight);
		},
		error : function(){
			console.log("fail");
		}
	});		
	
}
  
function write(name, msg){
	var tagset = "";
	var date = new Date();
	
	var userid = "<%=vo.getId()%>";
	
	if(name == userid){
		tagset = "<div class='convo-box pull-right'><div class='convo-area pull-right'><div class='convo-message' style='float:right;'><p style='padding:10px 10px 10px 10px; width:80%; text-align:center;'>"
								+msg+"</p></div><span>"+date.getHours()+":"+date.getMinutes()+
								"</span></div><div class='convo-img'><img src='<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"
								+name+"/image.jpg' class='img-responsive img-circle'></div></div>";		
	}else{
		tagset = "<div class='convo-box convo-left'><div class='convo-area convo-left'><div class='convo-message'><p>"
  				+msg+"</p></div><span>"
   				+date.getHours()+":"+date.getMinutes()
	  			+"</span></div><div class='convo-img'><img src='<%=request.getContextPath() %>/resources/images/filemanager/account/account_profile/"
				+name+"/image.jpg' class='img-responsive img-circle'></div></div>";
	}
		
	$("#nchat_space").append(tagset);
	$("#nchat_space").scrollTop($("#nchat_space")[0].scrollHeight);
}

</script>
			
			<div class="conversation-container" id="nchat_space">
<!-- 채팅이 들어갈 곳 -->


<!-- 채팅 내용 부분  -->
		<!-- 오른쪽(내가 보낸 메세지) -->
			 <div class="convo-box pull-right">
			  <div class="convo-area pull-right">
			   <div class="convo-message">
			   </div><!--/ convo-message-->
			  </div><!--/ convo-area -->
			  <div class="convo-img">
			  </div><!--/ convo-img -->
			 </div><!--/ convo-box -->


		<!-- 왼쪽 (상대방이 보낸 메세지) -->
			 <div class="convo-box convo-left" >
			 <input type="hidden" value="y" id="textloading">
			  <div class="convo-area convo-left">
			   <div class="convo-message">
			   </div>
			  </div>
			  <div class="convo-img">
			  </div>
			 </div>
			</div>

<!--  -->
<script type="text/javascript">
$(function(){
	
	var id_list = [];
	
	<%
		for(int i=0; i<id_list.size() ; i++){	
	%>
		id_list.push("<%=id_list.get(i)%>");
	<%		
		}
	%>    	
	
	$('#chatform').submit(function() {
		  return false;
	});
	
	$("#chat_content").on('keypress',function(event){
        
		if(event.keyCode ==13){
            gochat();
        	$('#chat_content').val('');
        	return false;
        }
		
    });
	
	$("#chat_content").on('keyup',function(event){
		
		var textvalue = $("#chat_content").val();
		var nowuserid = "<%=vo.getId()%>";
		
		if(textvalue != ''){
			var textY = 'y';
			ontexty(nowuserid, textY);
		}else if(textvalue == ''){
			var textN = 'n';
			offtextn(nowuserid, textN);
		}
		
	});
	
	//자동완성 기능
	// 글자 순서대로 검색: matchContains: true / 입력한 글자가 들어간 모든 검색어를 보여주기: matchContains: false
	$("#searchid").autocomplete({
        source : id_list,    // source 는 자동 완성 대상
		matchContains: true,
		select : function(event, ui) {    //아이템 선택시
            console.log(ui.item.value);
			//선택시 채팅창 바꾸기	
			var newuserid = ui.item.value;
            change_chatroom(newuserid);
        },
        focus : function(event, ui) {    //포커스 가면
            return false;//한글 에러 잡기용도로 사용됨
        },
        minLength: 1,// 최소 글자수
        autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
        classes: {    //잘 모르겠음
            "ui-autocomplete": "highlight"
        },
        delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
						//disabled: true, //자동완성 기능 끄기
        position: { my : "right top", at: "right bottom" },    //잘 모르겠음
        close : function(event){    //자동완성창 닫아질때 호출
//            console.log(event);
        	$("#searchid").val('');
        }
	});
	
})

</script>
            <form name="chatform" id="chatform" method="post">
	            <div class="type_messages">  
	             <div class="input-field">
	             <!-- 
					  <input id="chat_content" autocomplete="off"  placeholder="Type something &amp; press enter"/>
	              -->	             
	              <textarea id="chat_content" placeholder="Type something &amp; press enter"></textarea>
				  <ul class="imoji">
				  	<li>
	  					<button onclick="gochat();">Send</button>				  	
				  	</li>
				  	<!-- 
					   <li><a href="#"><i class="fa fa-smile"></i></a></li>
					   <li><a href="#"><i class="fa fa-image"></i></a></li>
					   <li><a href="#"><i class="fa fa-paperclip"></i></a></li>
				  	 -->
				  </ul><!--/ imoji -->
	             </div><!--/ input-field -->
	            </div><!--/ type_messages -->
			</form>          
								
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
