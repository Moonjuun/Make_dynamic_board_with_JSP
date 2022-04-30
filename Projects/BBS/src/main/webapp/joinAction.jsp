<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>    <!--우리가 만든 클래스를 사용해주기 위해-->
<%@ page import = "java.io.PrintWriter" %>  <!-- JS 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" /> <!-- 회원가입페이지에서 넘겨준 userID를 받음 -->
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!-- 보내준 5가지 데이터 값을 받아야한다 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		} // 세션이 존재하는 아이디들은 세션ID값을 받게 해주자
		if (userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다')");
			script.println("location.href = 'main.jsp'"); // 로그인이 되어있으니 메인화면으로 돌아간다 
			script.println("</script>");
		}
	
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
		|| user.getUserGender() == null || user.getUserEmail() == null) {
			
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다')");
		script.println("history.back()"); // 로그인을 못 했으니 로그인 화면으로 돌아간다 
		script.println("</script>");	
			/* 받아야 하는 값들이 비워져 있을 경우의 수를 적어준다 */
			// 하나라도 입력이 안된 경우 이전 페이지로 돌아감
			
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다')");
				script.println("history.back()"); 
				script.println("</script>");
			} // 중복된 아이디가 있으면 이전 페이지로 돌아감
			else {
				session.setAttribute("userID",user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'"); 
				script.println("</script>");
			}
			
		}
	%>
</body>
</html>