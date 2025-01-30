package controller;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Project;
import model.User;
import dao.UserDAO;
import java.io.IOException;

/**
 * Servlet implementation class RegisterController
 */
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		view = request.getRequestDispatcher("pages/signup.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    User user = new User();
	    
	    // Retrieve input from form
	    String userName = request.getParameter("userName");
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    String confirmPassword = request.getParameter("confirmPassword");

	    // Set default typeID to 1 if not provided
	    int typeID = request.getParameter("typeID") != null ? Integer.parseInt(request.getParameter("typeID")) : 1;
	    
	    //System.out.println(email);
	    // Password confirmation check
	    if (!password.equals(confirmPassword)) {
	        request.setAttribute("errorMessage", "Passwords do not match!");
	        RequestDispatcher view = request.getRequestDispatcher("pages/signup.jsp");
	        view.forward(request, response);
	        return;
	    }

	    // Check if user already exists
	    if (UserDAO.isEmailRegistered(email)) {
	        request.setAttribute("errorMessage", "This email is already registered. Please log in.");
	        RequestDispatcher view = request.getRequestDispatcher("pages/signup.jsp");
	        view.forward(request, response);
	        return;
	    }
	    
	 // Validate password strength
	    if (password.length() < 6 || !password.matches(".*[A-Z].*") || !password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
	        request.setAttribute("errorMessage", "Password must be at least 6 characters, contain 1 uppercase letter, and 1 special character.");
	        RequestDispatcher view = request.getRequestDispatcher("pages/signup.jsp");
	        view.forward(request, response);
	        return;
	    }

	    // Set user details
	    user.setUserName(userName);
	    user.setEmail(email);
	    user.setPassword(password);
	    user.setTypeID(typeID);
	    
	    try {
	        UserDAO.insertUser(user);
	        RequestDispatcher view = request.getRequestDispatcher("pages/login.jsp"); 
	        view.forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


}
