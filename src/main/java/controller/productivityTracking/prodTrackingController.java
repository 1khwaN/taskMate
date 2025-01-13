package controller.productivityTracking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.stream.Collectors;

import dao.ProdTrackingDAO;

/**
 * Servlet implementation class prodTrackingController
 */
public class prodTrackingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public prodTrackingController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ProdTrackingDAO dao = new ProdTrackingDAO();

	    // Fetch task counts by status from the database
	    Map<String, Integer> taskCounts = dao.getTaskCountsByStatus();

	    // Prepare data for JSP
	    String statuses = String.join(", ", taskCounts.keySet().stream().map(s -> "\"" + s + "\"").toArray(String[]::new));
	    String counts = taskCounts.values().stream().map(String::valueOf).collect(Collectors.joining(", "));

	    // Pass the data to the JSP
	    request.setAttribute("taskStatuses", statuses);
	    request.setAttribute("taskCounts", counts);

	    // Forward to JSP
	    request.getRequestDispatcher("views/prodTracking.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
