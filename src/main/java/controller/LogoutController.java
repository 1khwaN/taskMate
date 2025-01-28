package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.UserDAO;
import java.io.IOException;

/**
 * Servlet implementation class LogoutController
 */
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			//get the current session
			session = request.getSession(true);
			//set current session to null.
			session.setAttribute("sessionEmail", null);	
			System.out.println("user logout successfully");
			//destroy session
			session.invalidate();			
			//redirect to login page						  
			response.sendRedirect("pages/login.jsp");			
		}catch (Throwable ex) {
			ex.printStackTrace();
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
