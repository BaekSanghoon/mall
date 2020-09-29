<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	//로그인 중임에도 이 파일을 접근했을때 강제로 인덱스로 보냄
	if(session.getAttribute("loginMemberEmail")!= null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	String memberEmail = request.getParameter("memberEmail");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	//사용가능한 이베일인지 확인
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberEmailCk(memberEmail);
	if(member != null) {
		System.out.println("이미 사용중인 이메일 입니다.");
		response.sendRedirect(request.getContextPath()+"/member/signup.jsp");
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberEmail(memberEmail);// = memberEmail; 
	paramMember.setMemberPw(memberPw);// = memberPw;
	paramMember.setMemberName(memberName);// = memberName;
	memberDao.insertMember(paramMember); //회원가입 호출
	
	
	//로그인성공
	response.sendRedirect(request.getContextPath()+"/member/login.jsp");
%>