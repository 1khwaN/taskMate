package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import supplier.dao.ProductDAO;
import supplier.dao.SupplierDAO;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import dao.ProjectDAO;
import dao.UserDAO;

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	private static String VIEW ="/pages/accProfile.jsp";
	private static String LIST ="/pages/memberView.jsp";
	private static String UPDATE ="updateRegister.jsp";
	private int id;

	public UserController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer loggedInUserID = (Integer) request.getSession().getAttribute("userID");

		action = request.getParameter("action");
		
		//view all users
		if(action.equalsIgnoreCase("list")) {
			forward = LIST;

			request.setAttribute("users",UserDAO.getAllUsers());
			
		}
		//view list of project members
		if(action.equalsIgnoreCase("listByProjectID")) {
			forward = LIST;
			
			//projectID kene pass based on session nnti
			request.setAttribute("users",UserDAO.getAllUsersByProjectID(1));
			request.setAttribute("project",ProjectDAO.getProjectByID(1));
//			request.setAttribute("users", UserDAO.getAllUsers());
			
		}
		//delete User
		if(action.equalsIgnoreCase("deleteUser")) {
			forward = LIST;
			
			id = Integer.parseInt(request.getParameter("userID")); 
//			int projectId = Integer.parseInt(request.getParameter("projectID"));
			try {
				UserDAO.deleteUser(id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			/* yang nie nak kene tengok dulu, pakai session or retrieve from view
			 * request.setAttribute("users", UserDAO.getAllUsersByProjectID(projectId));
			 */			
			request.setAttribute("users",UserDAO.getAllUsersByProjectID(1));
			request.setAttribute("project",ProjectDAO.getProjectByID(1));
		}
		//insert User by projectID
		if(action.equalsIgnoreCase("insertProjectMember")) {
			forward = LIST;
			//parse projectID
			request.setAttribute("users",UserDAO.getAllUsersByProjectID(1));
		}
		//view User Profile
		if(action.equalsIgnoreCase("viewUser")) { 
			forward = VIEW;
			//parse userID
//			id = Integer.parseInt(request.getParameter("userID")); 
	        request.setAttribute("user", UserDAO.getUser(loggedInUserID));
		}
		view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
//		user.setUserName(request.getParameter("userName"));
//		user.setEmail(request.getParameter("email"));
//		user.setPassword(request.getParameter("password"));
//		user.setTypeID(Integer.parseInt(request.getParameter("typeID")));
		
		String userID = request.getParameter("userID");
		
		if(userID == null || userID.isEmpty()) {
			int projectID = Integer.parseInt(request.getParameter("projectID"));
			user.setUserName(request.getParameter("userName"));
			user.setEmail(request.getParameter("email"));
			user.setPassword(request.getParameter("password"));
			user.setTypeID(Integer.parseInt(request.getParameter("typeID")));
			try {
				UserDAO.insertProjectMember(user, projectID);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		}
		else {
			user.setUserName(request.getParameter("userName"));
			user.setEmail(request.getParameter("email"));
			user.setPassword(request.getParameter("password"));
			user.setUserID(Integer.parseInt(userID));
			try {
				UserDAO.updateUser(user);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		}
		//parse projectID
		request.setAttribute("users",UserDAO.getAllUsersByProjectID(1));
	    view = request.getRequestDispatcher(LIST);
        view.forward(request, response);
	}

}
