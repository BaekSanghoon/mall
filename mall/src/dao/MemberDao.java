package dao;


import java.sql.*;
import commons.DBUtil;
import vo.*;


public class MemberDao {
	// 濡쒓렇�씤�떆 �씠硫붿씪怨� 鍮꾨�踰덊샇 泥댄겕
	public String login(Member member) throws Exception {
		String memberEmail = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email from member where member_email=? and member_pw= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { //濡쒓렇�씤 �꽦怨듭떆 �씠硫붿씪 由ы꽩
			memberEmail = rs.getString("member_email");
		}
		conn.close();
		return memberEmail;
	}	
	// 留대쾭 �젙蹂� �엯�젰
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
	// �씠硫붿씪 以묐났 �솗�씤
	public Member selectMemberEmailCk(String memberEmail) throws Exception {
		Member member = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select id from (select member_email id from member union select admin_id id from admin) t where id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			//�엯�젰�븳 �씠硫붿씪�� �씠誘� 媛��엯以묒씠�씪 �궗�슜�븷�닔 �뾾�쓬.
			member = new Member();
			member.setMemberEmail(rs.getString("id"));
		}
		conn.close();
		
		return member;
	}
	// �쉶�썝�젙蹂�
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
