package com.spring.smileCase.product.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.smileCase.product.model.service.ProductService;
import com.spring.smileCase.product.model.vo.Cart;
import com.spring.smileCase.product.model.vo.PageInfo;
import com.spring.smileCase.product.model.vo.Pagination;
import com.spring.smileCase.product.model.vo.Product;
import com.spring.smileCase.product.model.vo.Review;

@Controller
public class ProductController {
	@Autowired
	ProductService pService;
	
	// 상품 목록보기
	@RequestMapping("list.pro")
	public ModelAndView listProduct(@RequestParam(value="page", required=false) Integer page, @RequestParam(value="proCategory", required=false) String proCategory, ModelAndView mv) {
		// @RequestParam -> required=false : 해당 필드가 쿼리스트링에 존재하지 않아도 예외가 발생하지 않음
		//System.out.println("product controller - proCategory : " + proCategory);
		// 리스트 개수
		int listCount = 0;
		if(proCategory.equals("all")) {
			// 하위 메뉴-전체 클릭한 경우
			listCount = pService.allListCount();
		} else if(proCategory.equals("galaxy")) {
			// 하위 메뉴-갤럭시 클릭한 경우
			listCount = pService.partListCount(proCategory);
		} else if(proCategory.equals("iphone")) {
			// 하위 메뉴-아이폰 클릭한 경우
			listCount = pService.partListCount(proCategory);
		}
		
		// 페이징
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		// 상품 전체 목록
		// RowBounds : 마이바티스로 하여금 특정 개수 만큼의 레코드를 건너띄게 함. 
		// 			   offset 만큼 건너띄고 limit 만큼 가져옴 => RowBounds(offset, limit)
		int offset = (pi.getCurrentPage() - 1) * pi.getProductLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getProductLimit());
		
