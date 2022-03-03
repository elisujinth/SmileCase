package com.spring.smileCase.oracleTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

public class OracleConnectTest {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String UID = "sujin";
	private static final String PWD = "sujin";
	
	@Test // test 사용을 위한 어노테이션
	public void connectTest() throws Exception {
		Class.forName(DRIVER);
		Connection conn = null;
		
		try {
			conn = DriverManager.getConnection(URL, UID, PWD);
			System.out.println("!!! DB 접속 성공 !!!");
			System.out.println("conn : " + conn);
		} catch(SQLException e) {
			System.out.println("DB 연결 실패");
		} catch(Exception e2){
			System.out.println("Exception : " + e2);
		}finally {
			if(conn != null) conn.close();
		}
	}
}
