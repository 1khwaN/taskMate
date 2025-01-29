package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.ProjectDAO;
import dao.TaskDAO;
import model.Project;

/**
 * Servlet implementation class ProjectController
 */
public class ProjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	private int projectID;
	private static String LIST = "/project/listOfProjects.jsp";
	private static String UPDATE = "/project/updateProject.jsp";
	private static String VIEW = "/project/viewProject.jsp";
//	private static String ADD = "/project/addProject.jsp";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProjectController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		
		//view all projects
		if(action.equalsIgnoreCase("listProject")) {
			forward = LIST;
			request.setAttribute("projects", ProjectDAO.getAllProject());
		}
		
		if (action.equalsIgnoreCase("viewProject")) {
			forward = VIEW;
			int projectID = Integer.parseInt(request.getParameter("projectID"));
			request.setAttribute("project", ProjectDAO.getProjectByID(projectID));
		} else if (action.equalsIgnoreCase("viewTasks")) {
			int projectID = Integer.parseInt(request.getParameter("projectID"));
			request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID)); // Assuming you have a TaskDAO with this method
			forward = "task/listOfTasks.jsp"; // Forward to the tasks list JSP
		}

		if(action.equalsIgnoreCase("updateProject")) {
			forward = UPDATE;
			projectID = Integer.parseInt(request.getParameter("projectID"));
			request.setAttribute("project", ProjectDAO.getProjectByID(projectID));
		}
		
		if (action.equalsIgnoreCase("deleteProject")) {
			try {
				forward = LIST;
				String projectIDParam = request.getParameter("projectID");
		        System.out.println("Received projectID: " + projectIDParam); // Debug the received projectID
		        
		        if (projectIDParam != null && !projectIDParam.isEmpty()) {
		            projectID = Integer.parseInt(projectIDParam);
		            ProjectDAO.deleteProject(projectID);
		            System.out.println("Deleted project with ID: " + projectID); // Debug success
		        } else {
		            System.out.println("Invalid projectID received");
		        }
		        
		        request.setAttribute("projects", ProjectDAO.getAllProject());
		    } catch (Exception e) {
		        e.printStackTrace(); // Log any exceptions for debugging
		    }
		}
		view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		Project project = new Project();

		project.setProjectName(request.getParameter("projectName"));
		project.setDescription(request.getParameter("description"));
		project.setStartDate(request.getParameter("startDate"));
		project.setEndDate(request.getParameter("endDate"));
		project.setProjectStatus(request.getParameter("projectStatus"));
		project.setProjectPriority(request.getParameter("projectPriority"));
		
		String projectID = request.getParameter("projectID");
		
		if(projectID != null && !projectID.isEmpty()) {
			project.setProjectID(Integer.parseInt(projectID));
			try {
				ProjectDAO.updateProject(project);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			ProjectDAO.addProject(project);
		}

		request.setAttribute("projects", ProjectDAO.getAllProject());

		forward = LIST;
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

}
