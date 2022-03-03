package com.spring.smileCase.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.smileCase.common.sendMail;
import com.spring.smileCase.member.model.service.MemberService;
import com.spring.smileCase.member.model.vo.Member;

@Controller
// 여기에도 @RequestMapping("") 사용 가능
public class MemberController {
	
	@Autowired
	MemberService mService;
	
	// 로그인 화면으로 이동
	@RequestMapping("loginForm.me")
	public String loginForm() {
		return "login";
	}
	
	// 로그인
	@RequestMapping("login.me")
	public void login(Member m, HttpServletResponse response, HttpSession session) throws IOException {
		Member loginUser = mService.loginMember(m);
		
		if(loginUser != null) {
			session.setAttribute("loginUserId", loginUser.getMem_id());
			
			response.getWriter().print("1");
		} else {
			response.getWriter().print("0");
		}
	}
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logout(HttpServletRequest request) {
		// session 초기화
		request.getSession().invalidate();
		
		return "redirect:/";
	}
	
	// 회원가입 화면으로 이동
	@RequestMapping("joinForm.me")
	public String joinForm() {
		return "join";
	}
	
	// 회원가입
	@RequestMapping("join.me")
	public String insertMember(Member m, HttpServletRequest request) {
		//System.out.println("memberController - 회원가입 m : " + m);
		// Q. form에서 받아온 값을 어떻게 Member객체에 담는건지
		// A. RequestMapping이 vo에 있는 getter, setter 메소드를 이용해서 
		//	  input박스의 데이터를 객체(Member m)에 담음
		//	   그래서 input 태그의 name 속성값과 vo의 변수명이 동일해야함
		//	   이러한 구조가 Spring Framework
		
		String mem_email = m.getMem_email() + "@" + m.getMem_email2();
		m.setMem_email(mem_email);
		
		int result = mService.insertMember(m);
		
		if(result > 0) {
			return "redirect:/loginForm.me";
		}else {
			request.setAttribute("errorMsg", "회원가입 중 에러가 발생하였습니다.");
			return "../common/errorPage";
		}
	}
	
	// 아이디 중복 확인
	@RequestMapping("checkId.me")
	public void checkId(Member m, HttpServletResponse response) throws IOException {
		Member loginUser = mService.selectMember(m.getMem_id());
		
		if(loginUser != null) {
			// 아이디가 중복되는 경우
			response.getWriter().print("1");
		} else {
			// 아이디가 중복되지 않는 경우
			response.getWriter().print("0");
		}
	}
	
	// 마이페이지 이동 전 - 비밀번호 확인 화면으로 이동
	@RequestMapping("checkPwdForm.me")
	public String checkPwdForm() {
		return "checkPwd";
	}
	
	// 마이페이지 이동 전 - 비밀번호 확인
	@RequestMapping("checkPwd.me")
	public void checkPwd(Member m, HttpSession session, HttpServletResponse response) throws IOException {
		String loginUserId = (String)session.getAttribute("loginUserId");
		String input_pwd = m.getMem_pwd();
		//System.out.println("memberController - 비밀번호 확인 - m.pwd : " + m.getMem_pwd());
		
		String db_pwd = mService.checkPwd(loginUserId); 
		//System.out.println("memberController - 비밀번호 확인 - db_pwd : " + db_pwd);
		
		if(input_pwd.equals(db_pwd)) {
			response.getWriter().print("1");
		}else {
			response.getWriter().print("0");
		}
	}
	
	// 마이페이지 화면으로 이동
	@RequestMapping("mypageForm.me")
	public String mypageForm(HttpServletRequest request, HttpSession session) {
		// 나중에) "세션이 만료된 경우 다시 로그인 페이지로 이동" 기능 추가
		// 나중에) 마이페이지 화면 이동 전, 비밀번호 확인하는 기능 추가
		
		String loginUserId = (String)session.getAttribute("loginUserId");
		Member loginUser = mService.selectMember(loginUserId);
		//System.out.println("memberController - 마이페이지로 이동 - 세팅 전 loginUser : " + loginUser);
		
		String db_email = loginUser.getMem_email();
		String[] arr_email = db_email.split("@");
		//System.out.println("memberController - 마이페이지로 이동 arr_email[0] : " + arr_email[0]);
		//System.out.println("memberController - 마이페이지로 이동 arr_email[1] : " + arr_email[1]);
		
		loginUser.setMem_email(arr_email[0]);
		loginUser.setMem_email2(arr_email[1]);
		//System.out.println("memberController - 마이페이지로 이동 - 세팅 후 loginUser : " + loginUser);
		
		// 마이페이지 화면으로 이동할 때 loginUser에 로그인한 사용자의 정보를 담음
		request.setAttribute("loginUser", loginUser);
		
		return "updateMypage";
	}
	
