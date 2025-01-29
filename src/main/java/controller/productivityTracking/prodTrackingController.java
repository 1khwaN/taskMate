package controller.productivityTracking;

import dao.ProdTrackingDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;



@WebServlet("/prodTracking")
public class prodTrackingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public prodTrackingController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer loggedInUserID = (Integer) request.getSession().getAttribute("userID");
        Integer userRole = (Integer) request.getSession().getAttribute("sessionTypeID");
        ProdTrackingDAO dao = new ProdTrackingDAO();

        // Fetch task details grouped by status for a specific user
        Map<String, List<String>> taskDetails = dao.getTaskDetailsByUser(loggedInUserID);

        // Define the fixed set of colors
        String[] colors = { "#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF", "#FF9F40" };
        int colorIndex = 0;

        // Convert data to JSON-like strings for Chart.js
        StringBuilder labelsJson = new StringBuilder("[");
        StringBuilder datasetsJson = new StringBuilder("[");

        // Loop through the task details for stacked bar chart
        for (Map.Entry<String, List<String>> entry : taskDetails.entrySet()) {
            labelsJson.append("\"").append(entry.getKey()).append("\",");

            for (String taskName : entry.getValue()) {
                datasetsJson.append("{")
                    .append("\"label\":\"").append(taskName).append("\",")
                    .append("\"data\":[");

                for (String status : taskDetails.keySet()) {
                    datasetsJson.append(status.equals(entry.getKey()) ? 1 : 0).append(",");
                }

                datasetsJson.deleteCharAt(datasetsJson.length() - 1).append("],")
                    .append("\"backgroundColor\":\"").append(colors[colorIndex % colors.length]).append("\"")
                    .append("},");

                colorIndex++;
            }
        }

        if (!taskDetails.isEmpty()) {
            labelsJson.deleteCharAt(labelsJson.length() - 1);
            datasetsJson.deleteCharAt(datasetsJson.length() - 1);
        }

        labelsJson.append("]");
        datasetsJson.append("]");

        // Pass task data to JSP for stacked bar chart
        request.setAttribute("taskStatuses", labelsJson.toString());
        request.setAttribute("taskDatasets", datasetsJson.toString());

        // Fetch project counts for the pie chart if userRole is 1
        if (userRole == 1) {
            Map<String, Integer> projectCounts = dao.getProjectCountsByUser(loggedInUserID);
            StringBuilder pieChartData = new StringBuilder("[");

            // Construct the pie chart data from project counts
            for (Map.Entry<String, Integer> entry : projectCounts.entrySet()) {
                pieChartData.append("{")
                    .append("\"label\":\"").append(entry.getKey()).append("\",")
                    .append("\"value\":").append(entry.getValue()).append("},");
            }

            if (!projectCounts.isEmpty()) {
                pieChartData.deleteCharAt(pieChartData.length() - 1);
            }

            pieChartData.append("]");

            // Pass the pie chart data to JSP
            request.setAttribute("pieChartData", pieChartData.toString());
        }

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/prodTracking.jsp");
        dispatcher.forward(request, response);
    }




    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // No POST handling
    }
}
