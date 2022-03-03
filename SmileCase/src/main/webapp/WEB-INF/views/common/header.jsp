<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- i 태그 사용 (font awesome 아이콘) -->
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<!-- header.css -->
<link rel="stylesheet" href="resources/css/common/header.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<%
	String loginUserId = (String)session.getAttribute("loginUserId");
	%>
	<!-- 로그인 전 -->
	<c:if test="${ loginUserId == null }">
		<div class="login_div b_login">
			<a class="login_btn" href="loginForm.me" 
			   onmouseover="this.style.color='#f7e8fc';"
			   onmouseout="this.style.color='#000000';">로그인</a>
			<span class="login_btn">|</span>
			<a class="login_btn" href="joinForm.me"
			   onmouseover="this.style.color='#f7e8fc';"
			   onmouseout="this.style.color='#000000';">회원가입</a>
		</div>
	</c:if>
	<!-- 로그인 후 -->
	<c:if test="${ loginUserId != null }">
		<div class="login_div a_login">
			<span class="login_btn"><%=loginUserId %> 님</span>
			<span class="login_btn">|</span>
			<a class="login_btn" href="checkPwdForm.me" 
			   onmouseover="this.style.color='#f7e8fc';"
			   onmouseout="this.style.color='#000000';">마이페이지</a>
			<span class="login_btn">|</span>
			<a class="login_btn" href="logout.me"
			   onmouseover="this.style.color='#f7e8fc';"
			   onmouseout="this.style.color='#000000';">로그아웃</a>
		</div>
	</c:if>
	
	<div id="parent_div">
		<div class="child_div"></div>
		<div class="child_div">
			<a id="main_logo" href="<%=request.getContextPath()%>">Smile Case</a>
		</div>
		
		<!-- 로그인 전이거나 '관리자'가 로그인한 경우 -->
		<c:if test="${ loginUserId == null || loginUserId == 'admin' }">
			<div class="child_div b_login"></div>
		</c:if>
		
		<!-- '회원'이 로그인한 경우 -->
		<c:if test="${ loginUserId != null && loginUserId != 'admin' }">
			<div id="icon_div" class="child_div a_login">
				<a href="cartListForm.pro">
					<img src="resources/images/icon_cart.jpg" id="cart_icon">장바구니
				</a>
				<a href="">
					<img src="resources/images/icon_list.jpg" id="list_icon">구매내역
				</a>
			</div>
		</c:if>
	</div>
	
	<div id="menu_div">
		<a href="list.pro?proCategory=all">상품 목록 보기</a>
		<!-- '관리자'가 로그인한 경우 -->
		<c:if test="${ loginUserId == 'admin' }">
			<a id="bar">|</a>
			<a href="memManageForm.me">회원 관리</a>
		</c:if>
	</div>
</body>
</html>