package dao;

import java.security.*;
import java.sql.*;
import java.util.*;

import connection.ConnectionManager;
import model.User;

public class UserDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static String sql=null;
	private static String INSERT_USERS_SQL = "INSERT INTO user(userName,email,password,typeID)VALUES(?,?,?)";
	private static final String SELECT_USER_BY_ID = "SELECT * FROM user WHERE userID = ?";
	private static final String SELECT_ALL_USERS = "SELECT * FROM user";
	private static final String SELECT_ALL_USERS_BY_PID = "SELECT * "
														+ "FROM project_member pm "
														+ "INNER JOIN user u ON pm.userID = u.userID "
														+ "INNER JOIN project p ON pm.projectID = p.projectID "
														+ "WHERE pm.projectID = ?;";
	private static final String DELETE_USERS_SQL = "DELETE FROM user WHERE userID = ?;";
	private static final String UPDATE_USERS_SQL = "UPDATE user SET email= ? WHERE userID = ?;";
	private static final String SELECT_USER_LOGIN = "SELECT * FROM user WHERE email = ? AND password = ?";
	
	private static User user = null;
	private static int userID;
	private static String userName, email, password;
	private static int typeID;
	private static int isLoggedIn;
	
	//insert user
		public static void insertUser(User user) throws SQLException,NoSuchAlgorithmException{
			System.out.println(INSERT_USERS_SQL);

			//convert the password to MD5
			//password = user.getUserPassword();
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(user.getPassword().getBytes());

			byte byteData[] = md.digest();

			//convert the byte to hex format
//			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();
//test
				//3. create statement
				ps = con.prepareStatement(INSERT_USERS_SQL);
				ps.setString(1, user.getUserName());
				ps.setString(2, user.getEmail());
				ps.setString(3, sb.toString());
				ps.setInt(4, user.getTypeID());
				
				//4. execute query
				ps.executeUpdate();
				System.out.print("User registered successfully");
				//5. close connection
				con.close();

			}catch(SQLException e) {
				e.printStackTrace();
			}	
		}

		//select user by id
		public static User getUser(int id) {
			System.out.println(SELECT_USER_BY_ID);

			User user = new User();

			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
				ps = con.prepareStatement(SELECT_USER_BY_ID);
				ps.setInt(1,userID);

				//4. execute query
				ps.executeUpdate();

				//process ResultSet
				if (rs.next()) {
					user.setUserId(rs.getInt("userID"));
					user.setUserName(rs.getString("userName"));
					user.setEmail(rs.getString("email"));
					user.setPassword(rs.getString("password"));
				}

				//5. close connection
				con.close();

			}catch(SQLException e) {
				e.printStackTrace();
			}	

			return user;
		}

		//select all users
		public static List<User> getAllUsers() { 
			System.out.println(SELECT_ALL_USERS);
			List<User> users = new ArrayList<User>(); 
			try { 
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
				stmt = con.createStatement();

				//4. execute query
				rs = stmt.executeQuery(SELECT_ALL_USERS);

				//process ResultSet
				while (rs.next()) { 
					User user = new User();
					user.setUserId(rs.getInt("userID"));
					user.setEmail(rs.getString("email"));
					user.setUserName(rs.getString("userName"));
					user.setPassword(rs.getString("password"));
					user.setTypeID(rs.getInt("typeID"));
					users.add(user);
				} 
				//5. close connection
				con.close();

			}catch(SQLException e) {
				e.printStackTrace();
			}
			return users; 
		}
		
		//select all users by ProjectID
		public static List<User> getAllUsersByProjectID(int projectID) { 
			System.out.println(SELECT_ALL_USERS_BY_PID);
			
			List<User> users = new ArrayList<User>(); 
			try { 
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
				ps = con.prepareStatement(SELECT_ALL_USERS_BY_PID);
				ps.setInt(1,projectID);
				
				//4. execute query
				rs = ps.executeQuery();

				//process ResultSet
				while (rs.next()) { 
					User user = new User();
					user.setUserId(rs.getInt("userID"));
					user.setEmail(rs.getString("email"));
					user.setUserName(rs.getString("userName"));
					user.setPassword(rs.getString("password"));
					user.setTypeID(rs.getInt("typeID"));
					users.add(user);
				} 
				//5. close connection
				con.close();

			}catch(SQLException e) {
				e.printStackTrace();
			}
			return users; 
		}

		//delete user
		public static boolean deleteUser(int id) throws SQLException {
			System.out.println(DELETE_USERS_SQL);

			boolean rowDeleted=false;
			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
				ps=con.prepareStatement(DELETE_USERS_SQL);
				ps.setInt(1, id);

				//4. execute query
				ps.executeUpdate();

				//5. close connection
				con.close();

			}catch(SQLException e) {
				e.printStackTrace();
			}	
			return rowDeleted;
		}

		//update user
		public static void updateUser(User user){
			System.out.println(UPDATE_USERS_SQL);
			
			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
		

				//4. execute query
				

				//5. close connection
				con.close();

			}catch(SQLException e) {
				e.printStackTrace();
			}	
		}

		public static User getUserByEmail(String email) {
			User user = new User();
			try {
				//call getConnection() method 
				con = ConnectionManager.getConnection();
				
				//3. create statement  
				sql = "SELECT * FROM user WHERE email=?";
				ps=con.prepareStatement(sql);
				ps.setString(1, email);
				
				//execute statement
				rs = ps.executeQuery();

				if (rs.next()) {	            
					user.setUserId(rs.getInt("userID"));
					user.setEmail(rs.getString("email"));				
					user.setPassword(rs.getString("password"));
					user.setTypeID(rs.getInt("typeID"));
				}
				//5. close connection
				con.close();
				
			}catch(Exception e) {
				e.printStackTrace();		
			}

			return user;
		}

		
		//login
		public static User login(User user) throws SQLException, NoSuchAlgorithmException{

			//convert the password to MD5
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(user.getPassword().getBytes());

			byte byteData[] = md.digest();

			//convert the byte to hex format
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			try {
				//call getConnection() method 
				con = ConnectionManager.getConnection();
				//3. create statement
				ps = con.prepareStatement(SELECT_USER_LOGIN);
		        ps.setString(1, user.getEmail());
		        ps.setString(2, sb.toString());

				//4. execute query
				rs = ps.executeQuery();

				//process ResultSet
				//if user exists set the isLoggedIn variable to true
				if (rs.next()) {
					// User exists, retrieve details
		            user.setUserId(rs.getInt("userID"));
		            user.setUserName(rs.getString("userName"));
		            user.setEmail(rs.getString("email"));
		            user.setTypeID(rs.getInt("typeID")); // Assuming userType is stored as an integer
		            user.setLoggedIn(true);

		            if (user.getTypeID() == 1) { 
		                System.out.println("Logged in as Project Manager");
		            } else if (user.getTypeID() == 2) {
		                System.out.println("Logged in as Member");
		            }
					
					
				}
				// if user does not exist set the isLoggedIn variable to false
				else{
					user.setLoggedIn(false);
				}

				//5. close connection
				con.close();
			}catch(SQLException e) {
				e.printStackTrace();		
			}

			return user;
		}
}
