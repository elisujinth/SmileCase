<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- productDetail.css -->
<link rel="stylesheet" href="resources/css/product/productDetail.css">
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
	<div id="product_div">
		<div id="img_div">
			<img src="resources/images/${ p.getPro_originFileName() }"><br>
		</div>
		<div id="spec_div">
			<input type="hidden" id="proNo" name="pro_no" value="${ p.getPro_no() }">
			<span>[ ${ p.getPro_category() } ]</span><br>
			<span>상품명 : ${ p.getPro_name() }</span><br>
			<span>가격 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${ p.getPro_price() }"/>원</span><br>
			<span>재고 : ${ p.getPro_stock() }</span><br>
			<span>수량 : </span>
			<input type="number" id="buy_input" min="0">
			<input type="button" id="cart_btn" value="장바구니">
			<input type="button" id="buy_btn" value="구매하기">
			
			<!-- 관리자 - 상품 삭제 버튼 -->
			<c:if test="${ loginUserId eq 'admin' }">
				<a href="<%= request.getContextPath() %>/updateForm.pro?proNo=${ p.getPro_no() }" id="update_btn">수정</a>
				<a href="<%= request.getContextPath() %>/delete.pro?proNo=${ p.getPro_no() }" id="delete_btn">삭제</a>
			</c:if>
		</div>
	</div>
	<div id="review_all_div">
		<h3>Review</h3>
		<input type="hidden" id="memId" name="mem_id" value="${ loginUserId }">
		<textarea rows="4" cols="120" id="content" name="re_content"></textarea>
		<input type="submit" id="input_button" value="등록">
		<c:forEach var="i" items="${ list }" varStatus="status">
			<c:set var="reNo" value="${ i.getRe_no() }"></c:set>
			<div class="review_div">
				<input type="hidden" class="hidden_reNo" value="${ reNo }">
				<c:if test="${ i.getMem_id() eq loginUserId }">
					<div>
						${ i.getMem_id() } 님 | ${ i.getRe_date() } | <button class="reBtn re_update_btn">&lt;수정&gt;</button><button class="reBtn re_complete_btn" style="display:none;">&lt;완료&gt;</button>
						<a href="reviewDel.pro?proNo=${ p.getPro_no() }&reNo=${ reNo }" class="reA">&lt;삭제&gt;</a>
						<a href="javascript:;" class="reA re_cancel_btn" style="display:none;">&lt;취소&gt;</a>
					 </div>
				</c:if>
				<c:if test="${ i.getMem_id() ne loginUserId }">
					<div>${ i.getMem_id() } 님 | ${ i.getRe_date() } | </div>
				</c:if>
				<div class="re_content_div" style="margin-top: 5px;">${ i.getRe_content() }</div>
				<textarea rows="4" cols="120" class="re_content_ta" style="display: none;">${ i.getRe_content() }</textarea>
			</div>
		</c:forEach>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	$("#cart_btn, #buy_btn").click(function(){
		var count = $("#buy_input");
		
		if(count.val().trim().length == 0){
			swal("", "수량을 입력해주세요.", "info");
			return;
		}
	});
	
	$("#cart_btn").click(function(){
		var proNo = $("#proNo").val();
		var memId = $("#memId").val();
		var count = $("#buy_input").val();
		
		$.ajax({
			url: "cartChk.pro", 
			type: "post", 
			data: {pro_no:proNo, mem_id:memId}, 
			success: function(result){
				if(result == 1){
					// 이미 장바구니에 동일한 상품이 담겨있는 경우
					swal({
						text: "장바구니에 동일한 상품이 담겨있습니다.\n장바구니로 이동하시겠습니까?",
						icon: "info", 
						buttons: ["취소", "확인"]
					}).then((ok) => {
						if(ok){
							location.href="cartListForm.pro";
						}else{
							$("#buy_input").focus();
						}
					});
				} else{
					// 장바구니에 동일한 상품이 담겨있지 않는 경우로, 장바구니에 새로 추가하면 됨
					$.ajax({
						url: "cartAdd.pro", 
						type: "post", 
						data: {pro_no:proNo, mem_id:memId, ca_count:count}, 
						success: function(result){
							if(result == 1){
								swal({
									title: "장바구니 추가 완료!", 
									text: "장바구니로 이동하시겠습니까?", 
									icon: "success", 
									buttons: ["취소", "확인"]
								}).then((ok) => {
									if(ok){
										// swal창에서 확인 버튼 누른 경우
										// 장바구니 목록 페이지로 경로 변경 필요
										location.href="cartListForm.pro";
									}else{
										// swal창에서 취소 버튼 누른 경우
										$("#buy_input").val("");
									}
								});
							}else{
								swal("장바구니 추가 실패", "", "error");
							}
						}, 
						error: function(data){
							alert("ajax에러 발생");
						} 
					});
				}
			}, 
			error: function(data){
				alert("ajax에러 발생");
			}
		});
		
		
	});
	
	$("#input_button").click(function(){
		var proNo = $("#proNo").val();
		var memId = $("#memId").val();
		var content = $("#content").val();
		
		if(content.trim().length == 0){
			swal("", "리뷰 내용을 입력해주세요.", "info");
			return;
		}
		
		$.ajax({
			url: "reviewAdd.pro", 
			type: "post", 
			data: {pro_no:proNo, mem_id:memId, re_content:content}, 
			success: function(result){
				if(result == 1){
					swal("리뷰 작성 완료", "", "success")
					.then((ok) => {
						if(ok){
							location.href="detail.pro?proNo=" + proNo;
						}
					});
				}else{
					swal("리뷰 작성 실패", "", "error");
				}
			}, 
			error: function(data){
				alert("ajax에러 발생");
				// ajax 에러 자세하게 보고싶으면
				// data 대신 request,status,error
				// alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	
	$(".re_update_btn").click(function(event){
		// 리뷰 내용 - div, textarea
		var content_div = $(event.currentTarget.parentNode.parentNode).children(".re_content_div");
		//					------------------- button태그 - 수정버튼
		//					------------------------------ div태그 - 작성자, 작성날짜, 수정, 삭제 묶어놓은 div
		//					----------------------------------------- div태그 - .review_div
		var content_ta = $(event.currentTarget.parentNode.parentNode).children(".re_content_ta");
		content_div.css("display", "none");
		content_ta.css("display", "block");
		
		// 리뷰 버튼 - 수정, 완료, 취소
		var update_btn = $(event.currentTarget);
		var complete_btn = $(event.currentTarget.parentNode).children(".re_complete_btn");
		var cancel_btn = $(event.currentTarget.parentNode).children(".re_cancel_btn");
		update_btn.css("display", "none");
		complete_btn.css("display", "inline");
		cancel_btn.css("display", "inline");
		
		// 상품 번호, 리뷰 번호
		var proNo = $("#proNo").val();
		var re_no = $(event.currentTarget.parentNode.parentNode).children(".hidden_reNo").val();
		
		// 완료 버튼 클릭 시
		complete_btn.click(function(event){
			var content = content_ta.val();

			if(content.trim().length == 0){
				swal("", "리뷰 내용을 입력해주세요.", "info");
				return;
			}
			
			$.ajax({
				url: "reviewUpdate.pro", 
				type: "post", 
				data: {re_no:re_no, re_content:content}, 
				success: function(result){
					if(result == 1){
						swal("리뷰 수정 완료", "", "success")
						.then((ok) => {
							if(ok){
								location.href="detail.pro?proNo=" + proNo;
							}
						});
					}else{
						swal("리뷰 수정 실패", "", "error");
					}
				}, 
				error: function(data){
					alert("ajax에러 발생");
					// ajax 에러 자세하게 보고싶으면
					// data 대신 request,status,error
					// alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 취소 버튼 클릭 시
		cancel_btn.click(function(event){
			content_div.css("display", "block");
			content_ta.css("display", "none");

			update_btn.css("display", "inline");
			complete_btn.css("display", "none");
			cancel_btn.css("display", "none");
		});
	});
</script>
</body>
</html>