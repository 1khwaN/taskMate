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

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve and set user credentials
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = new User();
            user.setEmail(email);
            user.setPassword(password);

            // Attempt to log in the user
            user = UserDAO.login(user);

            if (user.isLoggedIn()) {
                HttpSession session = request.getSession();
                session.setAttribute("sessionId", user.getUserId());
                session.setAttribute("sessionEmail", user.getEmail());
                
                // Redirect based on user role
                if (user.getTypeID() == 1) { // Project manager
                    response.sendRedirect("/pages/dashboard.jsp");
                } else if (user.getTypeID() == 2) { // Member
                    response.sendRedirect("/pages/memberView.jsp");
                } else {
                    response.sendRedirect("/invalidLogin.jsp"); // Default fallback
                }
            } else {
                // Invalid login, redirect to error page
                request.setAttribute("errorMessage", "Invalid email or password.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
