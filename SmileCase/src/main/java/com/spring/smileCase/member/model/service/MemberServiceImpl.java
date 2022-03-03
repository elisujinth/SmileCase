package com.spring.smileCase.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.smileCase.member.model.dao.MemberDAO;
import com.spring.smileCase.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	// @Service 어노테이션을 붙여야 얘가 Service인지 알아
	
	@Autowired
	MemberDAO mDAO;

	@Override
	public Member loginMember(Member m) {
		return mDAO.loginMember(m);
	}
	
	@Override
	public int insertMember(Member m) {
		return mDAO.insertMember(m);
	}

	@Override
	public String checkPwd(String loginUserId) {
		return mDAO.checkPwd(loginUserId);
	}

	@Override
	public Member selectMember(String loginUserId) {
		return mDAO.selectMember(loginUserId);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(m);
	}

	@Override
	public int deleteMember(String loginUserId) {
		return mDAO.deleteMember(loginUserId);
	}

	@Override
	public Member findId(Member m) {
		return mDAO.findId(m);
	}

	@Override
	public Member findPwd(Member m) {
		return mDAO.findPwd(m);
	}

	@Override
	public int changePwd(Member m) {
		return mDAO.changePwd(m);
	}

	@Override
	public List<Member> selectAllMember(String admin) {
		return mDAO.selectAllMember(admin);
	}

}
