<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- productUpdate.css -->
<link rel="stylesheet" href="resources/css/product/productUpdate.css">
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
		<div id="insert_title">상품 수정</div>
		<form id="insertForm" method="post" action="update.pro" enctype="multipart/form-data" onsubmit="return checkSubmit();">
			<table>
				<tr>
					<td colspan="2">상품명과 이미지, 카테고리 수정은 상품 삭제 후 새로 등록해주세요.</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><img src="resources/images/${ p.getPro_originFileName() }"></td>
				</tr>
				<tr>
					<td class="first_td"><span>상품명</span></td>
					<td>
						<input type="hidden" id="proNo" name="pro_no" value="${ p.getPro_no() }">
						<input type="text" id="proName" class="insert_input" name="pro_name" value="${ p.getPro_name() }" readonly>
					</td>
				</tr>
				<tr>
					<td class="first_td"><span>가격</span></td>
					<td><input type="number" id="proPrice" class="insert_input" name="pro_price" min="0" value="${ p.getPro_price() }"></td>
				</tr>
				<tr>
					<td class="first_td"><span>재고</span></td>
					<td><input type="number" id="proStock" class="insert_input" name="pro_stock" min="0" value="${ p.getPro_stock() }"></td>
				</tr>
				<tr>
					<td class="first_td"><span>카테고리</span></td>
					<td>
						<input type="text" id="proCate" class="insert_input" name="pro_category" value="${ p.getPro_category() }" readonly>
					</td>
				</tr>
				<tr id="insert_tr">
					<td colspan="2">
						<button type="submit" id="update_btn">수정</button><a id="cancel_btn">취소</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	// ---------- 카테고리 radio 버튼 선택되게 ----------
	var hidden_cate = $("#hidden_cate").val();
	if(hidden_cate == "galaxy"){
		$("#radio_galaxy").prop("checked", true);
		$("#radio_iphone").prop("checked", false);
	}else if(hidden_cate == "iphone"){
		$("#radio_galaxy").prop("checked", false);
		$("#radio_iphone").prop("checked", true);
	}
	
	window.checkSubmit = function(){
		var name = $("#proName");
		var price = $("#proPrice");
		var stock = $("#proStock");
		
		if(name.val().trim() == ""){
			name.focus();
			swal("", "상품명을 입력해주세요.", "info");
			return false;
		}
		
		if(price.val().trim() == ""){
			price.focus();
			swal("", "가격을 입력해주세요.", "info");
			return false;
		}
		
		if(stock.val().trim() == ""){
			stock.focus();
			swal("", "재고 수량을 입력해주세요.", "info");
			return false;
		}
	};
	
	$("#cancel_btn").click(function(){
		var proNo = $("#proNo").val();
		location.href="detail.pro?proNo=" + proNo;
	});
</script>
</body>
</html>