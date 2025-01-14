package dao;

import java.sql.*;
import java.util.*;
import connection.ConnectionManager;

public class ProdTrackingDAO {

    private static final String GET_TASK_COUNT = "SELECT taskStatus, COUNT(*) AS count FROM task GROUP BY taskStatus";

    public Map<String, Integer> getTaskCountsByStatus() {
        Map<String, Integer> taskCounts = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Establish connection
            con = ConnectionManager.getConnection();

            // Prepare and execute the query
            ps = con.prepareStatement(GET_TASK_COUNT);
            rs = ps.executeQuery();

            // Process the result set
            while (rs.next()) {
                String status = rs.getString("taskStatus"); // Ensure column name matches the DB schema
                int count = rs.getInt("count");

                // Debugging output
                System.out.println("Task Status: " + status + ", Count: " + count);

                // Store the result in the map
                taskCounts.put(status, count);
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
        System.out.println("Task Counts Map: " + taskCounts);

        // Return the task counts map
        return taskCounts;
    }
}
