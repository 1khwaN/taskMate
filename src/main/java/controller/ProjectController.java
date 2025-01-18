package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.ProjectDAO;
import dao.TaskDAO;
import model.Project;

/**
 * Servlet implementation class ProjectController
 */
@WebServlet("/ProjectController")
public class ProjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	private int projectID;
	private static String LIST = "/taskMate/project/listOfProjects.jsp";
	private static String UPDATE = "/taskMate/project/updateProject.jsp";
	private static String VIEW = "/taskMate/project/viewProject.jsp";
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
//		
//		if(action.equalsIgnoreCase("deleteProject")) {
//			forward = LIST;
//			int projectID = Integer.parseInt(request.getParameter("projectID"));
//			ProjectDAO.deleteProject(projectID);
//			request.setAttribute("project", ProjectDAO.getProjectByID(projectID));
//		}
		

		if(action.equalsIgnoreCase("delete")) {
			forward = LIST;
			int projectID = Integer.parseInt(request.getParameter("projectID"));
			ProjectDAO.deleteProject(projectID);
			List <Project> projects = ProjectDAO.getAllProject();
			request.setAttribute("projects", projects);
		}

//		if(action.equalsIgnoreCase("addProduct")) {
//			forward = ADD;
//			request.setAttribute("projects", ProjectDAO.getAllProject());
//		}

		view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Project project = new Project();
		project.setProjectID(Integer.parseInt(request.getParameter("projectID")));
		project.setProjectName(request.getParameter("projectName"));
		project.setDescription(request.getParameter("description"));
		project.setStartDate(request.getParameter("startDate"));
		project.setEndDate(request.getParameter("endDate"));
		project.setProjectStatus(request.getParameter("projectStatus"));
		project.setProjectPriority(request.getParameter("projectPriority"));

		String projectID = request.getParameter("projectID");

		if(projectID == null || projectID.isEmpty()) {
			ProjectDAO.addProject(project);
		} else {
			ProjectDAO.updateProject(project);
		}

		//		request.setAttribute("project", projectDAO.get);
		view = request.getRequestDispatcher(LIST);
		view.forward(request, response);
	}

}
