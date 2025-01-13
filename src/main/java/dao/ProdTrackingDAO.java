package dao;

import java.security.*;
import java.sql.*;
import java.util.*;

import connection.ConnectionManager;


public class ProdTrackingDAO{
	
	private static Connection con = null;
	private static PreparedStatement ps = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static final String getTaskCount = "SELECT taskStatus, COUNT(*) AS count FROM task GROUP BY taskStatus";
	
	public Map<String, Integer> getTaskCountsByStatus() {
        Map<String, Integer> taskCounts = new HashMap<>();
        

        try { 
        	con = ConnectionManager.getConnection();
            ps = con.prepareStatement(getTaskCount);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                taskCounts.put(status, count);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return taskCounts;
    }
}
