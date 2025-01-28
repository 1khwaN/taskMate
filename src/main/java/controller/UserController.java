package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.ProjectDAO;
import dao.UserDAO;

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String action="", forward="";
	private static String VIEW ="viewRegister.jsp";
	private static String LIST ="/pages/memberView.jsp";
	private static String UPDATE ="updateRegister.jsp";
	private int id;
	
    public UserController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action = request.getParameter("action");//do not remove
		
		if(action.equalsIgnoreCase("list")) {
			forward = LIST;

			request.setAttribute("users",UserDAO.getAllUsers());
			RequestDispatcher view = request.getRequestDispatcher("/pages/memberView.jsp");
			view.forward(request, response);
		}
		else if(action.equalsIgnoreCase("listByProjectID")) {
			forward = LIST;
			//projectID kene pass based on session nnti
			request.setAttribute("users",UserDAO.getAllUsersByProjectID(1));
			request.setAttribute("project",ProjectDAO.getProjectByID(1));
			RequestDispatcher view = request.getRequestDispatcher("/pages/memberView.jsp");
			view.forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
