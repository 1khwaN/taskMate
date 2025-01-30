package dao;

import java.security.*;
import java.sql.*;
import java.util.*;

import com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.Pattern;

import connection.ConnectionManager;
import model.User;

public class UserDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static String sql=null;
	private static String INSERT_USERS_SQL = "INSERT INTO user(userName,email,password,typeID)VALUES(?,?,?,?)";
	private static final String SELECT_USER_BY_ID = "SELECT * FROM user WHERE userID = ?";
	private static final String SELECT_ALL_USERS_BY_PID = "SELECT * "
			+ "FROM project_member pm "
			+ "INNER JOIN user u ON pm.userID = u.userID "
			+ "INNER JOIN project p ON pm.projectID = p.projectID "
			+ "WHERE pm.projectID = ?;";
	private static final String SELECT_ALL_USERS = "SELECT * FROM user";
	private static final String DELETE_USERS_SQL = "DELETE FROM user WHERE userID = ?;";
	private static final String UPDATE_USER_SQL = "UPDATE user SET userName = ?, email = ?, password = ? WHERE userID = ?;";
	private static final String SELECT_USER_LOGIN = "SELECT * FROM user WHERE email = ? AND password = ?";
	private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM user WHERE email = ?";
	
	private static User user = null;
	private static int userID;
	private static String userName, email, password;
	private static int typeID;
	private static int isLoggedIn;
	
	//insert user
	public static void insertUser(User user) throws  NoSuchAlgorithmException {
	    System.out.println(INSERT_USERS_SQL);

	    // Convert password to MD5
	    MessageDigest md = MessageDigest.getInstance("MD5");
	    md.update(user.getPassword().getBytes());

	    byte byteData[] = md.digest();
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < byteData.length; i++) {
	        sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	    }

	    try {
	        // Get database connection
	        con = ConnectionManager.getConnection();

	        // Ensure typeID is set (default to 1 if not provided)
	        int typeID = user.getTypeID() > 0 ? user.getTypeID() : 1;

	        // Prepare SQL statement
	        ps = con.prepareStatement(INSERT_USERS_SQL);
	        ps.setString(1, user.getUserName());
	        ps.setString(2, user.getEmail());
	        ps.setString(3, sb.toString()); // Store encrypted password
	        ps.setInt(4, typeID); // Set default typeID if not provided

	        // Execute query
	        ps.executeUpdate();
	        System.out.print(user.getEmail() + " registered successfully");

	        // Close connection
	        con.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	//insert project_member
	public static void insertProjectMember(User user, int projectID) throws  NoSuchAlgorithmException {
	    System.out.println(INSERT_USERS_SQL);

	    // Convert password to MD5
	    MessageDigest md = MessageDigest.getInstance("MD5");
	    md.update(user.getPassword().getBytes());

	    byte byteData[] = md.digest();
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < byteData.length; i++) {
	        sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	    }

	    try {
	        con = ConnectionManager.getConnection();

	        // Ensure typeID is set (default to 1 if not provided)
	        int typeID = user.getTypeID() > 0 ? user.getTypeID() : 1;

	        // Prepare SQL statement
	        ps = con.prepareStatement(INSERT_USERS_SQL, Statement.RETURN_GENERATED_KEYS);
	        ps.setString(1, user.getUserName());
	        ps.setString(2, user.getEmail());
	        ps.setString(3, sb.toString()); // Store encrypted password
	        ps.setInt(4, typeID); // Set default typeID if not provided

	        // Execute query
	        ps.executeUpdate();
	        
	        rs = ps.getGeneratedKeys();
	        int userID = -1;
	        if (rs.next()) {
	        	userID = rs.getInt(1);
                System.out.println("Generated userID: " + userID);
	        }
	        
	        if (userID != -1) {
                String sql = "INSERT INTO project_member (projectID, userID) VALUES (?, ?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, projectID);
                ps.setInt(2, userID);
                ps.executeUpdate();
                System.out.println("Added to project_member");
            }else {
                System.out.println("Failed to add user to project_member table.");
            }
	        
	        // Close connection
	        con.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	public static boolean isEmailRegistered(String email) {
	    boolean exists = false;
	    try {
	        con = ConnectionManager.getConnection();
	        String checkEmailSQL = "SELECT COUNT(*) FROM user WHERE email = ?";
	        ps = con.prepareStatement(checkEmailSQL);
	        ps.setString(1, email);
	        rs = ps.executeQuery();
	        
	        if (rs.next() && rs.getInt(1) > 0) {
	            exists = true;
	        }

	        con.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return exists;
	}

		//select user by email
		public static User getUser(User user) {
			System.out.println(SELECT_USER_BY_EMAIL);


			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
				ps = con.prepareStatement(SELECT_USER_BY_EMAIL);
				ps.setString(1,user.getEmail());

				//4. execute query
				ps.executeUpdate();

				//process ResultSet
				if (rs.next()) {
					user.setUserID(rs.getInt("userID"));
					user.setUserName(rs.getString("userName"));
					user.setEmail(rs.getString("email"));
					user.setPassword(rs.getString("password"));
					user.setLoggedIn(true);
				}
				
				// if user does not exist set the isValid variable to false
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

		//select user by id
		public static User getUser(int id) {
					System.out.println(SELECT_USER_BY_ID);

					User user = new User();

					try {			
						//call getConnection() method
						con = ConnectionManager.getConnection();

						//3. create statement
						ps = con.prepareStatement(SELECT_USER_BY_ID);
						ps.setInt(1,id);

						//4. execute query
						rs = ps.executeQuery();

						//process ResultSet
						if (rs.next()) {
							user.setUserID(rs.getInt("userID"));
							user.setUserName(rs.getString("userName"));
							user.setEmail(rs.getString("email"));
							user.setPassword(rs.getString("password"));
							user.setTypeID(rs.getInt("typeID"));
							System.out.println(user.getUserName());
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
					user.setUserID(rs.getInt("userID"));
//					System.out.println(user.getUserId());
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
							user.setUserID(rs.getInt("userID"));
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
		
		//method to check if MD5
		private static boolean isMD5(String password) {
		    return password != null && password.matches("^[a-fA-F0-9]{32}$");
		}
		
		//update user
		public static void updateUser(User user) throws  NoSuchAlgorithmException{
			System.out.println(UPDATE_USER_SQL);
			
			String password = user.getPassword();
			
			if(!isMD5(password)) {
				//convert the password to MD5
				MessageDigest md = MessageDigest.getInstance("MD5");
				md.update(password.getBytes());

				byte byteData[] = md.digest();

				//convert the byte to hex format
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < byteData.length; i++) {
					sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				}
				password = sb.toString();
			}
			
			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();

				//3. create statement
				ps = con.prepareStatement(UPDATE_USER_SQL);
				ps.setString(1,user.getUserName());
				ps.setString(2,user.getEmail());
				ps.setString(3,password);
				ps.setInt(4, user.getUserID());

				//4. execute query
				ps.executeUpdate();

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
					user.setUserID(rs.getInt("userID"));
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
		            user.setUserID(rs.getInt("userID"));
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
