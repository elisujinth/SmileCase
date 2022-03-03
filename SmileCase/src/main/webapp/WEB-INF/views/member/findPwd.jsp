<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- findPwd.css -->
<link rel="stylesheet" href="resources/css/member/findPwd.css" type="text/css">
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
	<div id="pw_find_div">
		<div id="find_button_div">
			<input type="button" class="find_button" value="아이디 찾기"
				onclick="location.href='findIdForm.me'" style="cursor: pointer">
			<input type="button" class="find_button" value="비밀번호 찾기" disabled
				style="background: rgba(155, 89, 182, 0.5); cursor: default;">
		</div>
		
		<br>
		
		<div id="pw_find_message">
			<div id="pw_find_title">비밀번호 찾기</div>
			<div>
				비밀번호가 기억나지 않으세요?<br> 아이디를 입력하시면 가입하신 이메일을 통해 비밀번호 재설정이 가능합니다.<br>
				본인인증 시 입력하시는 정보는 인증 이외의 용도로 사용 또는 저장하지 않습니다.
			</div>
		</div>
		
		<br><br>
		
		<div id="input_div">
			<input type="text" id="input_id" class="input" name="mem_id" 
				autocomplete="off" placeholder="아이디">
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
	$(document).ready(function(){
		$('#loading_div').hide(); // 첫 시작 시 로딩바 숨기기
	});
	$(document).ajaxStart(function(){
		$('#loading_div').show(); // ajax 실행 시 로딩바 보여줌
	});
	$(document).ajaxStop(function(){
		$('#loading_div').hide(); // ajax 종료 시 로딩바 숨기기
	});
	
	$("#input_button").click(function(){
		var id = $("#input_id");
		
		if (id.val().trim().length == 0) {
			swal("","아이디를 입력해주세요.","info")
			.then((ok) => {
				if(ok){
					id.focus();
				}
			});
			return;
		}
		
		$.ajax({
			url: "findPwd.me",
			type: "post",
			data: {mem_id:id.val()},
			success: function(result){
				console.log("result값 : " + result);
				if(result == 1){
					swal("메일 전송 완료","입력하신 이메일로 임시 비밀번호를 전송하였습니다.","success")
					.then((ok) => {
						if(ok){
							location.href="loginForm.me";
						}
					});
				}else{
					swal("메일 전송 실패","입력하신 아이디와 일치하는 회원이 없습니다.","error");
					id.val("");
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