	// 회원 정보 수정
	@RequestMapping("update.me")
	public String updateMember(Member m, HttpServletRequest request) {
		//System.out.println("memberController - 회원정보수정 m : " + m);
		String originPwd = request.getParameter("originalPwd");
		
		// 비밀번호 변경하지 않은 경우) 변수 mem_pwd에 원래 비밀번호 저장
		if(m.getMem_pwd() == "") {
			m.setMem_pwd(originPwd);
		}

		String mem_email = m.getMem_email() + "@" + m.getMem_email2();
		m.setMem_email(mem_email);
		
		int result = mService.updateMember(m);
		
		if(result > 0) {
			return "redirect:/checkPwdForm.me";
		}else {
			request.setAttribute("errorMsg", "회원 정보 수정 중 에러가 발생하였습니다.");
			return "../common/errorPage";
		}
	}
	
	// 회원 탈퇴
	@RequestMapping("delete.me")
	public void deleteMember(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String loginUserId = (String)session.getAttribute("loginUserId");
				
		int result = mService.deleteMember(loginUserId);
		
		if(result > 0) {
			//System.out.println("memberController - session 초기화 전 : " + request.getSession(false));
			request.getSession().invalidate();
			//System.out.println("memberController - session 초기화 후 : " + request.getSession(false));
			
			response.getWriter().println("1");
		}else {
			response.getWriter().println("0");
		}
	}
	
	// 아이디 찾기 화면으로 이동
	@RequestMapping("findIdForm.me")
	public String findIdForm() {
		return "findId";
	}
	
	// 아이디 찾기
	@RequestMapping("findId.me")
	public void findId(Member m, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//System.out.println("memberController - 아이디 찾기 m : " + m);
		String email = m.getMem_email();
		
		Member findUser = mService.findId(m);
		
		if(findUser != null) {
			// 이메일 전송
			String id =findUser.getMem_id();
			String cut_id = id.substring(0, 3);
			
			new sendMail().sendEmail("id", email, cut_id);
			
			response.getWriter().println("1");
			
		} else {
			response.getWriter().println("0");
		}
	}
	
	// 비밀번호 찾기 화면으로 이동
	@RequestMapping("findPwdForm.me")
	public String findPwdForm() {
		return "findPwd";
	}
	
	// 비밀번호 찾기
	@RequestMapping("findPwd.me")
	public void findPwd(Member m, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//System.out.println("memberController - 비밀번호 찾기 m : " + m);
		String id = m.getMem_id();
		
		Member findUser = mService.findPwd(m);
		
		if(findUser != null) {
			// 이메일 전송
			String email = findUser.getMem_email();
			String temporaryPwd = "";
			
			// 임시 비밀번호 발급
			// 배열 이용 ==> 소문자, 숫자, 특수문자 포함 10글자
			char[] pwArr = new char[] {
					'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 
					'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
					'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
					'~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '|', '<', '>', '?', ':', '{', '}'
			};
			
			for(int i = 0; i < 10; i++) {
				int selectRandomPwd = (int)(Math.random() * pwArr.length);// 0 ~ 82
				
				temporaryPwd += pwArr[selectRandomPwd];
			}
			
			m.setMem_id(id);
			m.setMem_pwd(temporaryPwd);
			//System.out.println("memberController - 비밀번호 찾기 - 임시비밀번호 m : " + m);
			
			// DB에 저장된 비밀번호 -> 임시 비밀번호로 변경
			int result = mService.changePwd(m);
			
			//System.out.println("memberController - 비밀번호 찾기 - 임시비밀번호변경 result : " + result);
			
			if(result == 1) {
				new sendMail().sendEmail("pwd", email, temporaryPwd);
			
				response.getWriter().println("1");
			} else {
				response.getWriter().println("0");
			}
			
		} else {
			response.getWriter().println("0");
		}
	}
	
	// 관리자 - 회원관리 화면으로 이동
	@RequestMapping("memManageForm.me")
	public String memManageForm(HttpServletRequest reqeust) {
		String admin = "admin";
		
		List<Member> list = new ArrayList<>();
		list = mService.selectAllMember(admin);
		//System.out.println("memberController - 회원관리 list : " + list);

		reqeust.setAttribute("list", list);
		
		return "memManage";
	}
	
	// 관리자 - 회원관리에서 회원 삭제
	@RequestMapping("adminDel.me")
	public void adminDel(@RequestParam("mem_id") String mem_id, HttpServletResponse response) throws IOException {
		//System.out.println("memberController - 회원관리-회원삭제 mem_id : " + mem_id);
		int result = mService.deleteMember(mem_id);
		
		if(result > 0) {
			response.getWriter().println("1");
		}else {
			response.getWriter().println("0");
		}
	}
}
