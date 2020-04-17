

$(function() {
	
	$("#updateBtn").hide();

	//이미지 클릭시 업로드창 실행 (insert)
	
    $("#image_section").click(function() {
    	
        $("#imgInp").click();
    })   
    
            
    $("#imgInp").change(function(){
    	readURL(this);
    });
    
    
    function readURL(input) {
    	if (input.files && input.files[0]) {
    		var reader = new FileReader();
    		
    		reader.onload = function (e) {
    			$('#image_section').attr('src', e.target.result);  
    			$("#imgInp").attr('src', e.target.result);
    		}
    		
    		reader.readAsDataURL(input.files[0]);
    	}
    }
    
    
    ////////////////////////////////////////////
	//이미지 클릭시 업로드창 실행 (update)
    
    $("#updateimage").click(function(){
    	$("#updateimgInp").click();
    })

    /*
    $("#updateimginp").change(function(){
    	readURL2(this);
    });

    
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
    
     */
    
    //////////////////////////////////////////////////////////
    
    
    $(".mypetInsert").click(function(){
    	$("#updateBtn").hide();
    	$("#mypetsUpdate").hide();
    	$("#mypetsDetail").hide();
    	$("#mypetsInsert").show();
    	$("#submitBtn").show();
    	$("#submitBtnch").hide();
    	
    })
    

    $(".mypetListSeq").click(function(){
    	
    	$("#submitBtn").hide();
    	$("#mypetsUpdate").hide();
    	$("#mypetsInsert").hide();
    	$("#mypetsDetail").show();
    	$("#updateBtn").show();
    	$("#submitBtnch").hide();

    })
 
    
    $("#updateBtn").click(function(){
    	$("#updateBtn").hide();
    	$("#mypetsInsert").hide();
    	$("#mypetsDetail").hide();
    	$("#mypetsUpdate").show();
    	$("#submitBtn").hide();
    	$("#submitBtnch").show();

    })
    
    
    $("#category1").on('change',function(){			
		if(this.value == 0){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('0').text("대분류를 선택해주세요."));
		}else if(this.value == 1){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('1').text("개"));
			$("#category2").append($("<option>").val('2').text("고양이"));
			$("#category2").append($("<option>").val('3').text("패럿"));
			$("#category2").append($("<option>").val('4').text("기니피그"));
			$("#category2").append($("<option>").val('5').text("다람쥐,하늘다람쥐"));
			$("#category2").append($("<option>").val('6').text("햄스터"));
			$("#category2").append($("<option>").val('7').text("토끼"));
			$("#category2").append($("<option>").val('8').text("고슴도치"));
			$("#category2").append($("<option>").val('9').text("돼지"));
			$("#category2").append($("<option>").val('10').text("말"));
			$("#category2").append($("<option>").val('11').text("영장류"));
			$("#category2").append($("<option>").val('12').text("원숭이"));
			$("#category2").append($("<option>").val('13').text("여우"));
			$("#category2").append($("<option>").val('14').text("너구리"));
			$("#category2").append($("<option>").val('15').text("사자"));
			$("#category2").append($("<option>").val('34').text("기타"));
		}else if(this.value == 2){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('16').text("앵무새"));
			$("#category2").append($("<option>").val('17').text("닭, 병아리"));
			$("#category2").append($("<option>").val('18').text("오리"));
			$("#category2").append($("<option>").val('19').text("메추라기"));
			$("#category2").append($("<option>").val('20').text("십자매"));
			$("#category2").append($("<option>").val('35').text("기타"));
		}else if(this.value == 3){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('21').text("거북"));
			$("#category2").append($("<option>").val('22').text("도마뱀"));
			$("#category2").append($("<option>").val('23').text("뱀"));
			$("#category2").append($("<option>").val('24').text("개구리, 도롱뇽"));
			$("#category2").append($("<option>").val('36').text("기타"));
		}else if(this.value == 4){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('25').text("물고기"));
			$("#category2").append($("<option>").val('37').text("기타"));
		}else if(this.value == 5){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('26').text("새우"));
			$("#category2").append($("<option>").val('27').text("가재"));
			$("#category2").append($("<option>").val('28').text("게"));
			$("#category2").append($("<option>").val('29').text("거미"));
			$("#category2").append($("<option>").val('38').text("기타"));
		}else if(this.value == 6){
			$("#category2").html(" ");
			$("#category2").append($("<option>").val('31').text("달팽이"));
			$("#category2").append($("<option>").val('32').text("문어"));
			$("#category2").append($("<option>").val('33').text("해파리"));
			$("#category2").append($("<option>").val('39').text("기타"));
		}
		});
		
		
    
	/*
	 * */ 
	//selectbox 설정 : class 셀렉트시 class에 맞게 species 가 변하게 수정하게 하는 script 부분

		$("#update_category1").on('change',function(){			
		if(this.value == 0){
			$("#update_category2").html(" ");
			$("#update_category2").append($("<option>").val('0').text("대분류를 선택해주세요."));
		}else if(this.value == 1){
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
		}else if(this.value == 2){
			$("#update_category2").html(" ");
			$("#update_category2").append($("<option>").val('16').text("앵무새"));
			$("#update_category2").append($("<option>").val('17').text("닭, 병아리"));
			$("#update_category2").append($("<option>").val('18').text("오리"));
			$("#update_category2").append($("<option>").val('19').text("메추라기"));
			$("#update_category2").append($("<option>").val('20').text("십자매"));
			$("#update_category2").append($("<option>").val('35').text("기타"));
		}else if(this.value == 3){
			$("#update_category2").html(" ");
			$("#update_category2").append($("<option>").val('21').text("거북"));
			$("#update_category2").append($("<option>").val('22').text("도마뱀"));
			$("#update_category2").append($("<option>").val('23').text("뱀"));
			$("#update_category2").append($("<option>").val('24').text("개구리, 도롱뇽"));
			$("#update_category2").append($("<option>").val('36').text("기타"));
		}else if(this.value == 4){
			$("#update_category2").html(" ");
			$("#update_category2").append($("<option>").val('25').text("물고기"));
			$("#update_category2").append($("<option>").val('37').text("기타"));
		}else if(this.value == 5){
			$("#update_category2").html(" ");
			$("#update_category2").append($("<option>").val('26').text("새우"));
			$("#update_category2").append($("<option>").val('27').text("가재"));
			$("#update_category2").append($("<option>").val('28').text("게"));
			$("#update_category2").append($("<option>").val('29').text("거미"));
			$("#update_category2").append($("<option>").val('38').text("기타"));
		}else if(this.value == 6){
			$("#update_category2").html(" ");
			$("#update_category2").append($("<option>").val('31').text("달팽이"));
			$("#update_category2").append($("<option>").val('32').text("문어"));
			$("#update_category2").append($("<option>").val('33').text("해파리"));
			$("#update_category2").append($("<option>").val('39').text("기타"));
		}
		});
    
})
