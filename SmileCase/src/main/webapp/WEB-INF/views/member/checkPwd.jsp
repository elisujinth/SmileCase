<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- checkPwd.css -->
<link rel="stylesheet" href="resources/css/member/checkPwd.css">
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
	<div id="all_div">
		<h2>비밀번호 확인</h2>
		<input type="password" id="input_pwd" name="mem_pwd">
		<br>
		<input type="submit" id="input_button" value="확인">
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	$("#input_button").click(function(){
		var pwd = $("#input_pwd");
		
		$.ajax({
			url: "checkPwd.me", 
			type: "post", 
			data: {mem_pwd:pwd.val()}, 
			success: function(result){
				if(result == 1){
					location.href="mypageForm.me";
				}else{
					swal("비밀번호 확인 실패", "입력하신 비밀번호가 틀립니다.", "error");
					pwd.val("");
					pwd.focus();
					return;
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