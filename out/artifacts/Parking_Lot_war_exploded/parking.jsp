<%--
  Created by IntelliJ IDEA.
  User: hyeon
  Date: 2019-12-19
  Time: 오전 1:56
  To change this template use File | Settings | File Templates.
  이 화면에서는 지도와 관련된 부분을 session으로 넘겨서 정보를 다음 지도 api에 관련된 정보를 정리해서 출력해주는
  뷰이다.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>What The Parking</title>
</head>
<body>


    <c:forEach var="list" items="${parkingbeans}">
       ${list.parking_no} ${list.a1} ${list.a2} ${list.a3}
    </c:forEach>
    <h1>What the Parking</h1>
    <div>
        아람 주차장 현항 :<br>
        사용중 :  <br>
        남은 자리 :  <br>
    </div>
</body>
</html>
