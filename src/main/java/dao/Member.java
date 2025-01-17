package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connection.ConnectionManager;

public class Member {
	private static Connection con = null;
	private static ResultSet rs = null; 
	private static PreparedStatement ps = null;
	private static String sql = null;
	
	//get members by projectID
	public static User getUserById(int id) {
		User user = new User();
		try {
			con = ConnectionManager.getConnection();
			
		}
		catch (Exception e) {
			
		}
		return 
	}
}
