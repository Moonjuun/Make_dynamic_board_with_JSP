package snippet;

public class Snippet {
	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
	<meta name = "viewport" content="width=device-width", initial-scale="1"> 
	<!-- 부트스트랩은 컴퓨터, 모바일 어떤걸로 접속하더라도 해상도에 맞게 디자인을 보여주는 템플릿. 그래서 반응형 웹에 사용되는 메타 태그를 적어준다 -->
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- 디자인을 담당하는 css 참조 완료 -->
	<title>JSP 게시판 웹사이트</title>
	</head>
	<body>
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
			</div> ㅍ 
			
			<div data-toggle="collapse" id = "bs-example-navbar-collapse-1">
				<ul class = "nav navbar-nav">
					<li><a href="main.sjp">메인</a></li>
					<li><a href="bbs.jsp">게시판</a></li>
				</ul>
							
				<ul class ="nav navbar-nav navbar-right">
					<li class = "dropdown">
						<a href="#" class = "dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li class="active"><a href = "login.jsp">로그인</a></li> <!-- active는  현재 선택이 되었음 -->
							<li><a href = "join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
		
		<div class="container">
			<div class = "col-lg-4"></div>
			<div class = "col-lg-4">
				<div class="jumbotron" style="padding-top:20px;">
					<form method="post" action="loginAction.jsp"> <!-- post 정보를 숨기는 메서드 -->
						<h3 syle = "text-align :center;">로그인 화면</h3> <!-- loginAction 페이지로 로그인 정보를 보내주겠다 -->
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength = "20">
						</div>
						
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength = "20"> 
						</div> 
						<input type = "submit" class = "btn btn-primary form-control" value="로그인">
						<!-- 로그인을 누르면 loginAction 페이지로 이동 -->
				</div> 
			</div>
			<div class="col-lg-4"></div>
		</div>
		
		<!-- 네비게이션 구동, 하나의 웹사이트에서 전반적인 구성을 보여주는 역할 -->
			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<!-- 제이쿼리를 가져오기 -->
			<script src="js/bootstrap.js"></script>
			<!-- 부트스트랩에서 기본적으로 참조 -->
	</body>
	</html>
}