		List<Product> list = new ArrayList<>();
		if(proCategory.equals("all")) {
			// 하위 메뉴-전체 클릭한 경우
			list = pService.listProduct(rowBounds);
		} else if(proCategory.equals("galaxy")) {
			// 하위 메뉴-갤럭시 클릭한 경우
			list = pService.partListProduct(rowBounds, proCategory);
		} else if(proCategory.equals("iphone")) {
			// 하위 메뉴-아이폰 클릭한 경우
			list = pService.partListProduct(rowBounds, proCategory);
		}
		
		
		// view로 값 전달
		if(list != null) {
			mv.addObject("proCate", proCategory);
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			
			mv.setViewName("productList");
		}
		return mv;
	}
	
	// 상품 등록하기 화면으로 이동 - 관리자
	@RequestMapping("insertForm.pro")
	public String insertForm() {
		return "productInsert";
	}
	
	// 상품 등록하기 - 관리자
	@RequestMapping("insert.pro")
	public String insertProduct(Product p, HttpServletRequest request) {
		MultipartFile file = p.getPro_image();
		String originFileName = file.getOriginalFilename();
		
		p.setPro_originFileName(originFileName);
		
		int result = pService.insertProduct(p);
		
		if(result > 0) {
			return "redirect:/list.pro";
		}else {
			request.setAttribute("errorMsg", "상품등록 중 에러가 발생하였습니다.");
			return "../common/errorPage";
		}
	}
	
	// 상품 상세보기
	@RequestMapping("detail.pro")
	public String detailProduct(@RequestParam(value="proNo", defaultValue="0") int proNo, HttpSession session, HttpServletRequest request, Review r) {
		// 설명: @RequestParam("proNo") int proNo 
		//		URL에 있는 쿼리스트링 가져옴
		//System.out.println("product controller - 리뷰등록 r(1) : " + r);
		
		if(session.getAttribute("loginUserId") == null) {
			// 로그인 되어있지 않으면 로그인 화면으로 이동
			return "redirect:/loginForm.me";
		}else if(session.getAttribute("loginUserId") != null) {
			// 로그인 되어있는 경우에만 상세보기 페이지로 이동
			// 상세보기만
			Product p = pService.detailProduct(proNo);
			//System.out.println("product controller - 상세보기 p : " + p);
			
			// 리뷰 목록 불러옴
			List<Product> list = new ArrayList<>();
			list = pService.listReview(proNo);
			//System.out.println("product controller - 리뷰목록보기 list : " + list);
			
			// view로 값 전달
			if(p != null && list != null) {
				//System.out.println("product controller - p : " + p);
				request.setAttribute("p", p);
				request.setAttribute("list", list);
				
				return "productDetail";
			}
		}
		return "productDetail";
	}
	
	// 리뷰 등록하기
	@RequestMapping("reviewAdd.pro")
	public void reviewAdd(Review r, HttpServletResponse response) throws IOException {
		//System.out.println("product controller - 리뷰등록 - 날짜 저장 전 r : " + r);
		
		Date date = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		String strDate = simpleDateFormat.format(date);
		
		r.setRe_date(strDate);
		//System.out.println("product controller - 리뷰등록 - 날짜 저장 후 r : " + r);
		
		int result = pService.reviewAdd(r);
		//System.out.println("product controller - 리뷰등록 result : " + result);
		
		if(result > 0) {
			response.getWriter().println("1");
		}else {
			response.getWriter().println("0");
		}
	}
	
	// 상품 삭제하기
	@RequestMapping("delete.pro")
	public String deleteProduct(@RequestParam("proNo") int proNo, HttpServletRequest request) {
		
		int result = pService.deleteProduct(proNo);
		
		if(result > 0) {
			return "redirect:/list.pro";
		}else {
			request.setAttribute("errorMsg", "상품삭제 중 에러가 발생하였습니다.");
			return "../common/errorPage";
		}
	}
	
	// 장바구니 추가하기
	@RequestMapping("cartAdd.pro")
	public void cartAdd(Cart c, HttpServletResponse response) throws IOException {
		//System.out.println("product controller - 장바구니 추가 c : " + c);
		int result = pService.cartAdd(c);
		
		if(result > 0) {
			response.getWriter().println("1");
		} else {
			response.getWriter().println("0");
		}
	}

	// 장바구니 화면으로 이동
	@RequestMapping("cartListForm.pro")
	public String cartListForm(HttpSession session, HttpServletRequest request) {
		String loginUserId = (String)session.getAttribute("loginUserId");
		//System.out.println("product controller - 장바구니 loginUserId : " + loginUserId);
		
		List<Cart> list = new ArrayList<>();
		list = pService.cartList(loginUserId);
		//System.out.println("product controller - 장바구니 list : " + list);
		
		request.setAttribute("list", list);
		
		return "cartList";
	}
	
	// 장바구니 삭제
	@RequestMapping("cartDel.pro")
	public void cartDel(@RequestParam(value = "chbox[]") List<String> chArr, HttpSession session, HttpServletResponse response) throws IOException {
		//System.out.println("product controller - 장바구니 삭제 : " + chArr);
		int result = 0;
		int caNo = 0;
		
		for(int i = 0; i < chArr.size(); i++) {
			caNo = Integer.parseInt(chArr.get(i));
			//System.out.println("product controller - 장바구니 삭제 chArr.get : " + chArr.get(i));
			result = result + pService.cartDel(caNo);
		}
		
		if(result == chArr.size()) {
			result = 1;
		}else {
			result = 0;
		}
		
		if(result > 0) {
			response.getWriter().println("1");
		} else {
			response.getWriter().println("0");
		}
	}
	
	// 장바구니 체크 (동일한 상품이 담겨있는지)
	@RequestMapping("cartChk.pro")
	public void cartChk(Cart c, HttpServletResponse response) throws IOException {
		//System.out.println("product controller - 장바구니 체크 : " + c);
		
		int chk = pService.cartChk(c);
		
		if(chk == 1) {
			response.getWriter().println("1");
		}else {
			response.getWriter().println("0");
		}
	}
	
	// 장바구니 수량 변경 (update)
	@RequestMapping("cartUpdate.pro")
	public void cartUpdate(Cart c, HttpServletResponse response) throws IOException {
		System.out.println("product controller - 장바구니 수량 변경 : " + c);
		
		int result = pService.cartUpdate(c);
		
		if(result > 0) {
			response.getWriter().println("1");
		}else {
			response.getWriter().println("0");
		}
	}
	
	// 상품 수정하기 화면으로 이동
	@RequestMapping("updateForm.pro")
	public String updateProductForm(@RequestParam("proNo") int proNo, HttpServletRequest request) {
		Product p = pService.detailProduct(proNo);
		
		request.setAttribute("p", p);
		
		return "productUpdate";
	}
	
	// 상품 수정하기
	@RequestMapping("update.pro")
	public String updateProduct(Product p, HttpServletRequest request) {
		System.out.println("product controller - 수정하기 p : " + p);
		int proNo = p.getPro_no();
		
		int result = pService.updateProduct(p);
		
		if(result > 0) {
			return "redirect:/detail.pro?proNo=" + proNo;
		}else {
			request.setAttribute("errorMsg", "상품 수정 중 에러가 발생하였습니다.");
			return "../common/errorPage";
		}
	}
	
	// 리뷰 수정하기
	@RequestMapping("reviewUpdate.pro")
	public void reviewUpdate(Review r, HttpServletResponse response) throws IOException {
		System.out.println("product controller - 리뷰 수정하기 r : " + r);
		int result = pService.reviewUpdate(r);

		if(result > 0) {
			response.getWriter().println("1");
		}else {
			response.getWriter().println("0");
		}
	}
	
	// 리뷰 삭제하기
	@RequestMapping("reviewDel.pro")
	public String reviewDel(@RequestParam("proNo") int proNo, @RequestParam("reNo") int reNo, HttpServletRequest request) {
		System.out.println("product controller - 리뷰 삭제하기 proNo : " + proNo);
		System.out.println("product controller - 리뷰 삭제하기 reNo : " + reNo);
		
		int result = pService.reviewDel(reNo);
		
		if(result > 0) {
			return "redirect:/detail.pro?proNo=" + proNo;
		}else {
			request.setAttribute("errorMsg", "리뷰 삭제 중 에러가 발생하였습니다.");
			return "../common/errorPage";
		}
	}
}
