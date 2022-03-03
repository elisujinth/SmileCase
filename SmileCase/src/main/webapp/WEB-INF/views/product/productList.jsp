<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
<!-- productList.css -->
<link rel="stylesheet" href="resources/css/product/productList.css">
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
		<div id="first_div">
			<div id="sub_menu_div" class="second_div">
				<c:if test="${ proCate eq 'all' }">
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=all" 
						style="color: rgba(155, 89, 182, 0.7);">전체</a>
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=galaxy">갤럭시</a>
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=iphone">아이폰</a>
				</c:if>
				<c:if test="${ proCate eq 'galaxy' }">
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=all">전체</a>
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=galaxy" 
						style="color: rgba(155, 89, 182, 0.7);">갤럭시</a>
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=iphone">아이폰</a>
				</c:if>
				<c:if test="${ proCate eq 'iphone' }">
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=all">전체</a>
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=galaxy">갤럭시</a>
					<a href="<%= request.getContextPath() %>/list.pro?proCategory=iphone" 
						style="color: rgba(155, 89, 182, 0.7);">아이폰</a>
				</c:if>
			</div>
			<div id="list_size_div" class="second_div">
				<span>총 ${ pi.listCount }개</span>
			</div>
		</div>
		
		<table id="list_table">
			<c:url var="prodetail" value="detail.pro">
				<c:param name="page" value="${ pi.currentPage }"/>
			</c:url>
			<c:set var="i" value="1"></c:set>
			<c:set var="k" value="1"></c:set>
			<c:forEach var="j" items="${ list }" varStatus="status">
				<!-- 첫 줄로 틀 잡기 -->
				<c:if test="${ k % 9 == 1 }">
					<tr>
						<td style="padding: 0px 70px 0px 70px; height: 1px;"></td>
						<td style="padding: 0px 70px 0px 70px; height: 1px;"></td>
						<td style="padding: 0px 70px 0px 70px; height: 1px;"></td>
					</tr>
				</c:if>
				<c:if test="${ i % 3 == 1 }">
					<tr>
				</c:if>
				<td>
					<div class="pro_all_div">
						<c:if test="${ j.getPro_stock() != 0 }">
							<a href="<%= request.getContextPath() %>/detail.pro?proNo=${ j.getPro_no() }">
								<img src="resources/images/${ j.getPro_originFileName() }"><br>
								<b>${ j.getPro_name() }</b>[${ j.getPro_category() }]<br>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${ j.getPro_price() }"/>원
							</a>
						</c:if>
						<c:if test="${ j.getPro_stock() == 0 }">
							<a>
								<img src="resources/images/${ j.getPro_originFileName() }"><br>
								<span style="color: red;">!품절!</span>
								<b>${ j.getPro_name() }</b>[${ j.getPro_category() }]<br>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${ j.getPro_price() }"/>원
							</a>
						</c:if>
					</div>
				</td>
				<c:if test="${ i % 3 == 0 }">
					</tr>
				</c:if>
				<c:set var="i" value="${ i + 1 }"></c:set>
				<c:set var="k" value="${ k + 1 }"></c:set>
			</c:forEach>
		</table>
		
		<c:if test="${ proCate eq 'all' }">
			<c:set var="varCate" value="all"></c:set>
		</c:if>
		<c:if test="${ proCate eq 'galaxy' }">
			<c:set var="varCate" value="galaxy"></c:set>
		</c:if>
		<c:if test="${ proCate eq 'iphone' }">
			<c:set var="varCate" value="iphone"></c:set>
		</c:if>
		
		<!-- 페이징 -->
		<div class="paging">
			<!-- 이전 페이지 -->
			<c:if test="${ pi.currentPage > 1}">
				<c:url var="before" value="list.pro?proCategory=${ varCate }">
					<c:param name="page" value="${ pi.currentPage - 1 }"/>
				</c:url>
				<a href="${ before }" class="before">&lt;</a>
			</c:if>
			<!-- 첫 페이지에서는 이전 버튼 안보이게 -->
			<c:if test="${ pi.currentPage == 1 }">
				<a href="${ before }" class="before hidden">&lt;</a>
			</c:if>
			
			<!-- 현재 페이지 -->
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${ p eq pi.currentPage }">
					<a class="choosen">${ p }</a>
				</c:if>
				<c:if test="${ p ne pi.currentPage }">
					<c:url var="pagination" value="list.pro?proCategory=${ varCate }">
						<c:param name="page" value="${ p }"/>
					</c:url>
					<a href="${ pagination }" class="num">${ p }</a>
				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지 -->
			<c:if test="${ pi.currentPage < pi.maxPage }">
				<c:url var="after" value="list.pro?proCategory=${ varCate }">
					<c:param name="page" value="${ pi.currentPage + 1 }"/>
				</c:url> 
				<a href="${ after }" class="after">&gt;</a>
			</c:if>
			<!-- 마지막 페이지에서는 다음 버튼 안보이게 -->
			<c:if test="${ pi.currentPage == pi.maxPage }">
				<a href="${ after }" class="after hidden">&gt;</a>
			</c:if>
		</div>
		
		<!-- 관리자 - 상품 등록 버튼 -->
		<c:if test="${ loginUserId eq 'admin' }">
			<div id="insert_div">
				<a href="insertForm.pro" id="insert_btn">상품 등록</a>
			</div>
		</c:if>
	</div>
</section>

<footer>
	<c:import url="../common/footer.jsp" />
</footer>

<script type="text/javascript">
</script>
</body>
</html>