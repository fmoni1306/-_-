package menu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class menuDAO {
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection con = null;

	public Connection con() throws Exception {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb5";
		String user = "root";
		String password = "1234";

		Class.forName(driver);
		con = DriverManager.getConnection(url, user, password);
		
//		Context init = new InitialContext();
//		DataSource ds=(DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
//		con = ds.getConnection();

		return con;
	}

	public int menuUpload(menuDTO dto) {
		int num = 0;
		int count = 0;
		try {
			con = con();
			String sql = "select max(num) from menuupload";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			sql = "INSERT INTO menuupload VALUES(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getFileName1());
			pstmt.setString(3, dto.getFileName2());
			count = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return count;
	}

	public menuDTO getMenu() {
		int num = 0;
		menuDTO dto = new menuDTO();
		try {
			con = con();
			String sql = "SELECT max(num) from menuupload";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)");
			}
			sql = "SELECT * from menuupload where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				dto.setFileName1(rs.getString("file1"));
				dto.setFileName2(rs.getString("file2"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return dto;
	}
}
