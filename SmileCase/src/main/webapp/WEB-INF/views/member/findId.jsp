<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- findId.css -->
<link rel="stylesheet" href="resources/css/member/findId.css" type="text/css">
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
	<div id="id_find_div">
		<div id="find_button_div">
			<input type="button" class="find_button" value="아이디 찾기" disabled
				style="background: rgba(155, 89, 182, 0.5); cursor: default;">
			<input type="button" class="find_button" value="비밀번호 찾기"
				onclick="location.href='findPwdForm.me'" style="cursor: pointer">
		</div>
		
		<br>
		
		<div id="id_find_message">
			<div id="id_find_title">아이디 찾기</div>
			<div>
				아이디가 기억나지 않으세요?<br> 가입하신 이메일을 입력하시면 아이디를 확인하실 수 있습니다.
			</div>
		</div>
		
		<br><br>
		
		<div id="input_div">
			<input type="text" id="input_name" class="input" name="mem_name" 
				autocomplete="off" placeholder="이름">
			<br><br>
			<input type="email" id="input_email" class="input" name="mem_email" 
				autocomplete="off" placeholder="이메일">
		</div>
		<br>
		<div id="input_button_div">
			 <input type="submit" id="input_button" value="확인">
		</div>
		
		<!-- 로딩중 -->
		<div id="loading_div">
			<img src="resources/images/loading.gif">
		</div>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	$(document).ajaxStart(function(){
		$("#loading_div").show(); // ajax 실행 시 로딩바 보여줌
	});
	$(document).ajaxStop(function(){
		$("#loading_div").hide(); // ajax 종료 시 로딩바 숨기기
	});
	$(document).ready(function(){
		$("#loading_div").hide(); // 첫 시작 시 로딩바 숨기기
	});
	
	$("#input_button").click(function(){
		var name = $("#input_name");
		var email = $("#input_email");
		
		if(name.val().trim().length == 0){
			swal("","이름을 입력해주세요.","info")
			.then((ok) => {
				if(ok){
					name.focus();
				}
			});
			return;
		}
		
		if(email.val().trim().length == 0){
			swal("","이메일을 입력해주세요.","info")
			.then((ok) => {
				if(ok){
					email.focus();
				}
			});
			return;
		}
		
		$.ajax({
			url: "findId.me",
			type: "post",
			data: {mem_name:name.val(), mem_email:email.val()},
			success: function(result){
				if(result == 1){
					swal("메일 전송 완료","입력하신 이메일로 아이디를 전송하였습니다.","success")
					.then((ok) => {
						if(ok){
							location.href="loginForm.me";
						}
					});
				}else{
					swal("메일 전송 실패","입력하신 이름, 이메일과 일치하는 회원이 없습니다.","error");
					name.val("");
					email.val("");
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