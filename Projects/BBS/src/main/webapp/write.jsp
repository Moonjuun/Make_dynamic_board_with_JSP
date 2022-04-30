<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter"%> <!-- 스크립트 문장을 실행 할 수 있게 해주자 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
<meta name = "viewport" content="width=device-width", initial-scale="1"> 
<!-- 부트스트랩은 컴퓨터, 모바일 어떤걸로 접속하더라도 해상도에 맞게 디자인을 보여주는 템플릿. 그래서 반응형 웹에 사용되는 메타 태그를 적어준다 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 디자인을 담당하는 css 참조 완료 -->
<link rel="stylesheet" href="css/custom.css">

<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%	/* 로그인이 된 사람들은 로그인 정보를 담을 수 있게 해주자 */
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		// 현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있게 해줌
	%>

	<nav class="navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<!-- 아이콘바 3개 -->
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>			
			</button>
			<a class = "navbar-brand" href="main.jsp">JSP 웹 사이트</a>
		</div>
		
		<div class="collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class = "active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<%
				// 접속하기는 로그인이 안될 경우만 보이게
				if(userID == null) {
			%>
			<ul class ="nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class = "dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
						 <!-- 경로와 오타가 없음에도 a 링크 실행이 안됨 -->
					</ul>
				</li>
			</ul>
				
			<%	
				} else { //로그인 한 사람들이 보이는 화면
			%> 
			<ul class ="nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class = "dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>		
		</div>
	</nav>
	<!-- 네비게이션 구동, 하나의 웹사이트에서 전반적인 구성을 보여주는 역할 -->
	
	<div class = "container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<table class = "table table-striped" style="text-align: center; boerder: 1px solid #dddddd"> 
				<!-- class = "table table-striped"는 게시판 목록들이 짝수와 홀수 번갈아가면서 색이 변하게해줌 -->
					<thead>
						<tr>
							<th colspan ="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>				
					</thead>
					<tbody>
						<tr>
							<td><input type = "text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							<!-- input 타입은 특정한 정보를 Action 페이지에 보낼때 필요 -->
						</tr>
						
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
					<!-- Action 페이지로 보낼 수 있음 -->
				</table>
				<input type="submit" class="btn btn-primary pull-right" value = "글쓰기">
			</form>
		</div>
	</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<!-- 제이쿼리를 가져오기 -->
		<script src="js/bootstrap.js"></script>
		<!-- 부트스트랩에서 기본적으로 참조 -->
</body>
</html>