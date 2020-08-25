package resMember;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.websocket.Session;

public class resDAO {
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

	public int duplicate(resDTO id) {

		int check = 0;
		try {
			con = con();
			String sql = "Select * from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id.getId());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				check = 0;
			} else {
				check = 1;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return check;

	}

	public int mailChecker(resDTO dto) {

		int check = 0;
		try {
			con = con();
			String sql = "Select * from restaurant where mail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getMail());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				check = 0;
			} else {
				check = 1;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return check;

	}

	public int insertRes(resDTO dto) {

		int num = 0;
		int count = 0;

		try {
			con = con();
			String sql = "Select * from restaurant where id = ? || mail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getMail());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = -1;
				return count;
			} else {
				sql = "Select max(num) from restaurant";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					num = rs.getInt("max(num)") + 1;
				}
				sql = "INSERT INTO RESTAURANT value(?,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dto.getName());
				pstmt.setString(3, dto.getBirth());
				pstmt.setString(4, dto.getId());
				pstmt.setString(5, dto.getPass());
				pstmt.setString(6, dto.getMail());
				pstmt.setString(7, dto.getHnumber());
				pstmt.setString(8, dto.getPostcode());
				pstmt.setString(9, dto.getAddress());
				pstmt.setTimestamp(10, dto.getReg_date());

				count = pstmt.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return count;
	}

	public int passcheck(resDTO dto) {

		String UpperReg = "[A-Z]";
		String LowerReg = "[a-z]";
		String numReg = "[0-9]";
		String charReg = "[!@#$%]";

		String lengthReg = "^[A-Za-z0-9!@#$%]{8,15}$";
		String koReg = "[가-힣]";

		String password = dto.getPass();
		int count = 0;
		if (Pattern.matches(lengthReg, password)) {

			if (Pattern.compile(koReg).matcher(password).find()) {
				count = -1;
			} else {
				count += Pattern.compile(UpperReg).matcher(password).find() ? 1 : 0;
				count += Pattern.compile(LowerReg).matcher(password).find() ? 1 : 0;
				count += Pattern.compile(numReg).matcher(password).find() ? 1 : 0;
				count += Pattern.compile(charReg).matcher(password).find() ? 1 : 0;
			}
			switch (count) {
			case 1:
				return count;
			case 2:
				return count;
			case 3:
				return count;
			case 4:
				return count;
			default:
				break;
			}
		} else {
			count = 0;
		}
		return count;
	}

	public int login(resDTO dto) {

		int check = 0;
		try {
			con = con();
			String sql = "Select * from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (dto.getPass().equals(rs.getString("pass"))) {
					check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return check;

	}

	public resDTO updateCheck(String id) {

		resDTO dto = null;
		try {
			con = con();
			String sql = "SELECT * from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new resDTO();
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setMail(rs.getString("mail"));
				dto.setHnumber(rs.getString("hnumber"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;
	}

	public int updateRes(resDTO dto) {
		int count = 0;

		try {
			con = con();
			String sql = "SELECT * FROM restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();

			if (rs.next()) { // 아이디가 있을때 작동함
				sql = "SELECT * FROM restaurant where pass = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getPass());
				rs = pstmt.executeQuery();
				if (rs.next()) { // 아이디가 있고 비밀번호도 있을때 작동
					sql = "UPDATE restaurant set pass = ? where pass = ? and hnumber= ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getPass2());
					pstmt.setString(2, dto.getPass());
					pstmt.setString(3, dto.getHnumber());
					if (dto.getPass().equals(dto.getPass2())) { // 기존패스워드와 새로운패스워드가 같을때 작동
						count = -1; // 동일한 비밀번호 사용 불가
					} else { // 아이디 and 비밀번호 있고 패스워드가 서로 다를때
						count = pstmt.executeUpdate();
					}

				} else {
					count = -2; // 아이디는 맞지만 비밀번호가 틀릴때
				}

			} else { // 아이디가 없을때
				count = 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	public resDTO myPage(String id) {
		resDTO dto = new resDTO();
		
		try {
			con = con();
			String sql = "SELECT * from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs  = pstmt.executeQuery();
			if(rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setBirth(rs.getString("birthday"));
				dto.setMail(rs.getString("mail"));
				dto.setHnumber(rs.getString("hnumber"));
				dto.setPostcode(rs.getString("postcode"));
				dto.setAddress(rs.getString("adress"));
				dto.setReg_date(rs.getTimestamp("reg"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(con!=null) try {con.close();} catch (Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	public boolean memDelete(String id, String pass) {
		boolean result = false;
		try {
			con =con();
			String sql = "SELECT pass from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					sql = "DELETE FROM restaurant where id = ? and pass =?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pass);
					int count = pstmt.executeUpdate();
					if(count > 0) {
						result = true;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(con!=null) try {con.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	
} // 클래스 끝

