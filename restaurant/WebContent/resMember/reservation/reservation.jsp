<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String id = (String)session.getAttribute("id");
%>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<button type="button" onclick="location.href='reserveMail.jsp'">예약하기</button>
<%
if(id!=null){
	if(id.equals("fmoni")){
%>
	<button type="button" onclick="location.href='reservationlist.jsp'">예약확인</button>
<%
		
	}
}
%>
</div>
</div>
<p>
<div class="map_wrap">
    <div id="mapWrapper" style="width:50%;height:500px;float:left">
        <div id="map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
    </div>
    <div id="rvWrapper" style="width:50%;height:500px;float:left">
        <div id="roadview" style="width:100%;height:100%"></div> <!-- 로드뷰를 표시할 div 입니다 -->
    </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2e69f50a8c674cba2a56641db6c3906&libraries=services,clusterer,drawing"></script>
<script>
var mapWrapper = document.getElementById('mapWrapper'); //지도를 감싸고 있는 DIV태그

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapCenter = new kakao.maps.LatLng(35.158455, 129.062085), // 지도의 가운데 좌표
    mapOption = {
        center: mapCenter, // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);
map.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW); //지도 위에 로드뷰 도로 올리기

var rvContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
var rv = new kakao.maps.Roadview(rvContainer); //로드뷰 객체
var rvClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

toggleRoadview(mapCenter);

// 마커 이미지를 생성합니다.
var markImage = new kakao.maps.MarkerImage(
    'https://t1.daumcdn.net/localimg/localimages/07/2018/pc/roadview_minimap_wk_2018.png',
    new kakao.maps.Size(26, 46),
    {
        // 스프라이트 이미지를 사용합니다.
        // 스프라이트 이미지 전체의 크기를 지정하고
        spriteSize: new kakao.maps.Size(1666, 168),
        // 사용하고 싶은 영역의 좌상단 좌표를 입력합니다.
        // background-position으로 지정하는 값이며 부호는 반대입니다.
        spriteOrigin: new kakao.maps.Point(705, 114),
        offset: new kakao.maps.Point(13, 46)
    }
);

// 드래그가 가능한 마커를 생성합니다.
var rvMarker = new kakao.maps.Marker({
    image : markImage,
    position: mapCenter,
    draggable: true,
    map: map
});

//마커에 dragend 이벤트를 할당합니다
kakao.maps.event.addListener(rvMarker, 'dragend', function(mouseEvent) {
    var position = rvMarker.getPosition(); //현재 마커가 놓인 자리의 좌표
    toggleRoadview(position); //로드뷰를 토글합니다
});

//지도에 클릭 이벤트를 할당합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent){
    
    // 현재 클릭한 부분의 좌표를 리턴 
    var position = mouseEvent.latLng; 

    rvMarker.setPosition(position);
    toggleRoadview(position); //로드뷰를 토글합니다
});

//로드뷰 toggle함수
function toggleRoadview(position){

    //전달받은 좌표(position)에 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄웁니다
    rvClient.getNearestPanoId(position, 50, function(panoId) {
        if (panoId === null) {
            rvContainer.style.display = 'none'; //로드뷰를 넣은 컨테이너를 숨깁니다
            mapWrapper.style.width = '100%';
            map.relayout();
        } else {
            mapWrapper.style.width = '50%';
            map.relayout(); //지도를 감싸고 있는 영역이 변경됨에 따라, 지도를 재배열합니다
            rvContainer.style.display = 'block'; //로드뷰를 넣은 컨테이너를 보이게합니다
            rv.setPanoId(panoId, position); //panoId를 통한 로드뷰 실행
            rv.relayout(); //로드뷰를 감싸고 있는 영역이 변경됨에 따라, 로드뷰를 재배열합니다
        }
    });
}
</script>
<p>
</body>
</html>