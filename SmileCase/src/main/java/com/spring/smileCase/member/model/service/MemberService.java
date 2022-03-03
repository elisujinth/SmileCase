package com.spring.smileCase.member.model.service;

import java.util.List;

import com.spring.smileCase.member.model.vo.Member;

public interface MemberService {
	Member loginMember(Member m);
	int insertMember(Member m);
	String checkPwd(String loginUserId);
	Member selectMember(String loginUserId);
	int updateMember(Member m);
	int deleteMember(String loginUserId);
	Member findId(Member m);
	Member findPwd(Member m);
	int changePwd(Member m);
	List<Member> selectAllMember(String admin);
}
