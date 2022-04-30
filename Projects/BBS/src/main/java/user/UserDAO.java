package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
// CMD shift O 를 눌러서 외부라이브러리 추가해주기!!

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 생성
	public UserDAO() {
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
	
	
	// 로그인 기능에 대한 구현
	public int login(String userID, String userPassword) {
		// SQL에 넣을 명령어 적어주기
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; // ? 안에는 입력받은 userID가 들어간다
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			// ?에 각각의 해당 변수들을 채워넣어준다!!
			return pstmt.executeUpdate();
			//INSERT 문장을 실행한 경우는 반드시 0이상의 숫자가 발현된다!!
			// 따라서 -1 의 값이 나오지 않으면 성공적으로 값이 들어간 것!!
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	
	
	
}
