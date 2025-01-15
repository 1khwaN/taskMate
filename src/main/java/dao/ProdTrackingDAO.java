package dao;

import java.sql.*;
import java.util.*;
import connection.ConnectionManager;

public class ProdTrackingDAO {

    private static final String GET_TASK_COUNT = "SELECT taskStatus, COUNT(*) AS count FROM task GROUP BY taskStatus";

    public Map<String, Integer> getTaskCountsByStatus() {
        // Map to hold the result in the desired order
        Map<String, Integer> taskCounts = new LinkedHashMap<>();
        
        // Predefined order of task statuses
        List<String> statusOrder = Arrays.asList("To Do", "Doing", "Done");

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
}
