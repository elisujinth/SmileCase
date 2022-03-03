package com.spring.smileCase.product.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.spring.smileCase.product.model.vo.Cart;
import com.spring.smileCase.product.model.vo.Product;
import com.spring.smileCase.product.model.vo.Review;

public interface ProductService {

	int allListCount();
	int partListCount(String proCategory);
	List<Product> listProduct(RowBounds rowBounds);
	List<Product> partListProduct(RowBounds rowBounds, String proCategory);
	int insertProduct(Product p);
	Product detailProduct(int product_no);
	int deleteProduct(int proNo);
	int reviewAdd(Review r);
	List<Product> listReview(int proNo);
	int cartAdd(Cart c);
	List<Cart> cartList(String loginUserId);
	int cartDel(int caNo);
	int cartChk(Cart c);
	int cartUpdate(Cart c);
	int updateProduct(Product p);
	int reviewDel(int reNo);
	int reviewUpdate(Review r);
}
