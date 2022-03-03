package com.spring.smileCase.product.model.vo;

public class Pagination {
	public static PageInfo getPageInfo(int currentPage, int listCount) {
		PageInfo pi = null;
		
		int pageLimit = 5;
		int maxPage;
		int startPage;
		int endPage;
		int productLimit = 9;
		
		maxPage = (int)Math.ceil((double)listCount / productLimit);
		// listCount / boardLimit ==> double형으로 형변환
		// Math.ceil로 올림
		// 올림해도 double형이므로 int형으로 형변환
		
		startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, productLimit);
		
		return pi;
	}
}
