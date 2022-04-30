<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>    <!--우리가 만든 클래스를 사용해주기 위해-->
<%@ page import = "java.io.PrintWriter" %>  <!-- JS 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" /> <!-- 로그인페이지에서 넘겨준 userID를 받음 -->
<jsp:setProperty name="user" property="userPassword" />
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
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		/* 로그인 페이지에서 각각 입력된 값이 넘어와서 login()에 넣어줘서 실행하게 된다
			-2 ~ 1까지의 값이 result 값에 담기게 된다
		*/
		
		if (result == 1){
			session.setAttribute("userID",user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); // 로그인이 성공하면 main.jsp로 이동한다
			script.println("</script>");
		}
		else if (result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()"); // 로그인을 못 했으니 로그인 화면으로 돌아간다 
			script.println("</script>");
		}
		else if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다')");
			script.println("history.back()"); // 로그인을 못 했으니 로그인 화면으로 돌아간다 
			script.println("</script>");
		}
		else if (result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다')");
			script.println("history.back()"); // 로그인을 못 했으니 로그인 화면으로 돌아간다 
			script.println("</script>");
		}
	%>
</body>
</html>