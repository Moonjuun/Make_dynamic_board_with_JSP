<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>    <!--우리가 만든 클래스를 사용해주기 위해-->
<%@ page import = "java.io.PrintWriter" %>  <!-- JS 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		session.invalidate(); // 현재 이 페이지에 접속한 회원의 세션을 빼앗아서 로그아웃되게 해준다
	%>
	
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>