package dao;


import java.sql.*;
import commons.DBUtil;
import vo.*;


public class MemberDao {
	
	public String login(Member member) throws Exception {
		String memberEmail = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email from member where member_email=? and member_pw= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			memberEmail = rs.getString("member_email");
		}
		conn.close();
		return memberEmail;
	}	
	
	public void insertMember(Member member) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "insert into member(member_email, member_pw, member_name, member_date) values(?,?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.executeLargeUpdate();
	
		
		conn.close();
	}
	
	public Member selectMemberEmailCk(String memberEmail) throws Exception {
		Member member = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select id from (select member_email id from member union select admin_id id from admin) t where id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			member = new Member();
			member.setMemberEmail(rs.getString("id"));
		}
		conn.close();
		
		return member;
	}
	public Member selectMemberOne(Member paramMember) throws Exception {
		Member returnMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_email, member_name, member_date FROM member WHERE member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberEmail());
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			returnMember = new Member();
			returnMember.setMemberEmail(rs.getString("member_email"));
			returnMember.setMemberName(rs.getString("member_name"));
			returnMember.setMemberDate(rs.getString("member_date"));
		}
		
		conn.close();
		
		return returnMember;
	}
}
