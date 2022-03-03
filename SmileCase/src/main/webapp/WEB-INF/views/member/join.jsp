<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- join.css -->
<link rel="stylesheet" href="resources/css/member/join.css">
<!-- swal창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 주소 검색 팝업창(카카오맵) -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
<header>
	<c:import url="../common/header.jsp" />
</header>

<section>
	<div id="join_div">
		<div id="join_title">회원가입</div>

		<form id="joinForm" method="post" action="join.me" onsubmit="return checkSubmit();">
			<table>
				<tr>
					<td colspan="2" style="vertical-align: bottom;">
						<span id="regexp_id">아이디는 영문 소문자, 숫자만 입력 가능합니다.</span>
						<span id="regexp_pwd">비밀번호는 영문 소문자, 숫자, 특수문자만 입력 가능합니다.<br>
							(특수문자는 ~!@#$%^&*만 입력 가능)</span>
						<span id="regexp_email">이메일은 영문 소문자, 숫자만 입력 가능합니다.</span>
					</td>
					<td id="join_notice" style="vertical-align: bottom;"><span>* </span> 필수입력항목</td>
				</tr>
				<tr>
					<td class="first_td"><span id="redDot">* </span>아이디<br><span>(6~10자 이내)</span></td>
					<td class="second_td">
						<input type="text" id="inputId" name="mem_id" maxlength="10" autocomplete="off">
						<input type="hidden" id="checkId_hidden" value="false">
					</td>
					<td class="third_td"><button type="button" id="btnDuplicate">중복 확인</button><br></td>
				</tr>
				<tr>
					<td class="first_td"><span id="redDot">* </span>이름</td>
					<td><input type="text" id="inputName" name="mem_name" maxlength="13" autocomplete="off"></td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td"><span id="redDot">* </span>비밀번호<br>
						<span>(8~15자 이내)</span></td>
					<td><input type="password" id="inputPwd" name="mem_pwd" maxlength="15"></td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td"><span id="redDot">* </span>비밀번호 확인</td>
					<td><input type="password" id="inputPwd2" name="mem_pwd2" maxlength="15"></td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td">전화번호</td>
					<td><input type="tel" id="inputTel" name="mem_phone" maxlength="13" autocomplete="off"></td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td"><span id="redDot">* </span>이메일</td>
					<td><input type="text" id="inputEmail" name="mem_email" placeholder="이메일주소" autocomplete="off"></td>
					<td class="third_td">@ 
						<select id="inputEmail2" name="mem_email2">
							<option value="null" selected>사이트선택</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</td>
				</tr>
				<tr id="address_tr">
					<td class="first_td"><span id="redDot">* </span>주소</td>
					<td><input type="text" placeholder="우편번호" id="zoneCode" name="mem_zipcode" readonly></td>
					<td id="searchAddress_td"><button type="button" id="searchAddress">주소 검색</button></td>
				</tr>
				<tr>
					<td class="first_td"></td>
					<td class="address_td">
						<input type="text" placeholder="주소" id="mainAddress" name="mem_address" readonly>
					</td>
					<td class="address_td">
						<input type="text" placeholder="상세주소" id="detailAddress" name="mem_detail_addr">
					</td>
				</tr>
				<tr id="submit_tr">
					<td colspan="3"><button type="submit">가입</button></td>
				</tr>
			</table>
		</form>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	// ---------- 아이디 - 영문 소문자, 숫자 ----------
	$("#inputId").keyup(function(){
		var inputId = $("#joinForm").find("#inputId").val();
		
		regexp = /[^a-z0-9]/g;
		if(regexp.test(inputId)){
			$("#regexp_id").css("display", "block");
			$("#joinForm").find("#inputId").val(inputId.replace(regexp, ''));
		}else{
			$("#regexp_id").css("display", "none");
		}
	});
	
	// ---------- 비밀번호 - 영문 소문자, 숫자, 특수문자(~!@#$%^&*) ----------
	$("#inputPwd").keyup(function(){
		var inputPwd = $("#joinForm").find("#inputPwd").val();
		
		regexp = /[^a-z0-9~!@#$%^&*]/g;
		if(regexp.test(inputPwd)){
			$("#regexp_pwd").css("display", "block");
			$("#joinForm").find("#inputPwd").val(inputPwd.replace(regexp, ''));
		}else{
			$("#regexp_pwd").css("display", "none");
		}
	});
	
	// ---------- 비밀번호 확인 - 영문 소문자, 숫자, 특수문자(~!@#$%^&*) ----------
	$("#inputPwd2").keyup(function(){
		var inputPwd2 = $("#joinForm").find("#inputPwd2").val();
		
		regexp = /[^a-z0-9~!@#$%^&*]/g;
		if(regexp.test(inputPwd2)){
			$("#regexp_pwd").css("display", "block");
			$("#joinForm").find("#inputPwd2").val(inputPwd2.replace(regexp, ''));
		}else{
			$("#regexp_pwd").css("display", "none");
		}
	});
	
	// ---------- 전화번호 필터링(중간중간 - 처리) ----------
	$("#inputTel").keyup(function(){
		var inputTel = $("#joinForm").find("#inputTel").val();
		var tmp = "";
		inputTel = inputTel.replace(/[^0-9]/g, '');
		
		if(inputTel.length < 4){
			tmp += inputTel;
		} else if(inputTel.length < 7){
			tmp += inputTel.substr(0, 3);
			tmp += '-';
			tmp += inputTel.substr(3);
		} else if(inputTel.length < 11){
			tmp += inputTel.substr(0, 3);
			tmp += '-';
			tmp += inputTel.substr(3, 3);
			tmp += '-';
			tmp += inputTel.substr(6);
		} else{
			tmp += inputTel.substr(0, 3);
			tmp += '-';
			tmp += inputTel.substr(3, 4);
			tmp += '-';
			tmp += inputTel.substr(7);
		}

		$("#joinForm").find("#inputTel").val(tmp);
	});
	
	// ---------- 이메일 입력란에 영문 소문자, 숫자 ----------
	$("#inputEmail").keyup(function(){
		var inputEmail = $("#joinForm").find("#inputEmail").val();
		
		regexp = /[^a-z0-9]/g;
		if(regexp.test(inputEmail)){
			$("#regexp_email").css("display", "block");
			$("#joinForm").find("#inputEmail").val(inputEmail.replace(regexp, ''));
		}else{
			$("#regexp_email").css("display", "none");
		}
	});
	
	// ---------- 아이디 입력란에 변화가 생긴 경우) 아이디 중복 확인 다시 ----------
	$('#inputId').on('change paste keyup', function(){
		$('#joinForm').find('#checkId_hidden').val("false");
	});
	
	// ---------- 아이디 중복 확인 버튼 누른 경우 ----------
	$('#btnDuplicate').click(function(){
		var inputId=$('#joinForm').find('#inputId');
		if(inputId.val().trim()==""){
			swal("","아이디를 입력해주세요","info")
			inputId.focus();
		}else{
			$.ajax({
				url: "checkId.me",
				data: {mem_id:inputId.val()},
				success: function(data){
					if(data==1){
						swal("아이디 중복 확인", "중복되는 아이디가 있습니다.", "warning");
						$('#joinForm').find('#checkId_hidden').val("false");
					}else{
						swal("아이디 중복 확인", "이 아이디는 사용 가능합니다.", "success");
						$('#joinForm').find('#checkId_hidden').val("true");
					}	
				},
				error: function(data){
					alert("Ajax 실행 오류");
				}
			});
		}
	});
	
	// ---------- 주소 입력 ----------
	$("#searchAddress").click(function(){
		new daum.Postcode({
			oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수
			
			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType == 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			//document.getElementById('tbox1').value = data.zonecode;
	        $("#zoneCode").val(data.zonecode);
			//document.getElementById("tbox2").value = addr;
			$("#mainAddress").val(addr);
			
			// 커서를 상세주소 필드로 이동한다.
			//document.getElementById("tbox3").focus();
			$("#detailAddress").focus();
			}
		}).open();
	});
	
	// ---------- submit하기 전에 확인하는 함수 ----------
	window.checkSubmit = function(){
		console.log("우편번호 : " + $("#zoneCode").val());
		console.log("주소 : " + $("#mainAddress").val());
		console.log("상세주소 : " + $("#detailAddress").val());
		
		var id = $("#joinForm").find("#inputId");
		var name = $("#joinForm").find("#inputName");	
		var pwd = $("#joinForm").find("#inputPwd");
		var pwd2 = $("#joinForm").find("#inputPwd2");
		var email = $("#joinForm").find("#inputEmail");
		var email2 = $("#joinForm").find("#inputEmail2");
		var address = $("#joinForm").find("#mainAddress");
		
		if(id.val().trim()==""){
			id.focus();
			swal("","아이디를 입력해주세요","info");
			return false;
		}
		
		if(id.val().trim().length<6){
			swal("","아이디는 6글자 이상 입력해주세요.","info");
			id.focus();
			return false;
		}
		
		if($("#joinForm").find("#checkId_hidden").val()=="false"){
			swal("","아이디 중복확인을 해주세요.","info");
			return false;
		}
		
		if(name.val().trim()==""){
			name.focus();
			swal("","이름을 입력해주세요.","info");
			return false;
		}
		
		if(pwd.val().trim().length<8){
			swal("","비밀번호는 8글자 이상 입력해주세요.","info");
			pwd.focus();
			return false;
		}
		
		if(pwd.val().trim()!=pwd2.val().trim()){
			pwd2.focus();
			swal("","비밀번호가 일치하지 않습니다.","error");
			return false;
		}
		
		if(email.val().trim()==""){
			email.focus();
			swal("","이메일을 입력해주세요.","info");
			return false;
		}
		
		if(email2.val()=="null"){
			email2.focus();
			swal("","사이트를 선택해주세요.","info");
			return false;
		}
		
		if(address.val().trim()==""){
			address.focus();
			swal("","주소를 입력해주세요.","info");
			return false;
		}
	};
</script>
</body>
</html>