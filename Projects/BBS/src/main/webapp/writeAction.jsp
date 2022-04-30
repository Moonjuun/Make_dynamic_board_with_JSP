<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>    <!--우리가 만든 클래스를 사용해주기 위해-->
<%@ page import = "java.io.PrintWriter" %>  <!-- JS 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" /> <!--  -->
<jsp:setProperty name="bbs" property="bbsContent" />
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
		
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'"); // 로그인이 안된 사람은 로그인페이지로 가게한다
			script.println("</script>");
		} 
		else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
					/* 만약 입력안된 사항이 있다면 돌려보내주자*/
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다')");
					script.println("history.back()"); // 이전 화면으로 돌아간다 
					script.println("</script>");	
						/* 받아야 하는 값들이 비워져 있을 경우의 수를 적어준다 */
						// 하나라도 입력이 안된 경우 이전 페이지로 돌아감
						
					} 
					else {
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						
						if (result == -1){ // 리턴값이 -1이면 데이터 오류가 발생한 경우니
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다')");
							script.println("history.back()"); 
							script.println("</script>");
						} // 중복된 아이디가 있으면 이전 페이지로 돌아감
						else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'bbs.jsp'"); 
							script.println("</script>");
						}
					}
		}
		
			
		
	%>
</body>
</html>