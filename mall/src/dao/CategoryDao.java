package dao;
import java.util.*;

import commons.DBUtil;
import commons.ListPage;
import vo.*;
import java.sql.*;

public class CategoryDao {

	// 카테고리 목록 출력
	public ArrayList<Category> selectCategoryList(ListPage listPage) throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select category_id, category_name from category LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, listPage.getQueryIndex());
		stmt.setInt(2, listPage.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id")); //categoryId = rs.getInt("category_id");
			category.setCategoryName(rs.getString("category_name")); //categoryName = rs.getString("category_name");
			list.add(category);
		}
		conn.close();
		return list;
	}
	//추천 카테고리 목록
	public ArrayList<Category> selectCategoryCkList() throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select category_id, category_name, category_pic from category where category_ck ='Y' limit 10,4";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id")); //categoryId = rs.getInt("category_id");
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic")); //categoryPic = rs.getString("category_pic");
			list.add(category);
		}
		conn.close();
		return list;
	}
}
