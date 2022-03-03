package com.spring.smileCase.member.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.smileCase.member.model.vo.Member;

@Repository
public class MemberDAO {
	
	// Q. Autowired 어노테이션 붙이는 이유
	// A. SqlSessionTemplate sqlSession = new SqlSessionTemplate(); 랑 같은 느낌
	//	   근데 SqlSessionTemplate가 진짜 클래스명이 아니야. 진짜 따로있다.
	@Autowired
	SqlSessionTemplate sqlSession;
	// mapper.xml에 정의해둔 SQL문을 가져올 때 사용되는 클래스
	// MyBatis 구조에서만 사용 가능 (root-context.xml에서 선언해놨음)
	
	public Member loginMember(Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	public int insertMember(Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public String checkPwd(String loginUserId) {
		return sqlSession.selectOne("memberMapper.checkPwd", loginUserId);
	}

	public Member selectMember(String loginUserId) {
		return sqlSession.selectOne("memberMapper.selectMember", loginUserId);
	}

	public int updateMember(Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}

	public int deleteMember(String loginUserId) {
		return sqlSession.delete("memberMapper.deleteMember", loginUserId);
	}

	public Member findId(Member m) {
		return sqlSession.selectOne("memberMapper.findId", m);
	}

	public Member findPwd(Member m) {
		return sqlSession.selectOne("memberMapper.findPwd", m);
	}

	public int changePwd(Member m) {
		return sqlSession.update("memberMapper.changePwd", m);
	}

	public List<Member> selectAllMember(String admin) {
		return sqlSession.selectList("memberMapper.selectAllMember", admin);
	}
}
