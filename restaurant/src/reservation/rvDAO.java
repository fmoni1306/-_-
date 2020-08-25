package reservation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class rvDAO {
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

	public int reserveWrite(rvDTO dto) {
		int count = 0;
		try {
			con = con();
			String sql = "INSERT INTO reserve VALUES(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getNumber());
			pstmt.setInt(2, dto.getPerson());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getDate());
			pstmt.setString(5, dto.getCaution());
			count = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e2) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e2) {
				}
		}
		return count;
	}

	public List<rvDTO> getReserveList() {
		List<rvDTO> list = new ArrayList<rvDTO>();
		try {
			con =con();
			String sql = "SELECT * from reserve";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rvDTO dto = new rvDTO();
				dto.setName(rs.getString("name"));
				dto.setNumber(rs.getString("number"));
				dto.setPerson(rs.getInt("person"));
				dto.setDate(rs.getString("date"));
				dto.setCaution(rs.getString("caution"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
