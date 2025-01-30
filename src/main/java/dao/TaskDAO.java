package dao;

import java.sql.*;
import java.util.*;

import connection.ConnectionManager;
import model.Task;

public class TaskDAO {

	private static Connection con = null;
	private static ResultSet rs = null;
	private static PreparedStatement ps = null;
	private static String sql = null;
	
	public static int addTask(Task task) {
	    String query = "INSERT INTO task (taskName, description, startDate, endDate, taskStatus, projectID) VALUES (?, ?, ?, ?, ?, ?)";
	    int taskID = -1; // Default value if insert fails

	    try (Connection con = ConnectionManager.getConnection();
	         PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

	        ps.setString(1, task.getTaskName());
	        ps.setString(2, task.getDescription());
	        ps.setString(3, task.getStartDate());
	        ps.setString(4, task.getEndDate());
	        ps.setString(5, task.getTaskStatus());
	        ps.setInt(6, task.getProjectID());

	        int rowsAffected = ps.executeUpdate();

	        if (rowsAffected > 0) {
	            ResultSet rs = ps.getGeneratedKeys();
	            if (rs.next()) {
	                taskID = rs.getInt(1); // Get auto-generated taskID
	            }
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return taskID; // Return new taskID
	}
	
	public static void addTaskMember(int taskID, int userID) {
	    String query = "INSERT INTO task_member(taskID,userID) VALUES(?,?)";
	    
	    try (
	    	Connection con = ConnectionManager.getConnection();
	        PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setInt(1, taskID);
	        ps.setInt(2, userID);
	        ps.executeUpdate();
	        System.out.println("Task member added: TaskID = " + taskID + ", UserID = " + userID);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public static List<Task> getAllTasks() {
		List<Task> tasks = new ArrayList<Task>();
		try {
			con = ConnectionManager.getConnection();
			
			sql = "SELECT * FROM task ORDER BY taskID";
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				Task task = new Task();
				task.setTaskID(rs.getInt("taskID"));
				task.setTaskName(rs.getString("taskName"));
				task.setDescription(rs.getString("description"));
				task.setStartDate(rs.getString("startDate"));
				task.setEndDate(rs.getString("endDate"));
				task.setTaskStatus(rs.getString("taskStatus"));
				task.setProjectID(rs.getInt("projectID"));
				tasks.add(task);
			}
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return tasks;
	}
	
	public static Task getTaskByID(int taskID) {
		Task task = new Task();
		try {
			con = ConnectionManager.getConnection();
			
			sql = "SELECT * FROM task WHERE taskID = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, taskID);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				task.setTaskID(rs.getInt("taskID"));
				task.setTaskName(rs.getString("taskName"));
				task.setDescription(rs.getString("description"));
				task.setStartDate(rs.getString("startDate"));
				task.setEndDate(rs.getString("endDate"));
				task.setTaskStatus(rs.getString("taskStatus"));
				task.setProjectID(rs.getInt("projectID"));
			}
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return task;
	}
	
	public static void updateTask(Task task) {
		try {
			con = ConnectionManager.getConnection();
			
			sql = "UPDATE task SET taskName=?, description=?, startDate=?, endDate=?, taskStatus=?, projectID=? WHERE taskID=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, task.getTaskName());
			ps.setString(2, task.getDescription());
			ps.setString(3, task.getStartDate());
			ps.setString(4, task.getEndDate());
			ps.setString(5, task.getTaskStatus());
			ps.setInt(6,  task.getProjectID());
			ps.setInt(7,  task.getTaskID());
			
			ps.executeUpdate();
			
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static List<Task> getProjectTasks() {
		List<Task> tasks = new ArrayList<Task>();
		try {
			con = ConnectionManager.getConnection();
			
			sql = "SELECT * FROM task t INNER JOIN project p ON t.projectID = p.projectID";
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				Task task = new Task();
				task.setTaskID(rs.getInt("taskID"));
				task.setTaskName(rs.getString("taskName"));
				task.setDescription(rs.getString("description"));
				task.setStartDate(rs.getString("startDate"));
				task.setEndDate(rs.getString("endDate"));
				task.setTaskStatus(rs.getString("taskStatus"));
				task.setProjectID(rs.getInt("projectID"));
				task.setProject(ProjectDAO.getProjectByID(rs.getInt("projectID")));
				tasks.add(task);
			}
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return tasks;
	}
	
	public static List<Task> getTasksByProjectID(int projectID) {
		List<Task> tasks = new ArrayList<Task>();
		try {
			con = ConnectionManager.getConnection();

			sql = "SELECT * FROM task WHERE projectID = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, projectID);

			rs = ps.executeQuery();

			while (rs.next()) {
				Task task = new Task();
				task.setTaskID(rs.getInt("taskID"));
				task.setTaskName(rs.getString("taskName"));
				task.setDescription(rs.getString("description"));
				task.setStartDate(rs.getString("startDate"));
				task.setEndDate(rs.getString("endDate"));
				task.setTaskStatus(rs.getString("taskStatus"));
				task.setProjectID(rs.getInt("projectID"));
				task.setProject(ProjectDAO.getProjectByID(rs.getInt("projectID"))); // Optional if needed
				tasks.add(task);
			}

			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tasks;
	}
	
	
	public static void deleteTask(int taskID) {
        try {
            con = ConnectionManager.getConnection();

            // First, delete related task_member records
            String deleteTaskMembersSQL = "DELETE FROM task_member WHERE taskID = ?";
            PreparedStatement stmt1 = con.prepareStatement(deleteTaskMembersSQL);
            stmt1.setInt(1, taskID);
            int membersDeleted = stmt1.executeUpdate();
            System.out.println("Deleted " + membersDeleted + " members for taskID: " + taskID);

            // Then, delete the task
            sql = "DELETE FROM task WHERE taskID = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, taskID);

            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " task(s) with taskID: " + taskID);

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteAllTasksByProject(int projectID) {
        try (Connection conn = ConnectionManager.getConnection()) {
            // Delete all related task_member records first
            String deleteTaskMembersSQL = "DELETE FROM task_member WHERE taskID IN (SELECT taskID FROM task WHERE projectID = ?)";
            try (PreparedStatement stmt1 = conn.prepareStatement(deleteTaskMembersSQL)) {
                stmt1.setInt(1, projectID);
                int membersDeleted = stmt1.executeUpdate();
                System.out.println("Deleted " + membersDeleted + " task_members for projectID: " + projectID);
            }

            // Then, delete all tasks
            String deleteTasksSQL = "DELETE FROM task WHERE projectID = ?";
            try (PreparedStatement stmt2 = conn.prepareStatement(deleteTasksSQL)) {
                stmt2.setInt(1, projectID);
                int rowsAffected = stmt2.executeUpdate();
                System.out.println("Deleted " + rowsAffected + " tasks for projectID: " + projectID);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
