package imgbbs;

import java.sql.*;
import java.util.*;

import utility.*;

public class ImgbbsDAO {
	public List imgRead(int no){
		List list = new ArrayList();
		Connection con = DBOpen.open();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(no,2)     over (order by no) pre_no2,    ");
		sql.append("          lag(no,1)     over (order by no ) pre_no1,   ");
		sql.append("          no,  ");
		sql.append("          lead(no,1)    over (order by no) nex_no1,    ");
		sql.append("          lead(no,2)    over (order by no) nex_no2,    ");
		sql.append("          lag(filename,2)  over (order by no) pre_file2,     ");
		sql.append("          lag(filename,1)  over (order by no ) pre_file1,  ");
		sql.append("          filename,   ");
		sql.append("          lead(filename,1) over (order by no) nex_file1,  ");
		sql.append("          lead(filename,2) over (order by no) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT no, filename   ");
		sql.append("               FROM imgbbs ");
		sql.append("               ORDER BY no DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE no = ? ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int[] noArr = 
					   {
						rs.getInt("pre_no2"),
						rs.getInt("pre_no1"),
						rs.getInt("no"),
						rs.getInt("nex_no1"),
						rs.getInt("nex_no2")
					    };
				String[] files = 
					    {
						rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("filename"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2")
						};
				
				list.add(files);
				list.add(noArr);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(con, pstmt, rs);
		}
				
		return list;
	}
	
	/**
	 * 부모글인지 확인
	 * 부모글이면 삭제 못함
	 * @param no 삭제하려고 하는 글번호
	 * @return true부모글번호, false 부모글 번호 아님.
	 */
	public boolean checkRefno(int no) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(refno) from Imgbbs ");
		sql.append(" where refno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt > 0) flag = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}
	public int total(String col, String word) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) ");
		sql.append(" from Imgbbs ");
		if(word.trim().length() > 0)
		sql.append(" where " + col + " like '%' ||?|| '%' ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length() > 0)
				pstmt.setString(1, word);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return total;
	}
	public boolean createReply(ImgbbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO Imgbbs(no, name, title, ");
		sql.append(" content, passwd, wdate, grpno, indent, ansnum, refno, filename, filesize) VALUES((SELECT NVL(MAX(no), 0) + 1 ");
		sql.append(" as no FROM Imgbbs), ?, ?, ?, ?, sysdate,  "); 
		sql.append(" ?, ?, ?, ?, ?, ?) "); 
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno()); // 부모의 grpno
			pstmt.setInt(6, dto.getIndent() + 1); // 부모의 indent + 1
			pstmt.setInt(7, dto.getAnsnum() + 1);	// 부모의 ansnum + 1
			pstmt.setInt(8, dto.getNo());		// 부모의 글번호 등록
			pstmt.setString(9, dto.getFilename());
			pstmt.setInt(10, dto.getFilesize());
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	
	}
	
	public void upAnsnum(Map map) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		sql.append(" update Imgbbs ");
		sql.append(" set ansnum = ansnum + 1 ");
		sql.append(" where grpno = ? and ansnum > ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
	}
	
	public ImgbbsDTO readReply(int no) {
		ImgbbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, title, grpno, indent, ansnum " );
		sql.append(" FROM Imgbbs ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ImgbbsDTO();
				dto.setNo(rs.getInt("no"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return dto;		
	}
	
	public boolean delete(int no) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from Imgbbs ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	public boolean update(ImgbbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE Imgbbs  ");
		sql.append(" SET name = ?,  ");
		sql.append(" title=?, ");
		sql.append(" content=? ");
		if(dto.getFilesize() > 0) {
			sql.append(" ,filename = ?, ");
			sql.append(" filesize = ? ");
		}
		sql.append(" WHERE no = ? ");
		
		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(++i, dto.getName());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			if(dto.getFilesize() > 0) {
				pstmt.setString(++i, dto.getFilename());
				pstmt.setInt(++i, dto.getFilesize());
			}
			pstmt.setInt(++i, dto.getNo());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public boolean passCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int no = (Integer)map.get("no");
		String passwd = (String)map.get("passwd");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(no) as cnt ");
		sql.append(" FROM Imgbbs ");
		sql.append(" WHERE no=? AND passwd=? ");
  		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			rs.next();
			int cnt = rs.getInt("cnt");
			
			if(cnt > 0) flag = true;			// 올바른 패스워드
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}
	
	public ImgbbsDTO read(int no) {
		ImgbbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, name, title, content,  viewcnt, wdate, filename" );
		sql.append(" FROM Imgbbs ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ImgbbsDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setFilename(rs.getString("filename"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	public void upViewcnt(int no) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update Imgbbs ");
		sql.append(" set viewcnt = viewcnt + 1 ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
	}
	
	public List<ImgbbsDTO> list(Map map) {
		List<ImgbbsDTO> list = new ArrayList<ImgbbsDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, name, title, viewcnt, ");
		sql.append(" wdate, indent, filename,  r ");
		sql.append(" from ( ");
		sql.append(" 	SELECT no, name, title, viewcnt,  ");
		sql.append(" 	wdate, indent, filename, rownum r ");
		sql.append(" 	from ( ");
		sql.append(" 		SELECT no, name, title, viewcnt, wdate " );
		sql.append(" 		, indent, filename " );
		sql.append(" 		FROM Imgbbs ");
		if(word.trim().length()>0)
		sql.append(" 		where "+col+" like '%' || ? || '%' ");
		sql.append(" 		ORDER BY grpno DESC, ansnum ASC ");
		sql.append(" 	) ");
		sql.append(" ) where r>=? and r<=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if(word.trim().length()>0)
			pstmt.setString(++i, word);
			
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ImgbbsDTO dto = new ImgbbsDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setIndent(rs.getInt("indent"));
				dto.setFilename(rs.getString("filename"));
				
				list.add(dto);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public boolean create(ImgbbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO Imgbbs(no, name, title, ");
		sql.append(" content, passwd, wdate, grpno, filename) VALUES((SELECT NVL(MAX(no), 0) + 1 ");
		sql.append(" as no FROM Imgbbs), ?, ?, ?, ?, sysdate,  "); 
		sql.append(" (SELECT NVL(MAX(grpno), 0) + 1 FROM Imgbbs), "); 
		sql.append(" ?) "); 
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFilename());
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
}