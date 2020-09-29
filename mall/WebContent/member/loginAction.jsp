<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%
	if(session.getAttribute("loginMemberEmail")!=null) {
	response.sendRedirect(request.getContextPath()+"/index.jsp");
	return;
	}
	request.setCharacterEncoding("utf-8");

	String memberEmail = request.getParameter("memberEmail");
	String memberPw = request.getParameter("memberPw");
	
	System.out.println(memberEmail+"<-memberEmail");
	System.out.println(memberPw+"<-memberPw");

	Member paramMember = new Member();
	paramMember.setMemberEmail(memberEmail); //
	paramMember.setMemberPw(memberPw);  //
	
	MemberDao memberDao = new MemberDao();
	String loginMemberEmail = memberDao.login(paramMember);
	if(loginMemberEmail == null) {
		System.out.println("loginMemberEmail == null");
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
	} else {
		session.setAttribute("loginMemberEmail", loginMemberEmail);
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}

%>