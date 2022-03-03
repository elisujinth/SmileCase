package com.spring.smileCase.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.smileCase.product.model.vo.Cart;
import com.spring.smileCase.product.model.vo.Product;
import com.spring.smileCase.product.model.vo.Review;

@Repository
public class ProductDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	public int allListCount() {
		return sqlSession.selectOne("productMapper.allListCount");
	}

	public int partListCount(String proCategory) {
		return sqlSession.selectOne("productMapper.partListCount", proCategory);
	}
	
	public List<Product> listProduct(RowBounds rowBounds) {		
		return sqlSession.selectList("productMapper.listProduct", null, rowBounds);
	}

	public List<Product> partListProduct(RowBounds rowBounds, String proCategory) {
		return sqlSession.selectList("productMapper.partListProduct", proCategory, rowBounds);
	}

	public int insertProduct(Product p) {
		return sqlSession.insert("productMapper.insertProduct", p);
	}
	
	public Product detailProduct(int product_no) {
		return sqlSession.selectOne("productMapper.detailProduct", product_no);
	}

	public int deleteProduct(int proNo) {
		return sqlSession.delete("productMapper.deleteProduct", proNo);
	}

	public int reviewAdd(Review r) {
		return sqlSession.insert("productMapper.reviewAdd", r);
	}

	public List<Product> listReview(int proNo) {
		return sqlSession.selectList("productMapper.listReview", proNo);
	}

	public int cartAdd(Cart c) {
		return sqlSession.insert("productMapper.cartAdd", c);
	}

	public List<Cart> cartList(String loginUserId) {
		return sqlSession.selectList("productMapper.cartList", loginUserId);
	}

	public int cartDel(int caNo) {
		return sqlSession.delete("productMapper.cartDel", caNo);
	}

	public int cartChk(Cart c) {
		return sqlSession.selectOne("productMapper.cartChk", c);
	}

	public int cartUpdate(Cart c) {
		return sqlSession.update("productMapper.cartUpdate", c);
	}

	public int updateProduct(Product p) {
		return sqlSession.update("productMapper.updateProduct", p);
	}

	public int reviewDel(int reNo) {
		return sqlSession.delete("productMapper.reviewDel", reNo);
	}

	public int reviewUpdate(Review r) {
		return sqlSession.update("productMapper.reviewUpdate", r);
	}
	
}
