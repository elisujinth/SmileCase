package com.spring.smileCase.product.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.smileCase.product.model.dao.ProductDAO;
import com.spring.smileCase.product.model.vo.Cart;
import com.spring.smileCase.product.model.vo.Product;
import com.spring.smileCase.product.model.vo.Review;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	ProductDAO pDAO;

	@Override
	public int allListCount() {
		return pDAO.allListCount();
	}

	@Override
	public int partListCount(String proCategory) {
		return pDAO.partListCount(proCategory);
	}

	@Override
	public List<Product> listProduct(RowBounds rowBounds) {
		return pDAO.listProduct(rowBounds);
	}

	@Override
	public List<Product> partListProduct(RowBounds rowBounds, String proCategory) {
		return pDAO.partListProduct(rowBounds, proCategory);
	}

	@Override
	public int insertProduct(Product p) {
		return pDAO.insertProduct(p);
	}

	@Override
	public Product detailProduct(int product_no) {
		return pDAO.detailProduct(product_no);
	}

	@Override
	public int deleteProduct(int proNo) {
		return pDAO.deleteProduct(proNo);
	}

	@Override
	public int reviewAdd(Review r) {
		return pDAO.reviewAdd(r);
	}

	@Override
	public List<Product> listReview(int proNo) {
		return pDAO.listReview(proNo);
	}

	@Override
	public int cartAdd(Cart c) {
		return pDAO.cartAdd(c);
	}

	@Override
	public List<Cart> cartList(String loginUserId) {
		return pDAO.cartList(loginUserId);
	}

	@Override
	public int cartDel(int caNo) {
		return pDAO.cartDel(caNo);
	}

	@Override
	public int cartChk(Cart c) {
		return pDAO.cartChk(c);
	}

	@Override
	public int cartUpdate(Cart c) {
		return pDAO.cartUpdate(c);
	}

	@Override
	public int updateProduct(Product p) {
		return pDAO.updateProduct(p);
	}

	@Override
	public int reviewDel(int reNo) {
		return pDAO.reviewDel(reNo);
	}

	@Override
	public int reviewUpdate(Review r) {
		return pDAO.reviewUpdate(r);
	}
	
}
