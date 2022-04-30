 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>    <!--우리가 만든 클래스를 사용해주기 위해-->
<%@ page import = "bbs.Bbs" %> 
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
		
		// 글의 번호가 들어오지 않았다면 밑에 코드 출력
		int bbsID = 0;
		if  (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID ==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); 
			script.println("</script>");
		}
		
		// 유저확인을 해줘야한다!!
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'"); 
			script.println("</script>");
		}
		/* 성공적으로 권한이 넘어간 사람은 else로 넘어가서 성공적으로 글이 확인되었는지 확인 할 수 있다 */
		else {  
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
				|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
					/* 만약 입력안된 사항이 있다면 돌려보내주자*/
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다')");
					script.println("history.back()"); // 이전 화면으로 돌아간다 
					script.println("</script>");	
						/* 받아야 하는 값들이 비워져 있을 경우의 수를 적어준다 */
						// 하나라도 입력이 안된 경우 이전 페이지로 돌아감
						// bbsTitle로 넘어 매개변수로 넘어온 값들을 분석할 수 있도록 해준다, update 페이지에서 bbsTitle과 bbsContent가 넘어옴
						
					} 
					else {
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
						
						if (result == -1){ // 리턴값이 -1이면 데이터 오류가 발생한 경우니
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글 수정에 실패했습니다')");
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