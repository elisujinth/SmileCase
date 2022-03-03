<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- login.css -->
<link rel="stylesheet" href="resources/css/member/login.css">
<!-- swal창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<header>
	<c:import url="../common/header.jsp" />
</header>

<section>
	<div id="login_div">
		<div id="login_title">Login</div>

		<div>
			<input type="text" id="inputId" class="login_input" name="mem_id"
				autocomplete="off" placeholder="아이디를 입력해주세요">
			<!-- autocomplete="off" : 기록 안보이게(자동완성X) -->
			<br> <input type="password" id="inputPwd" class="login_input"
				name="mem_pwd" placeholder="비밀번호를 입력해주세요">
		</div>

		<input type="submit" id="login_button" value="로그인">

		<br>

		<div id="login_find_div">
			<a href="findIdForm.me">아이디 찾기</a> &nbsp;&nbsp; <a>|</a>
			&nbsp;&nbsp; <a href="findPwdForm.me">비밀번호 찾기</a> &nbsp;&nbsp; <a>|</a>
			&nbsp;&nbsp; <a href="joinForm.me">회원가입</a>
		</div>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script>
	$("#login_button").click(function(){
		var id = $("#inputId");
		var pwd = $("#inputPwd");
		
		if(id.val().trim().length == 0){
			swal("","아이디를 입력해주세요.","info")
			.then((ok) => { 
				if(ok){
					id.focus();
				}
			});
			return;
		}
		
		if(pwd.val().trim().length == 0){
			swal("","비밀번호를 입력해주세요.","info")
			.then((ok) => {
				if(ok){
					pwd.focus();
				}
			});
			return;
		}
			
		$.ajax({
			url: "login.me", 
			type: "post", 
			data: {mem_id:id.val(), mem_pwd:pwd.val()},
			success: function(result){
				if(result == 1){
					location.href="<%=request.getContextPath()%>";
				}else{
					swal("로그인 실패","입력한 정보를 가진 회원이 없습니다.","error");
					
					id.val("");
					pwd.val("");
					id.focus();
				}
			}, 
			error: function(data){
				alert("ajax에러 발생");
			}
		});
	});
</script>
</body>
</html>