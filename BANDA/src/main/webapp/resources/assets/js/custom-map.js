
/***********************************
 검색어
 ***********************************/
$(function(){
	/* mapcate set */
	var mapcate = $("#mapcate").val();
	/* 검색어 자동완성 */
	$("#searchInput").autocomplete({
		source: function(request, response){
			$.ajax({
				type:"post",
				url:"map_autocompleteAjax.do",
				data:{keyword: request.term, mapcate: mapcate},
				dataType:"json",
				success: function(result){
					/* Test Code*/
					if(result.success==true){
						response(
							$.map(result.list, function(item){
								return{
									label:item,
									value:item
								}
							})
						)
					}
				},
				error: function(){
					alert("서버와 통신에 실패하였습니다. 다시 시도해주세요.");
				}
			})//ajax end
		},//source end
		minLength:1,
		select:function(event, ui){
		}
	}); //autocomplete end
	

	
	/*city select box default set*/
	city_selbox_set();
	dist_selbox_set();
	neig_selbox_set();
	
	/* city_selbox 초기화 */
	function city_selbox_set(){
		$("#city_selbox").append("<option value='' disabled selected>&nbsp;&nbsp;::시/도 선택::</option>");
		$.getJSON("resources/assets/json/administrativeArea.json",function(data){
			$.each(data, function(key, val){
				if(key=="city"){
					var list = val;
					for(var i=0; i<list.length; i++){
						$("#city_selbox").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
					}
					customSelect("custom-select");
				}
			});
		});
	}
	
	/* dist_selbox 초기화 */
	function dist_selbox_set(){
		$("#dist_selbox").append("<option value='' disabled selected>&nbsp;&nbsp;::구/군 선택::</option>");
		customSelect("custom-select2");
	}
	
	/* neig_selbox 초기화 */
	function neig_selbox_set(){
		$("#neig_selbox").append("<option value='' disabled selected>&nbsp;::읍/면/동 선택::</option>");
		customSelect("custom-select3");
	}

});//function

/***********************************
  select box
***********************************/
function customSelect(customTarget){
	var x, i, j, selElmnt, a, b, c;
	
	/* custom-select/custom-select2 클래스 엘리먼트 get */
	x = document.getElementsByClassName(customTarget);

	for (i = 0; i < x.length; i++) {
		/* city_selbox/ dist_selbox 리스트 get */
		selElmnt = x[i].getElementsByTagName("select")[0];
		
		/* div(Add Class) 생성 */
		a = document.createElement("DIV");
		a.setAttribute("class", "select-selected");
		a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
		x[i].appendChild(a);
		
		
		/* option list div(Add Class/Id) 생성 */
		b = document.createElement("DIV");
		b.setAttribute("class", "select-items select-hide");
		b.setAttribute("id", "style-1");
		
		for (j = 0; j < selElmnt.length; j++) {
			/* 원본 요소의 각 옵션에 대한  div 생성*/
			c = document.createElement("DIV");
			c.innerHTML = selElmnt.options[j].innerHTML;
			c.addEventListener("click",function(e) {
				
				/* 기존 selected option 해제*/
				if (customTarget == "custom-select") {
					$("#city_selbox option:selected").attr('selected', false);
				} else if(customTarget == "custom-select2"){
					$("#dist_selbox option:selected").attr('selected', false);
				}else{
					$("#neig_selbox option:selected").attr('selected', false);
				}
	
				/* 항목 클릭 시 원본 리스트 업데이트 */
				var y, i, k, s, h;
				s = this.parentNode.parentNode.getElementsByTagName("select")[0];
				h = this.parentNode.previousSibling;
				for (i = 0; i < s.length; i++) {
					if (s.options[i].innerHTML == this.innerHTML) {
						s.selectedIndex = i;
						h.innerHTML = this.innerHTML;
						y = this.parentNode.getElementsByClassName("same-as-selected");
						for (k = 0; k < y.length; k++) {
							y[k].removeAttribute("class");
						}
						this.setAttribute("class","same-as-selected");
						
						/* 선택 옵션 원본 리스트에 적용 */
						if (customTarget == "custom-select") {
							$('#city_selbox option[value='+ h.innerHTML + ']').attr('selected','selected');
							citySet(h.innerHTML);
						} else if(customTarget == "custom-select2"){
							$('#dist_selbox option[value='+ h.innerHTML + ']').attr('selected','selected');
							districtSet(h.innerHTML);
						}else{
							$('#neig_selbox option[value='+ h.innerHTML + ']').attr('selected','selected');
						}
						break;
					}
				}
				h.click();
			});
			b.appendChild(c);
		}
		
		x[i].appendChild(b);
		a.addEventListener("click", function(e) {
			/* select box 클릭 시 다른 select box 닫기  */
			e.stopPropagation();
			closeAllSelect(this);
			this.nextSibling.classList.toggle("select-hide");
			/* 현재 선택한 select box 열기*/
			this.classList.toggle("select-arrow-active");
		});
	}
	
	/*select box 닫기*/
	function closeAllSelect(elmnt) {

		var x, y, i, arrNo = [];
		x = document.getElementsByClassName("select-items");
		y = document.getElementsByClassName("select-selected");
		for (i = 0; i < y.length; i++) {
			if (elmnt == y[i]) {
				arrNo.push(i)

			} else {
				y[i].classList.remove("select-arrow-active");
			}
		}
		for (i = 0; i < x.length; i++) {
			if (arrNo.indexOf(i)) {
				x[i].classList.add("select-hide");
			}
		}
	}
	
	/* select box 외 영역 클릭 시 select box 닫기*/
	document.addEventListener("click", closeAllSelect);
}

