/*
   Radius by TEMPLATED
   templated.co @templatedco
   Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
*/

var isLogin = 0;
var isjoin   =0;

function loginChk(){
   var email = $("#login-email").val().trim();
   var pw = $("#login-password").val().trim();
   
   var login_set = {
         "id":email,
         "password":pw         
   };
   
   $.ajax({
      
      url : "jy_login.do",
      type : "post",
      data : JSON.stringify(login_set),
      contentType: "application/json",
      dataType:"json",
      success : function(msg){
         
         if(msg.chk){
         isLogin = 1;
         $(".closeBtn").hide();
         $("#logincontent").hide();
         $("#header").toggleClass('hide');
         $("#content").hide();
         $("#error_login").css("display","none");
         
         location.href = "index.jsp";
         
         } else {
            
            $("#error_login").css("display", "block");
            $("#error_login").html(msg.msg);
            
            return;
         }
         
      },
      error:function(request,status,error){
         

      }
      
   });
}

function logout(){
   
   $.ajax({
      
      url : "logout.do",
      type : "post",
      success : function(data){
         
         if(data.chk){
            isLogin = 0;
            alert("로그아웃성공");
            location.href = "index.jsp";
         } 
         
      },
      error : function(request,status,error){
         
      }
      
   });
}

function joinUser(){
   $("#logincontent").hide();
   $("#joincontent").show();
}



