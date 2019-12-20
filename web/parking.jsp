<%@ page import="java.util.ArrayList" %>
<%@ page import="example.ParkingBean" %>
<%@ page import="java.net.InterfaceAddress" %>
<%@ page import="com.sun.tools.javac.tree.JCTree" %><%--
  Created by IntelliJ IDEA.
  User: hyeon
  Date: 2019-12-19
  Time: 오전 1:56
  To change this template use File | Settings | File Templates.
  이 화면에서는 지도와 관련된 부분을 session으로 넘겨서 정보를 다음 지도 api에 관련된 정보를 정리해서 출력해주는
  뷰이다.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>What The Parking</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        ArrayList<ParkingBean> parkingbean = (ArrayList<ParkingBean>) session.getAttribute("parkingbeans");
        int count = 0;

        for (ParkingBean i : parkingbean) {

            
        }
    %>
    <h1>What the Parking</h1>
    <div>
        아람 주차장 현항 :<br>
        사용중 : <%= count %> <br>
        남은 자리 : <%= 10 - count %> <br>
    </div>
</body>
</html>
