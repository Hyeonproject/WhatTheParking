<%--
  Created by IntelliJ IDEA.
  User: Hyeon
  Date: 2019-12-15
  Time: 오전 1:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>메인 타이틀 이자 카카오 지도 시작</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></scrip>
  </head>
  <body>
  <jsp:include page="/header.jsp" flush="true"/>
  <div id="map" style="width:90%;height:90%;"></div>
  <p>
    <button onclick="selectOverlay('MARKER')">마커</button>
    <button onclick="selectOverlay('POLYLINE')">선</button>
    <button onclick="selectOverlay('CIRCLE')">원</button>
    <button onclick="selectOverlay('RECTANGLE')">사각형</button>
    <button onclick="selectOverlay('POLYGON')">다각형</button>
  </p>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d7aa1f48cb081dfe6bdc2e9c4e7beb61&libraries=drawing"></script>
  <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
              center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
            };

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
      map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
      drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
        kakao.maps.drawing.OverlayType.MARKER,
        kakao.maps.drawing.OverlayType.POLYLINE,
        kakao.maps.drawing.OverlayType.RECTANGLE,
        kakao.maps.drawing.OverlayType.CIRCLE,
        kakao.maps.drawing.OverlayType.POLYGON
      ],
      // 사용자에게 제공할 그리기 가이드 툴팁입니다
      // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
      guideTooltip: ['draw', 'drag', 'edit'],
      markerOptions: { // 마커 옵션입니다
        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다
        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다
      },
      polylineOptions: { // 선 옵션입니다
        draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
        editable: true, // 그린 후 수정할 수 있도록 설정합니다
        strokeColor: '#39f', // 선 색
        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
        hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
      },
      rectangleOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f', // 외곽선 색
        fillColor: '#39f', // 채우기 색
        fillOpacity: 0.5 // 채우기색 투명도
      },
      circleOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f',
        fillColor: '#39f',
        fillOpacity: 0.5
      },
      polygonOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f',
        fillColor: '#39f',
        fillOpacity: 0.5,
        hintStrokeStyle: 'dash',
        hintStrokeOpacity: 0.5
      }
    };

    // 위에 작성한 옵션으로 Drawing Manager를 생성합니다
    var manager = new kakao.maps.drawing.DrawingManager(options);

    // 버튼 클릭 시 호출되는 핸들러 입니다
    function selectOverlay(type) {
      // 그리기 중이면 그리기를 취소합니다
      manager.cancel();

      // 클릭한 그리기 요소 타입을 선택합니다
      manager.select(kakao.maps.drawing.OverlayType[type]);
    }
  </script>
  </body>
</html>