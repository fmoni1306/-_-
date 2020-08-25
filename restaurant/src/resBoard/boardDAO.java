package resBoard;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.search.SearchException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class boardDAO {
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

		return con;

		// 커넥션 풀(Connection Pool)
		// 데이터베이스와 연결된 Connection 객체를 미리 생성하여 풀(Pool)
		// 속에 저장해두고 필요할때마다 Connection 객체를 사용
		// Connection재사용, 프로그램 효율, 성능 증가

		// 아파치톰캣에 내장된 프로그램 DBCP(DataBase Connection Pool) API 사용
		// 1. WebContent\META_INF 폴더 context.xml
		// 1단계 디비연결 드라이버, 2단계 DB연결
		// 2. context.xml 만든 자원의 이름을 가져와서 사용

		// javax.naming import
//		Context init = new InitialContext();
//		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
//		con = ds.getConnection();
//		return con;

	}

	public int boardInsert(boardDTO dto) {

		int check = 0;
		int num = 0;
		try {

			con = con();
			String sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			sql = "SELECT * from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sql = "INSERT INTO board values(?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dto.getId());
				pstmt.setString(3, dto.getSubject());
				pstmt.setString(4, dto.getContent());
				pstmt.setInt(5, 0);
				pstmt.setTimestamp(6, dto.getTime());
				// 답글 관련 추가
				pstmt.setInt(7,num);
				pstmt.setInt(8, 0);
				pstmt.setInt(9, 0);
				
				check = pstmt.executeUpdate();

			} else {
				check = 0;
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

	public int reBoardInsert(boardDTO dto) {
		int check = 0;
		int num = 0;
		try {
			con = con();
			String sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			
			// 같은 그룹이면서 내밑에 답글이 있는 경우 
			// re_ref 같고 re_seq 보다 큰값 => 순서값을 re_seq 순서값을 1증가 
			sql = "UPDATE board set re_seq=re_seq+1 where re_ref = ? and re_seq >? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getRe_ref());
			pstmt.setInt(2, dto.getRe_seq());
			pstmt.executeUpdate();
			
			sql = "SELECT * from restaurant where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "INSERT INTO board values(?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dto.getId());
				pstmt.setString(3, dto.getSubject());
				pstmt.setString(4, dto.getContent());
				pstmt.setInt(5, 0);
				pstmt.setTimestamp(6, dto.getTime());
				// 답글 관련 추가
				pstmt.setInt(7,dto.getRe_ref());
				pstmt.setInt(8, dto.getRe_lev()+1);
				pstmt.setInt(9, dto.getRe_seq()+1);
				
				check = pstmt.executeUpdate();

			} else {
				check = 0;
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
	public List<boardDTO> boardList(int startRow, int pazeSize) {
		List<boardDTO> list = new ArrayList<boardDTO>();
		int num = 0;
		try {
			con = con();
			String sql = "SELECT count(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("count(num)");
//				sql = "SELECT * from board ORDER BY num DESC limit ?,?";
				
				// 답글 re_ref 그룹 내림차순 re_seq 답글 오름차순
				
				sql = "SELECT * from board ORDER By re_ref DESC, re_seq ASC limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow - 1);
				pstmt.setInt(2, pazeSize);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					boardDTO dto = new boardDTO();
					dto.setMaxNum(num);
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setTime(rs.getTimestamp("time"));
					dto.setRe_ref(rs.getInt("re_ref"));
					dto.setRe_lev(rs.getInt("re_lev"));
					dto.setRe_seq(rs.getInt("re_seq"));

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

	public List<boardDTO> boardContent(boardDTO dto) {
		List<boardDTO> list = new ArrayList<boardDTO>();
		try {
			con = con();
//			String sql = "SELECT * FROM board where id= ?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, dto.getId());
//			rs = pstmt.executeQuery();
//			if (!rs.next()) {
			String sql = "UPDATE board set readcount = readcount+1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			pstmt.executeUpdate();
//			}

			sql = "SELECT * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setTime(rs.getTimestamp("time"));
				dto.setReadcount(rs.getInt("readcount"));
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

	public int maxNum(int num) {
		int last = 0;
		try {
			con = con();
			String sql = "Select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				last = 1;
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
		return last;
	}

	public int imageNum(int num) {
		int last = 0;
		try {
			con = con();
			String sql = "Select * from imageboard where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				last = 1;
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
		return last;
	}

	public int boardComment(boardDTO dto, String secret) {
		int count = 0;
		int comNum = 0;
		try {
			con = con();
			String sql = "select max(comnum) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				comNum = rs.getInt("max(comnum)") + 1;
			}
			sql = "SELECT * from restaurant where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setPass(rs.getString("pass"));
				if (!dto.getId().equals("fmoni")) {
					sql = "SELECT COUNT(*) FROM comment where num =? and id =? GROUP BY id,num HAVING COUNT(*)>2";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, dto.getNum());
					pstmt.setString(2, dto.getId());
					rs = pstmt.executeQuery();
					if (rs.next()) {
						count = -1;
						return count;
					}
				}
				sql = "INSERT INTO COMMENT values(?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dto.getNum());
				pstmt.setInt(2, comNum);
				pstmt.setString(3, dto.getId());
				pstmt.setString(4, dto.getPass());
				pstmt.setTimestamp(5, dto.getTime());
				pstmt.setString(6, dto.getComment());
				pstmt.setString(7, secret);
				count = pstmt.executeUpdate();

			} else {
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

	public List<boardDTO> commentList(int num) {
		List<boardDTO> list = new ArrayList<boardDTO>();

		try {
			con = con();
			String sql = "Select * from comment where num =? ORDER BY time ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardDTO dto = new boardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setComNum(rs.getInt("comNum"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setTime(rs.getTimestamp("Time"));
				dto.setComment(rs.getString("comment"));
				dto.setSecret(rs.getString("secret"));
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

	public int commentDelete(boardDTO dto) {
		int count = 0;
		String sql = null;

		try {
			con = con();
			if (dto.getComNum() != 0) {
				sql = "SELECT * from cofc where comment =? and comnum =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getComment());
				pstmt.setInt(2, dto.getComNum());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("id").equals(dto.getId())) {
						if (rs.getString("pass").equals(dto.getPass())) {
							sql = "DELETE from cofc where id = ? and pass = ? and comment =?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, dto.getId());
							pstmt.setString(2, dto.getPass());
							pstmt.setString(3, dto.getComment());
							count = pstmt.executeUpdate();
							return count;
						} else {
							count = -1;
						}
					} else {
					count = 0;
					}
				}
			} else {

				sql = "SELECT * from comment where comment = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getComment());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("id").equals(dto.getId())) {
						if (rs.getString("pass").equals(dto.getPass())) {
							
							sql = "DELETE from cofc where num =?";
							pstmt = con.prepareStatement(sql);
							pstmt.setInt(1, rs.getInt("comnum"));
							pstmt.executeUpdate();

							sql = "DELETE from comment where id =? and pass =? and comment =?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, dto.getId());
							pstmt.setString(2, dto.getPass());
							pstmt.setString(3, dto.getComment());
							count = pstmt.executeUpdate();
							return count;
						} else {
							count = -1;
						}
					} else {
					count = 0;
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
		return count;
	}

	public int imageBoard(boardDTO dto) {
		int num = 0;
		int count = 0;
		try {
			con = con();
			String sql = "select max(num) from imageboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			sql = "SELECT * from restaurant where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "INSERT INTO imageboard VALUES(?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dto.getId());
				pstmt.setString(3, dto.getSubject());
				pstmt.setString(4, dto.getContent());
				pstmt.setInt(5, 0);
				pstmt.setTimestamp(6, dto.getTime());
				pstmt.setString(7, dto.getImage());
				pstmt.setString(8, dto.getPath());
				pstmt.setString(9, dto.getSm_image());
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

	public List<boardDTO> imageBoardList(int startRow, int pageSize) {
		List<boardDTO> list = new ArrayList<boardDTO>();
		int num = 0;
		String sql;
		try {
			con = con();
			sql = "SELECT count(num) from imageboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("count(num)");
				sql = "SELECT * from imageboard ORDER BY num DESC limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow - 1);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					boardDTO dto = new boardDTO();
					dto.setMaxNum(num);
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setTime(rs.getTimestamp("time"));
					dto.setImage(rs.getString("image"));

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

	public List<boardDTO> imageContent(boardDTO dto) {
		List<boardDTO> list = new ArrayList<boardDTO>();
		try {
			con = con();
			String sql = "SELECT * FROM imageboard where id= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (!rs.next()) {
				sql = "UPDATE imageboard set readcount = readcount+1 where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dto.getNum());
				pstmt.executeUpdate();
			}

			sql = "SELECT * from imageboard where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setTime(rs.getTimestamp("time"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setImage(rs.getString("image"));
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

	public int imageComment(boardDTO dto) {
		int count = 0;
		try {
			con = con();
			String sql = "SELECT * from restaurant where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setPass(rs.getString("pass"));
				sql = "SELECT COUNT(*) FROM imagecomment where num =? and id =? GROUP BY id,num HAVING COUNT(*)>2";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dto.getNum());
				pstmt.setString(2, dto.getId());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = -1;
				} else {
					sql = "INSERT INTO imagecomment values(?,?,?,?,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, dto.getNum());
					pstmt.setString(2, dto.getId());
					pstmt.setString(3, dto.getPass());
					pstmt.setTimestamp(4, dto.getTime());
					pstmt.setString(5, dto.getComment());
					count = pstmt.executeUpdate();
				}
			} else {
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

	public List<boardDTO> imageCommentList(int num) {
		List<boardDTO> list = new ArrayList<boardDTO>();

		try {
			con = con();
			String sql = "Select * from imagecomment where num =? ORDER BY time desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardDTO dto = new boardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setTime(rs.getTimestamp("Time"));
				dto.setComment(rs.getString("comment"));
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

	public int imageCommentDelete(boardDTO dto) {
		int count = 0;

		try {
			con = con();
			String sql = "SELECT * from imagecomment where comment = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getComment());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString("id").equals(dto.getId())) {
					if (rs.getString("pass").equals(dto.getPass())) {
						sql = "DELETE from imagecomment where id =? and pass =? and comment =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, dto.getId());
						pstmt.setString(2, dto.getPass());
						pstmt.setString(3, dto.getComment());
						count = pstmt.executeUpdate();
						return count;
					} else {
						count = -1;
					}
				}
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

	public List<boardDTO> searchBoard(String content, int opt, int pageSize) throws SearchFail {
		List<boardDTO> list = new ArrayList<boardDTO>();
		int num = 0;
		try {
			con = con();
			String sql;
			if (opt == 1) {
				sql = "SELECT count(num) FROM board WHERE subject LIKE ? order by num desc limit 0,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + content + "%");
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					num = rs.getInt("count(num)");
					sql = "SELECT * FROM board WHERE subject LIKE ? order by num desc limit 0,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + content + "%");
					pstmt.setInt(2, pageSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						boardDTO dto = new boardDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setId(rs.getString("id"));
						dto.setSubject(rs.getString("subject"));
						dto.setContent(rs.getString("content"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setTime(rs.getTimestamp("time"));
						list.add(dto);
					}
				}
			}
			if (opt == 2) {
				sql = "SELECT count(num) FROM board WHERE content LIKE ? order by num desc limit 0,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + content + "%");
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					num = rs.getInt("count(num)");
					sql = "SELECT * FROM board WHERE content LIKE ? order by num desc limit 0,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + content + "%");
					pstmt.setInt(2, pageSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						boardDTO dto = new boardDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setId(rs.getString("id"));
						dto.setSubject(rs.getString("subject"));
						dto.setContent(rs.getString("content"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setTime(rs.getTimestamp("time"));
						list.add(dto);
					}
				}
			}
			if (opt == 3) {
				sql = "SELECT count(num) FROM board WHERE content LIKE ? order by num desc limit 0,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + content + "%");
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					num = rs.getInt("count(num)");
					sql = "SELECT * FROM board WHERE subject LIKE ? || content LIKE ? order by num desc limit 0,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + content + "%");
					pstmt.setString(2, "%" + content + "%");
					pstmt.setInt(3, pageSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						boardDTO dto = new boardDTO();

						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setId(rs.getString("id"));
						dto.setSubject(rs.getString("subject"));
						dto.setContent(rs.getString("content"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setTime(rs.getTimestamp("time"));
						list.add(dto);
					}

				}
			}
			if (opt == 4) {
				sql = "SELECT count(num) FROM board WHERE id LIKE ? order by num desc limit 0,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + content + "%");
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					num = rs.getInt("count(num)");
					sql = "SELECT * FROM board WHERE id LIKE ? order by num desc limit 0,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + content + "%");
					pstmt.setInt(2, pageSize);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						boardDTO dto = new boardDTO();
						dto.setMaxNum(num);
						dto.setNum(rs.getInt("num"));
						dto.setId(rs.getString("id"));
						dto.setSubject(rs.getString("subject"));
						dto.setContent(rs.getString("content"));
						dto.setReadcount(rs.getInt("readcount"));
						dto.setTime(rs.getTimestamp("time"));
						list.add(dto);
					}
				}
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
		return list;
	}

	public int contentDelete(boardDTO dto) {
		int check = 0;
		try {
			con = con();
			String sql = "SELECT * FROM board where id = ? and num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "SELECT * FROM restaurant where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getId());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("pass").equals(dto.getPass())) {
						
						
						sql = "DELETE FROM comment where num = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, dto.getNum());
						pstmt.executeUpdate();
						sql = "DELETE FROM board where id =? and num =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, dto.getId());
						pstmt.setInt(2, dto.getNum());
						pstmt.executeUpdate();
						check = 1;
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

	public int imageContentDelete(boardDTO dto) {
		int check = 0;
		try {
			con = con();
			String sql = "SELECT * FROM imageboard where id = ? and num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {

				sql = "SELECT * FROM restaurant where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getId());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("pass").equals(dto.getPass())) {

						sql = "SELECT * FROM imageboard where id = ? and num =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, dto.getId());
						pstmt.setInt(2, dto.getNum());
						rs = pstmt.executeQuery();
						if (rs.next()) {
							File file = new File(rs.getString("path") + "\\" + rs.getString("image"));
							if (file.exists()) {
								System.out.println(file);
								file.delete();
							}
							File file2 = new File(rs.getString("path") + "\\" + rs.getString("smimage"));
							if (file2.exists()) {
								System.out.println(file2);
								file2.delete();
							}
							File file3 = new File(
									"D:\\workspace_jsp\\restaurant\\WebContent\\image" + "\\" + rs.getString("image"));
							if (file3.exists()) {
								System.out.println(file3);
								file3.delete();
							}
							File file4 = new File("D:\\workspace_jsp\\restaurant\\WebContent\\image" + "\\"
									+ rs.getString("smimage"));
							if (file4.exists()) {
								System.out.println(file4);
								file4.delete();
							}

						}
						sql = "DELETE FROM imageboard where id =? and num =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, dto.getId());
						pstmt.setInt(2, dto.getNum());
						pstmt.executeUpdate();
						sql = "DELETE FROM imagecomment where num = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, dto.getNum());
						pstmt.executeUpdate();
						check = 1;

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

	public int cofcInsert(boardDTO dto, int page) {
		int count = 0;
		int num = 0;
		try {
			con = con();
			String sql = "select max(comnum) from cofc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(comnum)") + 1;
			}
			sql = "SELECT * from restaurant where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setPass(rs.getString("pass"));
				sql = "INSERT INTO cofc values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dto.getNum());
				pstmt.setInt(2, page);
				pstmt.setInt(3, num);// 기준값
				pstmt.setString(4, dto.getId());
				pstmt.setString(5, dto.getPass());
				pstmt.setTimestamp(6, dto.getTime());
				pstmt.setString(7, dto.getComment());
				pstmt.setString(8, "p");
				count = pstmt.executeUpdate();
			} else {
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

	public List<boardDTO> cofcList(int comnum, int num) {
		List<boardDTO> list = new ArrayList<boardDTO>();
		try {
			con = con();
			String sql = "SELECT cofc.* FROM cofc INNER JOIN comment ON (cofc.num = comment.comnum) where comment.comnum = ? and comment.num =? ORDER BY time asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comnum);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardDTO dto = new boardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setComNum(rs.getInt("comNum"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setTime(rs.getTimestamp("Time"));
				dto.setComment(rs.getString("comment"));
				dto.setSecret(rs.getString("secret"));
				list.add(dto);
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
		return list;
	}
}// 클래스끝

class SearchFail extends Exception {

	public SearchFail(String message) {
		super(message);
	}
}
