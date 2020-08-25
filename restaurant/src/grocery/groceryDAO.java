package grocery;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import resBoard.boardDTO;

public class groceryDAO {

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
//		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
//		con = ds.getConnection();
		return con;
	}

	public int insertGrocery(groceryDTO dto) {
		int count = 0;
		int num = 1;
		try {
			con = con();
			String sql = "select max(num) from grocery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			sql = "INSERT INTO grocery values(?,0,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getPrice());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFileName());
			pstmt.setString(6, dto.getSmName());
			pstmt.setString(7, dto.getPath());
			pstmt.setTimestamp(8, dto.getDate());
			count = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return count;
	}

	public List<groceryDTO> getGlist(int startRow, int pazeSize, int order) {
		List<groceryDTO> list = new ArrayList<groceryDTO>();
		int num = 0;
		try {
			con = con();
			String sql = "SELECT count(num) from grocery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (order == 0) {
					num = rs.getInt("count(num)");
					sql = "SELECT * from grocery ORDER BY num DESC limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow - 1);
					pstmt.setInt(2, pazeSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						groceryDTO dto = new groceryDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setName(rs.getString("name"));
						dto.setPrice(rs.getInt("price"));
						dto.setContent(rs.getString("content"));
						dto.setFileName(rs.getString("filename"));
						dto.setSmName(rs.getString("smname"));
						dto.setDate(rs.getTimestamp("date"));
						list.add(dto);
					}
				}
				if (order == 1) {
					num = rs.getInt("count(num)");
					sql = "SELECT * from grocery ORDER BY price ASC limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow - 1);
					pstmt.setInt(2, pazeSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						groceryDTO dto = new groceryDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setName(rs.getString("name"));
						dto.setPrice(rs.getInt("price"));
						dto.setContent(rs.getString("content"));
						dto.setFileName(rs.getString("filename"));
						dto.setSmName(rs.getString("smname"));
						dto.setDate(rs.getTimestamp("date"));
						list.add(dto);
					}
				}
				if (order == 2) {
					num = rs.getInt("count(num)");
					sql = "SELECT * from grocery ORDER BY price DESC limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow - 1);
					pstmt.setInt(2, pazeSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						groceryDTO dto = new groceryDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setName(rs.getString("name"));
						dto.setPrice(rs.getInt("price"));
						dto.setContent(rs.getString("content"));
						dto.setFileName(rs.getString("filename"));
						dto.setSmName(rs.getString("smname"));
						dto.setDate(rs.getTimestamp("date"));
						list.add(dto);
					}
				}
				if (order == 3) {
					num = rs.getInt("count(num)");
					sql = "SELECT * from grocery ORDER BY readcount DESC limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow - 1);
					pstmt.setInt(2, pazeSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						groceryDTO dto = new groceryDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setName(rs.getString("name"));
						dto.setPrice(rs.getInt("price"));
						dto.setContent(rs.getString("content"));
						dto.setFileName(rs.getString("filename"));
						dto.setSmName(rs.getString("smname"));
						dto.setDate(rs.getTimestamp("date"));
						list.add(dto);
					}
				}
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
		return list;
	}

	public List<groceryDTO> groList(groceryDTO dto) {
		List<groceryDTO> list = new ArrayList<groceryDTO>();
		try {
			con = con();

			String sql = "UPDATE grocery set readcount = readcount+1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			pstmt.executeUpdate();

			sql = "SELECT * from grocery where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setFileName(rs.getString("filename"));
				list.add(dto);
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
		return list;

	}

	public int cart(String fileName, String id, int num) {
		try {
			con = con();

			String sql = "SELECT * from cart where id = ? and filename =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, fileName);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 0;
			} else {
				sql = "INSERT INTO cart values(?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setString(3, fileName);
				int count = pstmt.executeUpdate();
				return count;
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
		return 0;
	}

	public List<groceryDTO> cartList(String id) {
		List<groceryDTO> list = new ArrayList<groceryDTO>();
		String file = "";
		try {
			con = con();
			String sql = "SELECT * from cart where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				file = file + rs.getString("filename") + "/";
			}
			String[] filename = file.split("/");
			sql = "SELECT * from grocery where filename = ?";
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < filename.length; i++) {
				pstmt.setString(1, filename[i]);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					groceryDTO dto = new groceryDTO();
					dto.setName(rs.getString("name"));
					dto.setPrice(rs.getInt("price"));
					dto.setNum(rs.getInt("num"));
					dto.setSmName(rs.getString("smname"));
					dto.setFileName(rs.getString("filename"));
					list.add(dto);
				}
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
		return list;
	}

	public int cartDelete(String filename, String id) {
		int count = 0;
		try {
			con = con();
			String sql = "DELETE FROM cart where id = ? and filename = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, filename);
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	public int order(String oList, String id) {
		int check = 0;
		try {
			con = con();
			String[] ol = oList.split("/");
			for (int i = 0; i < ol.length; i++) {
				int maxNum = 0;
				int num = Integer.parseInt(ol[i]);
				String sql = "select max(num) from orderlist";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					maxNum = rs.getInt("max(num)") + 1;
				}
				sql = "SELECT * from grocery where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					sql = "INSERT INTO orderlist(num,item,price) values(?,?,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, maxNum);
					pstmt.setString(2, rs.getString("name"));
					pstmt.setInt(3, rs.getInt("price"));
					pstmt.executeUpdate();
					sql = "SELECT * from restaurant where id = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						sql = "UPDATE orderlist set id =?,name=?,number=?,postcode=?,address=? where num = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, rs.getString("id"));
						pstmt.setString(2, rs.getString("name"));
						pstmt.setString(3, rs.getString("hnumber"));
						pstmt.setString(4, rs.getString("postcode"));
						pstmt.setString(5, rs.getString("adress"));
						pstmt.setInt(6, maxNum);
						check = pstmt.executeUpdate();
					}
				}

			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}

	public int groceryDelete(int num, String id, String pass) {
		int check = 0;
		try {
			con = con();
			String sql = "SELECT * FROM grocery where num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "SELECT * FROM restaurant where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("pass").equals(pass)) {
						sql = "SELECT * FROM grocery where num =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							File file = new File(rs.getString("path") + "\\" + rs.getString("filename"));
							if (file.exists()) {
								file.delete();
							}
							File file2 = new File(rs.getString("path") + "\\" + rs.getString("smname"));
							if (file2.exists()) {
								file2.delete();
							}
							File file3 = new File(
									"D:\\workspace_jsp\\restaurant\\WebContent\\image" + "\\" + rs.getString("filename"));
							if (file3.exists()) {
								file3.delete();
							}
							File file4 = new File("D:\\workspace_jsp\\restaurant\\WebContent\\image" + "\\"
									+ rs.getString("smname"));
							if (file4.exists()) {
								file4.delete();
							}

						}
						sql = "DELETE FROM grocery where num =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						check = pstmt.executeUpdate();
						

					} else {
						check = 0;
					}
				}
			} else {
				check = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {
				}
		}
		return check;
	}
}
