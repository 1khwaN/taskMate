package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.UserDAO;
import model.User;
import java.io.IOException;


public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HttpSession session;
	private RequestDispatcher view;
	
    public LoginController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve and set user credentials
        	User user = new User();
        	
        	String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            user.setEmail(email);
            user.setPassword(password);

            // Attempt to log in the user
            user = UserDAO.login(user);

          //set user session if user is valid
            if (user.isLoggedIn()) {
				session = request.getSession(true);
                session.setAttribute("sessionId", user.getUserId());
                session.setAttribute("sessionEmail", user.getEmail());
                session.setAttribute("sessionTypeID", user.getTypeID());
                
                // Redirect based on user role
                if (user.getTypeID() == 1) { // Project manager
                	request.setAttribute("user", UserDAO.getUserByEmail(user.getEmail()));   					
                	System.out.print(user.getEmail()+" Login successfully");
                	view = request.getRequestDispatcher("pages/dashboard.jsp"); 			// staff page
					view.forward(request, response);
                	
                } else 
                    response.sendRedirect("memberView.jsp");
                    System.out.print(user.getEmail()+" Login successfully");
                	view = request.getRequestDispatcher("pages/memberView.jsp"); 			// staff page
					view.forward(request, response);
					
            } else {
                // Invalid login, redirect to error page
				/*
				 * request.setAttribute("errorMessage", "Invalid email or password.");
				 * RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
				 * dispatcher.forward(request, response);
				 */
            	response.sendRedirect("invalidLogin.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
			/*
			 * request.setAttribute("errorMessage",
			 * "An unexpected error occurred. Please try again later."); RequestDispatcher
			 * dispatcher = request.getRequestDispatcher("login.jsp");
			 * dispatcher.forward(request, response);
			 */
        }
    }
}
