<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- Map CSS -->
<link href="<%=request.getContextPath() %>/resources/assets/css/custom-map.css" rel="stylesheet" />
<!-- HEAD CSS -->
<jsp:include page="/WEB-INF/views/head.jsp"></jsp:include>
<script src="<%=request.getContextPath() %>/resources/assets/js/jquery.min.js"></script>
<!-- index_circle_custom CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/other_circle_custom.css">
</head>
<body>
<!-- Session set -->
<input type = "hidden" id = "hidden_session" value = <%=session.getAttribute("vo") %>>
<!-- MapCate set -->
<input type = "hidden" id = "mapcate" value="공원">

	<!-- ==============================================
	HeaderSection
	=============================================== -->
	<jsp:include page="/WEB-INF/views/circle-header.jsp"></jsp:include>
	
	<!-- ==============================================
	Navbar Second Section
	=============================================== -->
	<section class="nav-sec" style="margin-top: 15px; height: 60px;">
		<div class="row">
			<div class="d-flex justify-content-between col-lg-12 col-xs-12">
				<div class="p-2 nav-icon-lg clean-black"style="height: 59px;">
					<a class="nav-icon" href="mapHospital.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
						<span>병원</span>
					</a>
				</div>
				<div class="p-2 nav-icon-lg clean-black" style="height: 59px;">
					<a class="nav-icon" href="mapDrugstore.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
						<span>약국</span>
					</a>
				</div>
			  
				<div class="p-2 nav-icon-lg mint-green" style="height: 59px;">
					<a class="nav-icon" href="mapPark.do" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
						<span>공원</span>
					</a>
				</div>
				<div class="p-2 nav-icon-lg dark-black update-menu" style="height: 59px;">
					<a class="nav-icon" href="#" style="padding: 7px 6px 10px 6px; margin-top: 13px;">
						<span>업데이트 예정</span>
					</a>
				</div>
			 </div>
		</div>
	</section>	
  
	<!-- ==============================================
	User Profile Section
	=============================================== --> 
	<section class="user-profile">
		<div class="container-fluid">
		</div>
	</section>

	<!-- ==============================================
	User Profile Section
	=============================================== --> 
	 	
	<section id="details" class="details">
		<div id="searchCon" class="container">
			<div id="detail-bg-box">
				<div id="backimgfile">
					<div class="row">
						<div id="searchBox" style="width: 1070px;">
								<div id="cateOne" class="custom-select col-lg-2 col-xs-12">
								  <select id="city_selbox" class="w3-select w3-border" name="city">
								  </select>
								</div>
								<div id="cateTwo" class="custom-select2 col-lg-2 col-xs-12">
								  <select id="dist_selbox" class="w3-select w3-border" name="district">
								  </select>
								</div>
								<div id="cateThree" class="custom-select3 col-lg-2 col-xs-12">
								  <select id="neig_selbox" class="w3-select w3-border" name="neighborhood">
								  </select>
								</div>
							<span class="col-lg-3 col-xs-12" style="text-align: left;">
								<input id="searchInput" type="text" name="keyword" placeholder="공원명을 입력해주세요.">
							</span>
							<span class="col-lg-3 col-xs-12" style="text-align: left;">
								<button id="topSearchBtn" onclick="searchFormSubmit()">Search<i id="searchIcon" class="fas fa-search"></i></button>
							</span>
						</div>
					</div>
				</div><!--/ testimgfile -->
			</div><!--/ detail-bg-box -->
		</div><!--/ searchCon -->
	</section><!--/ details -->

	 <!-- ==============================================
	 Map Script
	 =============================================== -->

	 <script src="http://code.jquery.com/jquery-1.11.0.js"></script>
	 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3be6e5608252137aa33485ebc52496d3&libraries=services"></script>
	 <script type="text/javascript">
	 var latitude, longitude, dong, map; 
	 var markers = [];
		 $(function(){
            //default 위도 경도
            latitude = "37.49900771922129";
		 	longitude = "127.03284644541614";
			map();
		});
		 function map(){
				// 지도를 표시할 div 
				var mapContainer = document.getElementById('map'), 
			    mapOption = { 
			        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			        level: 5 // 지도의 확대 레벨
			    };
		
				// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
				map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				
				/* 클라이언트 좌표 행정동 search */
				searchAddrFromCoords(longitude, latitude, displayCenterInfo);
			
				function searchAddrFromCoords(longitude, latitude, callback) {
				    // 좌표로 행정동 주소 정보를 요청
				    geocoder.coord2RegionCode(longitude, latitude, callback);         
				}
				
				function displayCenterInfo(result, status) {
				    if (status === kakao.maps.services.Status.OK) {
				        var infoDiv = document.getElementById('centerAddr');

				        for(var i = 0; i < result.length; i++) {
				            // 행정동의 region_type 값  'H' 
				            if (result[i].region_type === 'H') {
				                dong = result[i].address_name.split(" ");
				                dong = dong[2];
				                //동이름 전송
				                defAjax(dong);
				                break;
				            }
				        }
				    }
				};
				
				//클라이언트 위치 : 전달받은 행정동으로 마커/리스트 set
				function defAjax(dong){
					var defList = [];
					var defListName = [];
					var mapcate = $("#mapcate").val();
					$.ajax({
						type:"post",
						url:"map_defaultLocationAjax.do",
						data:{dong: dong, mapcate: mapcate},
						dataType:"json",
						success: function(result){
							if(result.success==true){
								if(result.list.length > 0){
									//마커 배열 생성
									$.each(result.list, function(index, item){
										console.log(item.map_latitude+"//"+item.map_longitude);
										defList.push({latlng: new kakao.maps.LatLng(item.map_latitude, item.map_longitude)});
										defListName.push(item.map_name);
										var html = "<div id='listDiv'  class=''>"+
										   "<h3><i class='fas fa-clinic-medical'></i>&nbsp;<b>"+item.map_name+"</b></h3>"+
										   "<span><i class='fas fa-map-marker-alt'></i>&nbsp;"+item.map_addr+"</span>"+
										   "<span style='margin-left: 7px;'><i class='fas fa-phone-square-alt'></i>&nbsp;"+item.map_phone+"</span></div>";
										   $("#listCon").append(html);
									});
									
									//마커 생성 및 출력
									for(var i=0; i<defList.length; i++){
										// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
										var iwContent = '<div style="padding:5px;">'+defListName[i]+'</div>'; 
										
										// 인포윈도우 생성
										var infowindow = new kakao.maps.InfoWindow({
										    content : iwContent,
										    position: defList[i].latlng
										}); 
										
										//마커 생성
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
			}
	 </script>
	 
	 <!-- ==============================================
	 Map
	 =============================================== --> 
	 
	 <section id="map-container" class="newsfeed">
	  <div class="container">
	  
	   <div class="row">
		<div id="mapform" class="col-lg-12" >
			<div id="mapCon" style="">
				<div id="mapDiv" style="">
			    	<i class="fas fa-map-marker-alt"></i>
				</div>
				<div id="map"></div>
			</div>

		</div>
	   </div><!--/ row -->
	   
	  </div><!--/ container -->
	 </section><!--/ newsfeed -->
	 
	 
	 <!-- ==============================================
	 Map List
	 =============================================== --> 
  	 <section id="maplist" class="newsfeed">
	  <div class="container">

		 <div class="row">
			 <div id="listCon" class="col-xs-12">
		 	</div>
		 </div>
	  </div><!--/ container -->
	 </section><!--/ newsfeed -->
  

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		   
     <!-- ==============================================
	 Scripts
	 =============================================== -->
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/base.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/plugins/slimscroll/jquery.slimscroll.js"></script>
	<script src="<%=request.getContextPath() %>/resources/temp/assets/js/follwer.js"></script>
		
    <!-- ==============================================
	HEADER CIRCLE Scripts
	=============================================== -->
	
	<script src="<%=request.getContextPath() %>/resources/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/util.js"></script>
	<!-- main 외  페이지 전용 -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/circle-header.js"></script>
	<!-- Map Script -->
	<script src="<%=request.getContextPath() %>/resources/assets/js/custom-map.js"></script>
	
	<!-- Auto Script -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	
  </body>
</html>
