package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import commons.DBUtil;
import vo.*;



public class ProductDao {
	
		public Product selectProductOne(int productId) throws Exception {
		Product product = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select product_id,  product_name, product_price, product_content, product_soldout, product_pic from product where product_id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,productId);		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			product = new Product();
			product.setProductId(rs.getInt("product_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setProductContent(rs.getString("product_content"));
			product.setProductSoldout(rs.getString("product_soldout"));
			product.setProductPic(rs.getString("product_pic"));
		}
		return product;
	}
	public ArrayList<Product> selectProductList() throws Exception{
		ArrayList<Product> list = new ArrayList<Product>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select product_id,  product_name, product_price, product_content, product_pic from product limit 0,6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();
			product.setProductId(rs.getInt("product_id"));// = rs.getInt("product_id");
			product.setProductName(rs.getString("product_name"));// = rs.getString("product_name");
			product.setProductPrice(rs.getInt("product_price"));// = rs.getInt("product_price");
			product.setProductContent(rs.getString("product_content"));// = rs.getString("product_content");
			product.setProductPic(rs.getNString("product_pic"));
			list.add(product);
		}
		conn.close();
		return list;
	}
	

}
