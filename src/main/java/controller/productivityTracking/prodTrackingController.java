package controller.productivityTracking;

import dao.ProdTrackingDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/prodTracking")
public class prodTrackingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public prodTrackingController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdTrackingDAO dao = new ProdTrackingDAO();

        // Get the logged-in user ID from the session
//        Integer loggedInUserId = (Integer) request.getSession().getAttribute("userID");
        Integer loggedInUserId = 4;
//        if (loggedInUserId == null) {
//            // If user is not logged in, redirect to login page
//            response.sendRedirect("pages/login.jsp");
//            return;
//        }

        // Fetch task counts for the logged-in user
        Map<String, Integer> userTaskCounts = dao.getTaskCountsByUser(loggedInUserId);

        // Prepare JSON for chart data
        StringBuilder statusesJson = new StringBuilder("[");
        StringBuilder countsJson = new StringBuilder("[");

        for (Map.Entry<String, Integer> entry : userTaskCounts.entrySet()) {
            statusesJson.append("\"").append(entry.getKey()).append("\",");
            countsJson.append(entry.getValue()).append(",");
        }

        // Remove trailing commas and close the arrays
        if (!userTaskCounts.isEmpty()) {
            statusesJson.deleteCharAt(statusesJson.length() - 1);
            countsJson.deleteCharAt(countsJson.length() - 1);
        }
        statusesJson.append("]");
        countsJson.append("]");

        // Pass the JSON data to the JSP
        request.setAttribute("taskStatuses", statusesJson.toString());
        request.setAttribute("taskCounts", countsJson.toString());

        // Forward to JSP
        RequestDispatcher view = request.getRequestDispatcher("pages/prodTracking.jsp");
        view.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // No POST handling
    }
}