//id 중복체크 placeholder 변경 ajax
$("#id").blur(function(){
   var id = $("#joinForm #id").val();

   var id_set = {
         "id":id,
   }; 
   
   
   //영문자 숫자 4~10
   var loginIdRex =  /^[a-z0-9]{4,10}$/g;

   if(!loginIdRex.test(id)){
   
      
      isjoin++;
      $("#id").val("");
      $("#id").attr("placeholder","id는 숫자,소문자 4~10자리만 입력가능합니다.");
      $("#id").css({"font-size":"12px"})
      return false;
   }
   
   //isjoin = 0;
   
   $.ajax({
      url: "idoverlab.do",
      type:"post",
      data: JSON.stringify(id_set),
      contentType:"application/json",
      dataType:"json",
      success : function(msg){
         
         var rres = msg.res;
      
         
         if(rres){
            $("#id").val("");
            $("#id").attr("placeholder","아이디가 중복되었습니다.");
         }
      }, 
      error:function(request,status,error){
            

         }
   });
});
//비밀번호 4~10글자 영소 숫자
$("#password").blur(function(){
   var id = $("#joinForm #password").val();
   //영문자 숫자 4~10
   var loginIdRex =  /^[a-z0-9]{4,10}$/g;

   if(!loginIdRex.test(id)){
   
      
      isjoin++;
      $("#password").val("");
      $("#password").attr("placeholder","숫자,소문자 4~10자리만 입력해주세요.");
      $("#password").css({"font-size":"10px"})
      return false;
   }
   
})
function inputPhoneNumber(obj) {



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
//비밀번호 4~10글자 영소 숫자
$("#email").blur(function(){
   var id = $("#joinForm #email").val();
   //영문자 숫자 4~10
   
   var id_set = {
         "email":id
   }; 
   
   var loginIdRex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[0-9a-zA-Z]$/i;
   
   if(!loginIdRex.test(id)){
   
      isjoin++;
      $("#email").val("");
      
      $("#email").attr("placeholder","이메일 형식으로 입력해주세요");
      $("#email").css({"font-size":"10px"})
      return false;
   }else{
      
      $.ajax({
         url: "emailoverlab.do",
         type:"post",
         data: JSON.stringify(id_set),
         contentType:"application/json",
         dataType:"json",
         success : function(msg){
            
            var rres = msg.res;
         
            
            if(rres){
               $("#email").val("");      
               $("#email").attr("placeholder","e-mail이 중복되었습니다.");
            }
         }, 
         error:function(request,status,error){
               

            }
      });
      
      
   }
   
})
$("#phone").blur(function(){
   var id = $("#joinForm #phone").val();
   
   var loginIdRex = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;

   if(!loginIdRex.test(id)){
   
      
      isjoin++;
      $("#phone").val("");
      
      $("#phone").attr("placeholder","010-0000-0000 형식으로 입력해주세요");
      $("#phone").css({"font-size":"10px"})
      return false;
   }
   
})
//id 중복체크로 변경된 placeholder 제자리
$("#phone").focus(function(){
   $("#phone").attr("placeholder","phone")
   $("#phone").css({"font-size":"16px"})
})
//id 중복체크로 변경된 placeholder 제자리
$("#email").focus(function(){
   $("#email").attr("placeholder","email")
   $("#email").css({"font-size":"16px"})
})
//id 중복체크로 변경된 placeholder 제자리
$("#id").focus(function(){
   $("#id").attr("placeholder","Id")
   $("#id").css({"font-size":"16px"})
})
//password 중복체크로 변경된 placeholder 제자리
$("#password").focus(function(){
   $("#password").attr("placeholder","password")
   $("#password").css({"font-size":"16px"})
})




function joinChk(){
   var email = $("#joinForm #email").val();
   var id = $("#joinForm #id").val();
   var pw = $("#joinForm #password").val();
   var phone = $("#joinForm #phone").val();
   


    //010-3013-7673형식
 
   var register_set = {
         "email":email,
         "password":pw,
         "id":id,
         "phone":phone
   }; 
   
   
   /* 정규식 및 데이터 입력 체크 - login 담당 */
   if(email === null || email === '' || id === null || id === '' || pw === null || pw === '' || phone === null || phone === ''){
      alert("정보를 모두 입력하세요.");
   }else{

      $.ajax({
         url: "joinregister.do",
         type:"post",
         data: JSON.stringify(register_set),
         contentType:"application/json",
         dataType:"json",
         success : function(msg){
            
            if(msg.res){
               alert("가입 완료 되었습니다");
               
               $("#isLogin").hide();
               $(".closeBtn").hide();
               $("#logOut").hide();
               $("#header").toggleClass('hide');
               $("#testlogo").hide();
               $("#content").show();
               $("#joincontent").hide();
               
               $("#joinForm #email").val("");
               $("#joinForm #id").val("");
               $("#joinForm #password").val("");
               $("#joinForm #phone").val("");
            }else{
               alert("가입 실패");
               $("#joincontent").show();
               $(".closeBtn").show();
               $("#logincontent").hide();
               $("#content").hide();
            }
            
         }, 
         error:function(request,status,error){
         }
      });
      
   }

   



}

function close(){
   $("#testlogo").hide();
   $("#isLogin").hide();
   $(".closeBtn").hide();
   $("#logOut").hide();
   $("#logincontent").hide();
   $("#joincontent").hide();
   $("#header").toggleClass('hide');
   
}

(function($) {

   
   var session = $("#hidden_session").val();
   console.log(session);

   if(session == 'AccountVo') {
      
      isLogin = 1;
      $(".closeBtn").hide();
      $("#logincontent").hide();
      $("#header").toggleClass('hide');
      $("#content").hide();
      $("#loginchk").css("display","none");
      
   } else {
      
   }
   
   skel.breakpoints({
      xlarge:   '(max-width: 1680px)',
      large:   '(max-width: 1280px)',
      medium:   '(max-width: 980px)',
      small:   '(max-width: 736px)',
      xsmall:   '(max-width: 480px)'
   });
   
   $(function() {

      
      
      var   $window = $(window),
         $body = $('body'),
         $header = $('#header'),
         $footer = $('#footer');

      // Disable animations/transitions until the page has loaded.
         $body.addClass('is-loading');

         $window.on('load', function() {
            window.setTimeout(function() {
               $body.removeClass('is-loading');
            }, 100);
         });

      // Fix: Placeholder polyfill.
         $('form').placeholder();

      // Prioritize "important" elements on medium.
         skel.on('+medium -medium', function() {
            $.prioritize(
               '.important\\28 medium\\29',
               skel.breakpoint('medium').active
            );
         });

      // Header.
         $header.each( function() {

            var t       = jQuery(this),
               button    = t.find('.button');

            button.click(function(e) {
               
               if(isLogin==0){
                  
                  $("#content").show();
                  $("#testlogo").show();
                  if($(this).attr("id")=="loginBtn"){
                     $("#content").hide();
                     $(".closeBtn").show();
                     $("#logincontent").show();
                     $("#login-email").val("");
                     $("#login-password").val("");
                  }else if($(this).attr("id")=="feedBtn"){
                     $("#testlogo").hide();
                     t.toggleClass('hide');
                  }else{
                     t.toggleClass('hide');
                  }

                  if ( t.hasClass('preview') ) {
                     return true;
                  } else {
                     e.preventDefault();
                  }
                  
               }else{
                  $("#header").toggleClass('hide');
                  $("#logOut").show();
                  $(".closeBtn").show();
                  $("#isLogin").show();
               }
            });

         });
      // Footer.
         $footer.each( function() {

            var t       = jQuery(this),
               inner    = t.find('.inner'),
               button    = t.find('.info');

            button.click(function(e) {
               t.toggleClass('show');
               e.preventDefault();
            });

         });
      $("#closeBtn").click(function(){
         close();
      })

      $("#logOut").click(function(){
         
         $("#isLogin").hide();
         $(".closeBtn").hide();
         $("#logOut").hide();
         $("#header").toggleClass('hide');
         isLogin = 0;
      })
      
      searchFunction = function(){
            
            // 라디오버튼 값 가져옴
            var category = $('input[name="jh_searchtype"]:checked').val(); 
            // 텍스창 값
            var keyword = $("#searchinput").val();
                  
            if(category == null){
               
               alert("카테고리를 선택해주세요");
               
            } else if(keyword == null || keyword == ""){
               
               alert("검색어를 입력해주세요");
               
            } else {
               location.href="circleheader_searchindex.do?category="+category+"&keyword="+keyword;
            }
         
      }
      
      
      
   });


    
})(jQuery);

$(document).ready(function(){
   $('#back-to-top').hide();
    $(window).scroll(function () {
           if ($(this).scrollTop() > 50) {
               $('#back-to-top').fadeIn();
           } else {
               $('#back-to-top').fadeOut();
           }
       });
       // scroll body to 0px on click
       $('#back-to-top').click(function () {
           $('#back-to-top').tooltip('hide');
           $('body,html').animate({
               scrollTop: 0
           }, 800);
           return false;
       });
       
       $('#back-to-top').tooltip('show');
       // 하기싫습니다.......집에 보내주세요....... 우리조원은 왜 학원을 안나오는 걸까요....
       
});


