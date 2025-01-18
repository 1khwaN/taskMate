package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import dao.UserDAO;
import java.io.IOException;

//@WebServlet("/LoginController") // Use this or web.xml, not both
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = new User();
            user.setEmail(email);
            user.setPassword(password);

            user = UserDAO.login(user);

            if (user != null && user.isLoggedIn()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("sessionId", user.getUserId());
                session.setAttribute("sessionEmail", user.getEmail());
                session.setAttribute("sessionTypeID", user.getTypeID());

                RequestDispatcher view;
                if (user.getTypeID() == 1) { // Project manager
                    view = request.getRequestDispatcher("dashboard.jsp");
                } else { // Member
                    view = request.getRequestDispatcher("memberView.jsp");
                }
                request.setAttribute("user", UserDAO.getUserByEmail(user.getEmail()));
                System.out.print(user.getEmail() + " Login successfully");
                view.forward(request, response);
            } else {
                response.sendRedirect("invalidLogin.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }
}
