	package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Task;

import java.io.IOException;

import dao.ProjectDAO;
import dao.TaskDAO;

/**
 * Servlet implementation class TaskController
 */
@WebServlet("/TaskController")
public class TaskController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	private int taskID;
	private static String LIST = "task/listOfTasks.jsp";
	private static String VIEW = "task/viewTask.jsp";
	private static String UPDATE = "task/updateTask.jsp";
	private static String ADD = "task/addTask.jsp";
	private static String LISTALL = "task/listAll.jsp";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TaskController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		
		if(action.equalsIgnoreCase("listTask")) {
//		    int projectID = Integer.parseInt(request.getParameter("projectID")); // Correctly retrieve projectID
			int projectID = 2;
		    forward = LIST;
			request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID));
		}
		
		if(action.equalsIgnoreCase("listAll")) {
			forward = LISTALL;
			request.setAttribute("tasks", TaskDAO.getProjectTasks());
		}
		
		if(action.equalsIgnoreCase("viewTask")) {
			forward = VIEW;
			taskID = Integer.parseInt(request.getParameter("taskID"));
			request.setAttribute("task", TaskDAO.getTaskByID(taskID));
		}
		
		if(action.equalsIgnoreCase("updateTask")) {
			forward = UPDATE;
			Task task = new Task();
			taskID = Integer.parseInt(request.getParameter("taskID"));
			task = TaskDAO.getTaskByID(taskID);
			request.setAttribute("selectedProject", task.getProjectID());
			request.setAttribute("task", TaskDAO.getTasksByProjectID(taskID));
			request.setAttribute("projects", TaskDAO.getAllTasks());
		}
		
		if(action.equalsIgnoreCase("addTask")) {
			forward = ADD;
//			request.setAttribute("projects", ProjectDAO.addTask(task));
		}
		
		view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Task task = new Task();
		task.setTaskName(request.getParameter("taskName"));
		task.setTaskName(request.getParameter("taskName"));
		task.setDescription(request.getParameter("description"));
		task.setStartDate(request.getParameter("startDate"));
		task.setEndDate(request.getParameter("endDate"));
		task.setTaskStatus(request.getParameter("taskStatus"));
		task.setProjectID(Integer.parseInt(request.getParameter("projectID")));

		String taskID = request.getParameter("taskID");

		if(taskID == null || taskID.isEmpty()) {
			TaskDAO.addTask(task);
		}

		request.setAttribute("tasks", TaskDAO.getAllTasks());
		view = request.getRequestDispatcher(LIST);
		view.forward(request, response);
	}

}