/* city 선택 시 district 리스트 set*/
function citySet(cityname){
	/* 기존 리스트 제거 */
	$("#dist_selbox option").remove();
	
	/* 기본 option 추가 */
	$("#dist_selbox").append("<option value='' disabled selected>&nbsp;&nbsp;::구/군 선택::</option>");
	$.getJSON("resources/assets/json/administrativeArea.json",function(data){
		$.each(data, function(key, val){
			if(key=="district"){
				var list = val;
				for(var i=0; i<list.length; i++){
					if(list[i].name==cityname){
						var tmpList = list[i].value;
						for(var j=0; j<tmpList.length; j++){
							$("#dist_selbox").append("<option value='"+tmpList[j]+"'>"+tmpList[j]+"</option>");
						}
						$("#cateTwo > div").remove();
						customSelect("custom-select2");
						return;
					}
				}
			}
		});
	});
	
}


/* city 선택 시 district 리스트 set*/
function districtSet(districtname){
	/* cityname set */
	var cityname = $("#city_selbox option:selected").val();
	/* 기존 리스트 제거 */
	$("#neig_selbox option").remove();
	
	/* jsonfile read : 기본 option 추가 */
	$("#neig_selbox").append("<option value='' disabled selected>&nbsp;::읍/면/동 선택::</option>");
	$.getJSON("resources/assets/json/codelist.json",function(data){
		$.each(data, function(key, val){
			if(key==cityname){
				var list = val;
				for(var i=0; i<list.length; i++){
					if(list[i].name==districtname){
						var tmpList = list[i].value;
						for(var j=0; j<tmpList.length; j++){
							$("#neig_selbox").append("<option value='"+tmpList[j]+"'>"+tmpList[j]+"</option>");
						}
						$("#cateThree > div").remove();
						customSelect("custom-select3");
						return;
					}
				}
			}
		});
	});
}

/***********************************
searchForm
***********************************/
function searchFormSubmit(){
	
	/* select box, keyword get */
	var city = $("#city_selbox option:selected").val();
	var district = $("#dist_selbox option:selected").val();
	var neighborhood = $("#neig_selbox option:selected").val();
	var keyword = $("#searchInput").val();
	
	/* 유효성 검사 */
	if(city==null || city=="" || district==null || district=="" ){
		alert("지역을  모두 선택해주세요.");
	}else{
		searchAjax(city, district, neighborhood, keyword);
	}
}

/* keyword input 특수문자 제한*/
$("#searchInput").bind("keyup", function(){
	re = /[~!@\#$%^&*\()\-=+_']/gi; 
	var temp = $("#searchInput").val();
	if(re.test(temp)){
		$("#searchInput").val(temp.replace(re,""));
	}
})


/***********************************
 Map
***********************************/
function searchAjax(city, district, neighborhood, keyword){
	//검색 결과 리스트 초기화
	$("#listCon #listDiv").remove();
	//검색 결과 리스트 배열 생성
	var defList = [];
	var defListName = [];
	var mapcate = $("#mapcate").val();
	hideMarkers();   
	function hideMarkers() {
	    setMarkers(null);    
	}
	// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
	function setMarkers(map) {
	    for (var i = 0; i < markers.length; i++) {
	        markers[i].setMap(map);
	    }            
	}
	$.ajax({
		type:"post",
		url:"map_searchLocationAjax.do",
		data:{city: city, district: district, neighborhood: neighborhood, keyword: keyword, mapcate: mapcate},
		dataType:"json",
		success: function(result){
			
			/* Test Code*/
			if(result.success==true){
				if(result.list.length > 0){
					//마커 배열 생성 및 검색 리스트 생성
					$.each(result.list, function(index, item){
						defList.push({latlng: new kakao.maps.LatLng(item.map_latitude, item.map_longitude)});
						defListName.push(item.map_name);
						var html = "<div id='listDiv'  class=''>"+
						   "<h3><i class='fas fa-clinic-medical'></i>&nbsp;<b>"+item.map_name+"</b></h3>"+
						   "<span><i class='fas fa-map-marker-alt'></i>&nbsp;"+item.map_addr+"</span>"+
						   "<span style='margin-left: 7px;'><i class='fas fa-phone-square-alt'></i>&nbsp;"+item.map_phone+"</span></div>";
						   $("#listCon").append(html);
					});
					
					//검색 결과 리스트의 첫번째 주소의 위도경도로 map 이동
					panTo();
					function panTo() {
					    map.panTo(defList[0].latlng);            
					}     
					
					//마커 생성 및 출력
					for(var i=0; i<defList.length; i++){
						// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
						var iwContent = '<div style="padding:5px;">'+defListName[i]+'</div>'; 
						
						// 인포윈도우 생성
						var infowindow = new kakao.maps.InfoWindow({
						    content : iwContent,
						    position: defList[i].latlng
						}); 
						
						var marker = new kakao.maps.Marker({
							 map: map,
							 position: defList[i].latlng
						});
						 
						// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
						 kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
						 kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));							 
						
						// 생성된 마커를 배열에 추가합니다
						markers.push(marker);
					}
				}else{
					//리스트가 없는 경우
					var html = "<div id='listDiv'  class='nodatalistDiv'><b>검색된 "+$("#mapcate").val()+"이 없습니다.</b></div>"
						$("#listCon").append(html);
				}
			}
		},
		error: function(){
			alert("서버와 통신에 실패하였습니다. 다시 시도해주세요.");
		}
		
	})//ajax end
	
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
					function makeOverListener(map, marker, infowindow) {
					    return function() {
					        infowindow.open(map, marker);
					    };
					}

					// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
					function makeOutListener(infowindow) {
					    return function() {
					        infowindow.close();
					    };
					}
}


