<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- memManage.css -->
<link rel="stylesheet" href="resources/css/member/memManage.css">
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
		<h1>회원 관리</h1>
		<p id="ment_del">회원아이디 클릭 시 삭제 가능합니다.</p>
		<table id="memManage_table">
			<tr>
				<th>회원아이디</th>
				<th>회원명</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>주소</th>
			</tr>
			<c:forEach var="i" items="${ list }" varStatus="status">
				<tr>
					<td><input type="text" class="input_memId" name="mem_id" value="${ i.getMem_id() }" readonly></td>
					<td>${ i.getMem_name() }</td>
					<c:if test="${ i.getMem_phone() eq null }">
						<td>-</td>
					</c:if>
					<c:if test="${ i.getMem_phone() ne null }">
						<td>${ i.getMem_phone() }</td>
					</c:if>
					<td>${ i.getMem_email() }</td>
					<td>(${ i.getMem_zipcode() }) ${ i.getMem_address() } ${ i.getMem_detail_addr() }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	$(".input_memId").click(function(){
		var memId = $(this).val();
		alert(memId);
		
		swal({
			text: "정말 삭제하시겠습니까?",
			icon: "info", 
			buttons: ["취소", "확인"], 
			dangerMode: true
		}).then((ok) => {
			if(ok){
				$.ajax({
					url: "adminDel.me", 
					type: "post", 
					data: {mem_id:memId}, 
					success: function(result){
						if(result == 1){
							swal("회원 삭제 완료", "", "success")
							.then((ok) => {
								location.href="memManageForm.me";
							});
						} else{
							swal("회원 삭제 실패", "잠시 후에 다시 시도해주세요.", "error");
							
							return;
						}
					}, 
					error: function(data){
						alert("ajax오류 발생");
					}
				});
			}
		});
	});
</script>
</body>
</html>