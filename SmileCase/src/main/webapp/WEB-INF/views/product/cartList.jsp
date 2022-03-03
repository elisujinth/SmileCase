<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- cartList.css -->
<link rel="stylesheet" href="resources/css/product/cartList.css">
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
		<h1>장바구니</h1>
		<table id="cartList_table">
			<tr class="cart_tr">
				<th><input type="checkbox" id="cbx_chkAll"></th>
				<th style="width: 220px;">이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>수량</th>
				<th>합계</th>
			</tr>
			<!-- 장바구니에 상품 없음 -->
				<c:if test="${ fn:length(list) eq 0 }">
					<tr>
						<td colspan="6">장바구니에 담겨있는 상품이 없습니다.</td>
					</tr>
				</c:if>
			<!-- 장바구니에 상품 있음 -->
				<c:if test="${ fn:length(list) ne 0 }">
				<c:forEach var="i" items="${ list }" varStatus="status">
					<tr class="cart_tr">
						<td>
							<input type="checkbox" name="chk" data-caNo="${ i.getCa_no() }">
							<input type="hidden" class="caNo" value="${ i.getCa_no() }">
						</td>
						<td><div class="img_div"><img src="resources/images/${ i.getPro_originFileName() }"></div></td>
						<td>${ i.getPro_name() }</td>
						<td>
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${ i.getPro_price() }"/>원
						</td>
						<td><input type="number" class="input_count" min="0" value="${ i.getCa_count() }">개<button class="count_update_btn">변경</button></td>
						<td>
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${ i.getCa_count() * i.getPro_price() }"/>원
						</td>
					</tr>
				</c:forEach>
				<tr class="total_tr">
					<td colspan="6">
						<input type="button" id="delete_btn" value="선택 상품 삭제">
						<input type="button" id="buy_btn" value="구매하기">
					</td>
				</tr>
				<tr class="total_tr">
					<td colspan="6">
						<c:set var="totalPrice" value="0"></c:set>
						<c:forEach var="i" items="${ list }" varStatus="status">
							<c:set var="totalPrice" value="${ totalPrice + i.getCa_count() * i.getPro_price() }"></c:set>
						</c:forEach>
						<b>합계 금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${ totalPrice }"/>원</b>
					</td>
				</tr>
			</c:if>
		</table>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	$("#cbx_chkAll").click(function() {
		if($("#cbx_chkAll").is(":checked")){
			$("input[name=chk]").prop("checked", true);
		}else{
			$("input[name=chk]").prop("checked", false);
		}
	});
	
	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var checked = $("input[name=chk]:checked").length;
		
		if(total != checked){
			$("#cbx_chkAll").prop("checked", false);
		}else{
			$("#cbx_chkAll").prop("checked", true); 
		}
	});
	
	$("#delete_btn").click(function(){
		if($("input[name=chk]").is(":checked")){
			swal({
				text: "정말 삭제하시겠습니까?", 
				icon: "info", 
				buttons: ["취소", "확인"], 
				dangerMode: true
			}).then((ok) => {
				if(ok){
					// 확인(삭제)
					var checkArr = new Array();
					
					$("input[name=chk]:checked").each(function(){
						checkArr.push($(this).attr("data-caNo"));
					});
					console.log(checkArr);
					
					$.ajax({
						url: "cartDel.pro",
						type: "post", 
						data: {chbox: checkArr}, 
						success: function(result){
							location.href="cartListForm.pro";
						}, 
						error: function(data){
							alert("ajax오류 발생");
						}
					});
				}
			});
		} else{
			// 체크박스가 한개도 선택되어있지 않으면
			swal("", "삭제할 상품을 선택해주세요.", "info");
			return;
		}
	});
	
	$("#buy_btn").click(function(){
		if($("input[name=chk]").is(":checked")){
			swal({
				text: "구매하시겠습니까?", 
				icon: "info", 
				buttons: ["취소", "확인"]
			}).then((ok) => {
				if(ok){
					swal("완료!", "", "success");
				}
			});
		} else{
			// 체크박스가 한개도 선택되어있지 않으면
			swal("", "구매할 상품을 선택해주세요.", "info");
			return;
		}
	});
	
	$(".count_update_btn").click(function(event){
		var count = $(event.currentTarget.parentNode).children(".input_count").val();
		var caNo = $(event.currentTarget.parentNode.parentNode.children).children(".caNo").val();
		
		$.ajax({
			url: "cartUpdate.pro", 
			type: "post", 
			data: {ca_no:caNo, ca_count:count},
			success: function(result){
				if(result == 1){
					swal("장바구니 수량 변경 성공", "", "success")
					.then((ok) => {
						if(ok){
							location.href="cartListForm.pro";
						}
					});
				}else{
					swal("장바구니 수량 변경 실패", "잠시후 다시 시도해주세요.", "error");
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