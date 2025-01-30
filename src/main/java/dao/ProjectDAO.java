package dao;

import java.sql.*;
import java.util.*;
import connection.ConnectionManager;
import model.Project;

public class ProjectDAO {

	private static Connection con = null;
	private static ResultSet rs = null;
	private static PreparedStatement ps = null;
	private static Statement stmt = null;
	private static String sql = null;

	//get all projects
	public static List<Project> getAllProject() {
		List<Project> projects = new ArrayList<Project>();
		try {
			con = ConnectionManager.getConnection();
			
			sql = "SELECT * FROM project ORDER BY projectID";
			ps = con.prepareStatement(sql);
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				Project project = new Project();
				project.setProjectID(rs.getInt("projectID"));
				project.setProjectName(rs.getString("projectName"));
				project.setDescription(rs.getString("description"));
				project.setStartDate(rs.getString("startDate"));
				project.setEndDate(rs.getString("endDate"));
				project.setProjectStatus(rs.getString("projectStatus"));
				project.setProjectPriority(rs.getString("projectPriority"));
				projects.add(project);
			}
			con.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return projects;
	}

	public static Project getProjectByID(int projectID) {
		Project project = new Project();
		try {
			con = ConnectionManager.getConnection();
			
			sql = "SELECT * FROM project WHERE projectID = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1,  projectID);
			
			rs = ps.executeQuery();
			
			if (rs.next() ) {
				project.setProjectID(rs.getInt("projectID"));
				project.setProjectName(rs.getString("projectName"));
				project.setDescription(rs.getString("description"));
				project.setStartDate(rs.getString("startDate"));
				project.setEndDate(rs.getString("endDate"));
				project.setProjectStatus(rs.getString("projectStatus"));
				project.setProjectPriority(rs.getString("projectPriority"));
			}
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return project;
	}

	public static void addProject(Project project) {
		try {
			con = ConnectionManager.getConnection();
			
			sql = "INSERT INTO project(projectName, description, startDate, endDate, projectStatus, projectPriority)VALUES(?,?,?,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, project.getProjectName());
			ps.setString(2, project.getDescription());
			ps.setString(3, project.getStartDate());
			ps.setString(4, project.getEndDate());
			ps.setString(5, project.getProjectStatus());
			ps.setString(6, project.getProjectPriority());
			
			ps.executeUpdate();
			
			System.out.print("Project addedd successfully");
			
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static void updateProject(Project project) {
		try {
			con = ConnectionManager.getConnection();
			
			sql = "UPDATE project SET projectName=?, description=?, startDate=?, endDate=?, projectStatus=?, projectPriority=? WHERE projectID=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, project.getProjectName());
			ps.setString(2, project.getDescription());
			ps.setString(3, project.getStartDate());
			ps.setString(4, project.getEndDate());
			ps.setString(5, project.getProjectStatus());
			ps.setString(6, project.getProjectPriority());
			ps.setInt(7,  project.getProjectID());
			
			ps.executeUpdate();
			
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void deleteProject(int projectID) {
	    try {
	        con = ConnectionManager.getConnection();

	        sql = "DELETE FROM project WHERE projectID = ?";
	        ps = con.prepareStatement(sql);
	        ps.setInt(1, projectID);

	        int rowsAffected = ps.executeUpdate();
	        System.out.println("Rows affected: " + rowsAffected); // Debug number of rows deleted

	        con.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public static List<Integer> getProjectIDsByUserID(int userID) {
	    List<Integer> projectIDs = new ArrayList<>();
	    
	    try {
	        con = ConnectionManager.getConnection();
	        
	        // Assuming there's a table 'user_project' that links users to projects
	        sql = "SELECT projectID FROM project_member WHERE userID = ?";
	        ps = con.prepareStatement(sql);
	        ps.setInt(1, userID);
	        
	        rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            projectIDs.add(rs.getInt("projectID"));
	        }
	        
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return projectIDs;
	}

}
