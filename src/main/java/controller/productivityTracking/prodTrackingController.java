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

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        ProdTrackingDAO dao = new ProdTrackingDAO();
//
//        // Get the logged-in user ID from the session
////        Integer loggedInUserId = (Integer) request.getSession().getAttribute("userID");
//        Integer loggedInUserId = 4;
////        if (loggedInUserId == null) {
////            // If user is not logged in, redirect to login page
////            response.sendRedirect("pages/login.jsp");
////            return;
////        }
//
//        // Fetch task counts for the logged-in user
//        Map<String, Integer> userTaskCounts = dao.getTaskCountsByUser(loggedInUserId);
//
//        // Prepare JSON for chart data
//        StringBuilder statusesJson = new StringBuilder("[");
//        StringBuilder countsJson = new StringBuilder("[");
//
//        for (Map.Entry<String, Integer> entry : userTaskCounts.entrySet()) {
//            statusesJson.append("\"").append(entry.getKey()).append("\",");
//            countsJson.append(entry.getValue()).append(",");
//        }
//
//        // Remove trailing commas and close the arrays
//        if (!userTaskCounts.isEmpty()) {
//            statusesJson.deleteCharAt(statusesJson.length() - 1);
//            countsJson.deleteCharAt(countsJson.length() - 1);
//        }
//        statusesJson.append("]");
//        countsJson.append("]");
//
//        // Pass the JSON data to the JSP
//        request.setAttribute("taskStatuses", statusesJson.toString());
//        request.setAttribute("taskCounts", countsJson.toString());
//
//        // Forward to JSP
//        RequestDispatcher view = request.getRequestDispatcher("pages/prodTracking.jsp");
//        view.forward(request, response);
//    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	ProdTrackingDAO dao = new ProdTrackingDAO();

        // Simulate getting the logged-in user ID and role from session
        // Replace this with actual session attributes in a real implementation
        int loggedInUserID = 2; // Hardcoded for now
        int userRole = 2; // Hardcoded role: 1 = Project Manager, 2 = Member
        request.getSession().setAttribute("role", userRole); // Set role in session for JSP usage

        // Fetch task details grouped by status
        Map<String, List<String>> taskDetails = dao.getTaskDetailsByUser(loggedInUserID);

        // Define colors for charts
        String[] colors = { "#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF", "#FF9F40" };
        int colorIndex = 0;

        // Prepare data for the stacked bar chart
        StringBuilder labelsJson = new StringBuilder("[");
        StringBuilder datasetsJson = new StringBuilder("[");

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

        // Pass task data to JSP
        request.setAttribute("taskStatuses", labelsJson.toString());
        request.setAttribute("taskDatasets", datasetsJson.toString());

        // If the user is a project manager, fetch project data
        if (userRole == 1) {
            Map<String, Integer> projectCounts = dao.getProjectCountsByUser(loggedInUserID);

            StringBuilder projectLabelsJson = new StringBuilder("[");
            StringBuilder projectCountsJson = new StringBuilder("[");

            for (Map.Entry<String, Integer> entry : projectCounts.entrySet()) {
                projectLabelsJson.append("\"").append(entry.getKey()).append("\",");
                projectCountsJson.append(entry.getValue()).append(",");
            }

            if (!projectCounts.isEmpty()) {
                projectLabelsJson.deleteCharAt(projectLabelsJson.length() - 1);
                projectCountsJson.deleteCharAt(projectCountsJson.length() - 1);
            }
            projectLabelsJson.append("]");
            projectCountsJson.append("]");

            // Pass project data to JSP
            request.setAttribute("projectStatuses", projectLabelsJson.toString());
            request.setAttribute("projectCounts", projectCountsJson.toString());
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
