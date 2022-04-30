package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
	// 생성자 생성
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "12qwaszx";
			Class.forName("com.mysql.jdbc.Driver"); // mysql에 접속할 수 있게 해주는 매개체 역할을 해준다
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// conn 객체 안에 접속된 정보가 담긴다
		} catch(Exception e) {
			e.printStackTrace();
		}
	} 
	// 이 부분까지 mysql에 접속하게 해주는 단계 
	
//	게시판 글쓰기를 위해서는 총 3개의 함수가 필요하다!!
	
	// 1. 현재의 시간을 가져오는 함수로서 게시판을 작성할때 게시판에 현재의 시간을 넣어주는 역할을 한다!
	public String getDate() {
		String SQL = "SELECT NOW()";	//현재의 시간을 가져오게 하는 MYSQL의 함수
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류, 데이터가 잘못 들어갈 일이 거의 없다!	
	}
	
	// 2. 게시글 마지막 번호를 가져와서 +1 을 해주는 함
		public int getNext() {
			String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1; //첫 번째 게시물인 경우!
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
		
	// 3. 글을 작성하는 함수!! 데이터베이스에 하나에 게시글을 작성해서 넣어준다!
		public int write(String bbsTitle, String userID, String bbsContent) {
			String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";	
			try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setString(2, bbsTitle);
					pstmt.setString(3, userID);
					pstmt.setString(4, getDate());
					pstmt.setString(5, bbsContent);
					pstmt.setInt(6, 1);

					return pstmt.executeUpdate(); // INSERT 문의 경우는 executeUpdate 문으로 작동한다
				} catch(Exception e) {
					e.printStackTrace();
				}
				return -1; // 데이터베이스 오류
		}
		
		// 특정한 리스트를 받아서 발현하는 기능
		public ArrayList<Bbs> getList(int pageNumber){
		// 특정한 페이지에 따른 총 10개의 게시글을 가져오게 해줌
			String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //10개만큼 게시글을 가져온다
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  getNext() - (pageNumber -1) * 10); // getNext()는 그 다음에 작성될 글의 번호를 의미
				rs = pstmt.executeQuery();
				while (rs.next()) {
					
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
					// 해당 인스턴스를 받아서 반환
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			return list; // 받아온 리스트를 출력
		}
		
		// 10단위로 페이지를 표현해주기 때문에 10단위로 끊기는 경우 nextPage가 없다는걸 알려주는 함수!!
		// 페이징 처리를 위해 존재하는 함수
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber -1) * 10); // getNext()는 그 다음에 작성될 글의 번호를 의미
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return true;
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			return false; // 받아온 리스트를 출력
		}
		
	// 하나의 글을 불러오는 함수
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs= pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?"; // bbsID를 가진 제목과 내용을 바꿔준다
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsID);
	
				return pstmt.executeUpdate(); // UPDATE 문의 경우는 executeUpdate 문으로 작동한다
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; // bbsID를 가진 제목과 내용을 바꿔준다, 
		//글을 삭제하더라 글에대한 정보가 남아 있을수 있도록 bbsAvailable을 0으로해준다
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				return pstmt.executeUpdate(); // UPDATE 문의 경우는 executeUpdate 문으로 작동한다
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
	}
}
