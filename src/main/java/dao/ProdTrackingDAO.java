package dao;

import java.sql.*;
import java.util.*;
import connection.ConnectionManager;

public class ProdTrackingDAO {

    private static final String GET_TASK_COUNT = "SELECT taskStatus, COUNT(*) AS count FROM task GROUP BY taskStatus";//not used
    private static final String GET_TASK_COUNT_BY_USER = "SELECT t.taskStatus, COUNT(*) AS count " +
												         "FROM task t " +
												         "INNER JOIN task_member tm ON t.taskID = tm.taskID " +
												         "INNER JOIN user u ON tm.userID = u.userID " +
												         "WHERE u.userID = ? " +
												         "GROUP BY t.taskStatus";// USE FOR NORMAL COUNT
    
    private static final String GET_TASK_DETAILS_BY_USER = "SELECT t.taskStatus, t.taskName " +
												           "FROM task t " +
												           "INNER JOIN task_member tm ON t.taskID = tm.taskID " +
												           "INNER JOIN user u ON tm.userID = u.userID " +
												           "WHERE u.userID = ? " +
												           "ORDER BY t.taskStatus";//Use for Chart(member)
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

 
    public Map<String, Integer> getTaskCountsByStatus() {
        // Map to hold the result in the desired order
        Map<String, Integer> taskCounts = new LinkedHashMap<>();
        
        // Predefined order of task statuses
        List<String> statusOrder = Arrays.asList("To Do", "Doing", "Done");

        try {
            // Establish connection
            con = ConnectionManager.getConnection();

            // Prepare and execute the query
            ps = con.prepareStatement(GET_TASK_COUNT);
            rs = ps.executeQuery();

            // Process the result set
            Map<String, Integer> result = new HashMap<>();
            while (rs.next()) {
                String status = rs.getString("taskStatus"); // Ensure column name matches the DB schema
                int count = rs.getInt("count");

                // Store the result in a temporary map
                result.put(status, count);
            }

            // Now, order the result based on the predefined status order
            for (String status : statusOrder) {
                if (result.containsKey(status)) {
                    taskCounts.put(status, result.get(status));
                } else {
                    // If a status is missing (e.g., no tasks in this status), assign a count of 0
                    taskCounts.put(status, 0);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
        } finally {
            // Close resources to avoid memory leaks
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Log the exception
            }
        }

        // Debugging output for the entire map
        System.out.println("Ordered Task Counts Map: " + taskCounts);

        // Return the task counts map
        return taskCounts;
    }
    
    public Map<String, Integer> getTaskCountsByUser(int userID) {
        Map<String, Integer> taskCounts = new LinkedHashMap<>();
        List<String> statusOrder = Arrays.asList("To Do", "Doing", "Done"); 



        try {
            con = ConnectionManager.getConnection();
            ps = con.prepareStatement(GET_TASK_COUNT_BY_USER);
            ps.setInt(1, userID); // Set the user ID parameter
            rs = ps.executeQuery();

            Map<String, Integer> result = new HashMap<>();
            while (rs.next()) {
                String status = rs.getString("taskStatus");
                int count = rs.getInt("count");
                result.put(status, count);
            }

            // Ensure the task counts follow the predefined status order
            for (String status : statusOrder) {
                taskCounts.put(status, result.getOrDefault(status, 0));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return taskCounts;
    }
    
    public Map<String, List<String>> getTaskDetailsByUser(int userID) {
        Map<String, List<String>> taskDetails = new LinkedHashMap<>();
        List<String> statusOrder = Arrays.asList("To Do", "Doing", "Done"); 

        // Initialize the map with empty lists for each status
        for (String status : statusOrder) {
            taskDetails.put(status, new ArrayList<>());
        }

        try {
            con = ConnectionManager.getConnection();
            ps = con.prepareStatement(GET_TASK_DETAILS_BY_USER);
            ps.setInt(1, userID); // Set the user ID parameter
            rs = ps.executeQuery();

            while (rs.next()) {
                String status = rs.getString("taskStatus");
                String taskName = rs.getString("taskName");

                // Add the task name to the corresponding status
                if (taskDetails.containsKey(status)) {
                    taskDetails.get(status).add(taskName);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return taskDetails;
    }


}
