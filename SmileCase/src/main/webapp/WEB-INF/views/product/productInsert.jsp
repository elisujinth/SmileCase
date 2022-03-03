<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- productInsert.css -->
<link rel="stylesheet" href="resources/css/product/productInsert.css">
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
		<div id="insert_title">상품 등록</div>
		<form id="insertForm" method="post" action="insert.pro" enctype="multipart/form-data" onsubmit="return checkSubmit();">
			<table>
				<tr>
					<td class="first_td"><span>상품명</span></td>
					<td><input type="text" id="proName" class="insert_input" name="pro_name"></td>
				</tr>
				<tr>
					<td class="first_td"><span>가격</span></td>
					<td><input type="number" id="proPrice" class="insert_input" name="pro_price" min="0"></td>
				</tr>
				<tr>
					<td class="first_td"><span>재고</span></td>
					<td><input type="number" id="proStock" class="insert_input" name="pro_stock" min="0"></td>
				</tr>
				<tr>
					<td class="first_td"><span>카테고리</span></td>
					<td>
						<input type="radio" name="pro_category" value="galaxy">Galaxy
						<input type="radio" name="pro_category" value="iphone">iPhone
					</td>
				</tr>
				<tr>
					<td colspan="2" id="file_td"><input type="file" id="proImage" name="pro_image">
				</tr>
				<tr id="insert_tr">
					<td colspan="2"><button type="submit">등록</button>
				</tr>
			</table>
		</form>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
	window.checkSubmit = function(){
		var name = $("#proName");
		var price = $("#proPrice");
		var stock = $("#proStock");
		var category = $("input[name='pro_category']");
		var image = $("#proImage").val();
		
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
		
		if(category.is(":checked") == false){
			swal("", "카테고리를 선택해주세요.", "info");
			return false;
		}
		
		if(image == ""){
			swal("", "상품 이미지를 선택해주세요.", "info");
			return false;
		}
	};
</script>
</body>
</html>