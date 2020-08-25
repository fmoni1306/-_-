<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="grocery.groceryDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

PreparedStatement pstmt = null;
ResultSet rs = null;
Connection con = null;

	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jspdb5";
	String user = "root";
	String password = "1234";

	Class.forName(driver);
	con = DriverManager.getConnection(url, user, password);
	
	String sql = "SELECT count(num) from grocery";
	pstmt = con.prepareStatement(sql);
	rs = pstmt.executeQuery();
	JSONArray arr = new JSONArray();
	if (rs.next()) {
			sql = "SELECT * from grocery ORDER BY num DESC limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setInt(2, 5);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				JSONObject cart = new JSONObject();
				cart.put("name", rs.getString("name"));
				cart.put("img", rs.getString("smname"));
				arr.add(cart);
		}
	}



%>

<%=arr%>