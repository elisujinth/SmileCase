<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- updateMypage.css -->
<link rel="stylesheet" href="resources/css/member/updateMypage.css">
<!-- swal창 -->
<!-- swal(title, text, icon) 형식
	 icon : success, info, warning, error -->
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
	<c:set var="loginUser" value="${ loginUser }"></c:set>
	<div id="updateDiv">
		<div id="updateTitle">마이페이지</div>
		
		<form id="updateForm" method="post" action="update.me" onsubmit="return checkSubmit();">
			<table>
				<tr>
					<td colspan="2" style="vertical-align: bottom;">
						<span id="regexp_pwd">비밀번호는 영문 소문자, 숫자, 특수문자만 입력 가능합니다.<br>
							(특수문자는 ~!@#$%^&*만 입력 가능)</span>
						<span id="regexp_email">이메일은 영문 소문자, 숫자만 입력 가능합니다.</span>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td">아이디</td>
					<td class="second_td"><input type="text" id="inputId" name="mem_id" value="${ loginUser.getMem_id() }" readonly></td>
					<td><span>아이디는 수정이 불가능합니다.</span></td>
				</tr>
				<tr>
					<td class="first_td">이름</td>
					<td><input type="text" id="inputName" name="mem_name" value="${ loginUser.getMem_name() }" maxlength="13" autocomplete="off"></td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td">비밀번호<br><span>(8~15자 이내)</span></td>
					<td>
						<input type="password" id="inputPwd" name="mem_pwd" maxlength="15">
						<input type="hidden" name="originalPwd" value="${ loginUser.getMem_pwd() }">
					</td>
					<td><span>비밀번호 변경 시 입력해주세요.</span></td>
				</tr>
				<tr>
					<td class="first_td">비밀번호 확인</td>
					<td><input type="password" id="inputPwd2" name="mem_pwd2" maxlength="15"></td>
					<td></td>
				</tr>
				<tr>
					<td class="first_td">전화번호</td>
					<!-- 휴대폰 번호가 null이 아닌 경우 -->
					<c:if test="${ loginUser.getMem_phone() ne null }">
						<td><input type="tel" id="inputTel" name="mem_phone" value="${ loginUser.getMem_phone() }" maxlength="13" autocomplete="off"></td>
					</c:if>
					<!-- 휴대폰 번호가 null인 경우 -->
					<c:if test="${ loginUser.getMem_phone() eq null }">
						<td><input type="tel" id="inputTel" name="mem_phone" maxlength="13" autocomplete="off"></td>
					</c:if>
					<td></td>
				</tr>
				<tr>
					<td class="first_td">이메일</td>
					<td>
						<input type="text" id="inputEmail" name="mem_email" value="${ loginUser.getMem_email() }" placeholder="이메일주소" autocomplete="off">
						<input type="hidden" id="email2" value="${ loginUser.getMem_email2() }">
					</td>
					<td class="third_td">@ 
						<select id="inputEmail2" name="mem_email2">
							<option value="null">사이트선택</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</td>
				</tr>
				<tr id="address_tr">
					<td class="first_td">주소</td>
					<td><input type="text" placeholder="우편번호" id="zoneCode" name="mem_zipcode" value="${ loginUser.getMem_zipcode() }" readonly></td>
					<td id="searchAddress_td"><button type="button" id="searchAddress">주소 검색</button></td>
				</tr>
				<tr>
					<td class="first_td"></td>
					<td class="address_td">
						<input type="text" placeholder="주소" id="mainAddress" name="mem_address" value="${ loginUser.getMem_address() }" readonly>
					</td>
					<c:set var="detailAddress" value="${ loginUser.getMem_detail_addr() }"></c:set>
					<c:if test="${ detailAddress eq null }">
						<c:set var="detailAddress" value=""></c:set>
					</c:if>
					<td class="address_td">
						<input type="text" placeholder="상세주소" id="detailAddress" name="mem_detail_addr" value="${ detailAddress }">
					</td>
				</tr>
				<tr id="submit_tr">
					<td colspan="3"><button type="submit">수정</button></td>
				</tr>
			</table>
			<div id="ac_div">
				<a id="mem_del_btn">회원탈퇴</a>
			</div>
		</form>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	// ---------- 이메일 select 박스 선택되게 ----------
	var inputEmail2 = $("#email2").val();
	$("#inputEmail2").val(inputEmail2).prop("selected", true);
	
	// ---------- 비밀번호 - 영문 소문자, 숫자, 특수문자(~!@#$%^&*) ----------
	$("#inputPwd").keyup(function(){
		var inputPwd = $("#updateForm").find("#inputPwd").val();

		regexp = /[^a-z0-9~!@#$%^&*]/g;
		if(regexp.test(inputPwd)){
			$("#regexp_pwd").css("display", "block");
			$("#updateForm").find("#inputPwd").val(inputPwd.replace(regexp, ''));
		}else{
			$("#regexp_pwd").css("display", "none");
		}
	});
	
	// ---------- 비밀번호 확인 - 영문 소문자, 숫자, 특수문자(~!@#$%^&*) ----------
	$("#inputPwd2").keyup(function(){
		var inputPwd2 = $("#updateForm").find("#inputPwd2").val();
		
		regexp = /[^a-z0-9~!@#$%^&*]/g;
		if(regexp.test(inputPwd2)){
			$("#regexp_pwd").css("display", "block");
			$("#updateForm").find("#inputPwd2").val(inputPwd2.replace(regexp, ''));
		}else{
			$("#regexp_pwd").css("display", "none");
		}
	});
	
	// ---------- 전화번호 필터링(중간중간 - 처리) ----------
	$("#inputTel").keyup(function(){
		var inputTel = $("#updateForm").find("#inputTel").val();
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

		$("#updateForm").find("#inputTel").val(tmp);
	});
	
	// ---------- 이메일 입력란에 영문 소문자, 숫자 ----------
	$("#inputEmail").keyup(function(){
		var inputEmail = $("#updateForm").find("#inputEmail").val();
		
		regexp = /[^a-z0-9]/g;
		if(regexp.test(inputEmail)){
			$("#regexp_email").css("display", "block");
			$("#updateForm").find("#inputEmail").val(inputEmail.replace(regexp, ''));
		}else{
			$("#regexp_email").css("display", "none");
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
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다
	        $("#zoneCode").val(data.zonecode);
			$("#mainAddress").val(addr);
			
			// 커서를 상세주소 필드로 이동한다.
			$("#detailAddress").focus();
			}
		}).open();
	});
	
	window.checkSubmit = function(){
		var name= $("#updateForm").find("#inputName");
		var pwd=$("#updateForm").find("#inputPwd");
		var pwd2=$("#updateForm").find("#inputPwd2");
		var email2 = $("#updateForm").find("#inputEmail2").val();
		var address = $("#joinForm").find("#mainAddress");
		
		if(name.val().trim()==""){
			swal("","이름을 입력해주세요.","info");
			name.focus();
			return false;
		}
		
		if(pwd.val().trim() != ""){
			console.log("pwd : " + pwd.val());
			
			if(pwd.val().trim().length<8){
				swal("","비밀번호는 8글자 이상 입력해주세요.","info");
				pwd.focus();
				return false;
			}
			
			if(pwd.val().trim()!=pwd2.val().trim()){
				swal("","비밀번호가 일치하지 않습니다.","error");
				pwd2.focus();
				return false;
			}
		}
		
		if(email2=="null"){
			swal("","사이트를 선택해주세요.","info");
			return false;
		}
		
		if(address.val().trim()==""){
			address.focus();
			swal("","주소를 입력해주세요.","info");
			return false;
		}
	};
	
	$("#mem_del_btn").click(function(){
		swal({
			text: "정말 탈퇴하시겠습니까?", 
			icon: "info", 
			buttons: ["취소", "확인"], 
			dangerMode: true
		}).then((ok) => {
			if(ok){
				$.ajax({
					url: "delete.me", 
					type: "post", 
					data: {},
					success: function(result){
						if(result == 1){
							location.href="<%=request.getContextPath()%>";
						}else{
							swal("", "회원탈퇴 중 문제가 발생했습니다.");
						}
					}, 
					error: function(data){
						alert("ajax에러 발생");
					}
				});
			}
		});
	});
</script>
</body>
</html>