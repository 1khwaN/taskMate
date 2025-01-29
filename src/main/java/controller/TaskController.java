package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
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
		    int projectID = Integer.parseInt(request.getParameter("projectID"));
		    forward = LIST;
			request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID));
		    String projectName = ProjectDAO.getProjectByID(projectID).getProjectName();
		    System.out.println("Project Name: " + projectName);
		    request.setAttribute("projectName", projectName);
		    forward = "task/listOfTasks.jsp";
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
			taskID = Integer.parseInt(request.getParameter("taskID"));
			request.setAttribute("task", TaskDAO.getTaskByID(taskID));
		}
		
		if (action.equalsIgnoreCase("deleteTask")) {
			try {
				forward = LIST;
				String taskIDParam = request.getParameter("taskID");
		        System.out.println("Received taskID: " + taskIDParam); // Debug the received projectID
		        
		        if (taskIDParam != null && !taskIDParam.isEmpty()) {
		        	taskID = Integer.parseInt(taskIDParam);
		        	TaskDAO.deleteTask(taskID);
		            System.out.println("Deleted task with ID: " + taskID); // Debug success
		        } else {
		            System.out.println("Invalid taskID received");
		        }
		        
		        request.setAttribute("tasks", TaskDAO.getTasksByProjectID(taskID));
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
	    Task task = new Task();
	    
	    task.setTaskName(request.getParameter("taskName"));
	    task.setDescription(request.getParameter("description"));
	    task.setStartDate(request.getParameter("startDate"));
	    task.setEndDate(request.getParameter("endDate"));
	    task.setTaskStatus(request.getParameter("taskStatus"));

	    // Get the projectID from the form submission
	    String projectIdParam = request.getParameter("projectID");
	    System.out.println("Received projectID: " + projectIdParam); // Debugging output

	    if (projectIdParam == null || projectIdParam.trim().isEmpty()) {
	        throw new IllegalArgumentException("Project ID is missing or invalid.");
	    }

	    int projectID = Integer.parseInt(projectIdParam);
	    task.setProjectID(projectID);

	    // Add task to the database
	    String taskID = request.getParameter("taskID");
		
		if(taskID != null && !taskID.isEmpty()) {
			task.setTaskID(Integer.parseInt(taskID));
			try {
				TaskDAO.updateTask(task);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			TaskDAO.addTask(task);
		}
	    // Forward to list of tasks page for the given project
	    forward = LIST;
	    request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID));
	    String projectName = ProjectDAO.getProjectByID(projectID).getProjectName();
	    System.out.println("Project for " + projectName);  // Debugging print to verify if projectName is retrieved
	    request.setAttribute("projectName", projectName); 
	    view = request.getRequestDispatcher("/task/listOfTasks.jsp"); 
	    view.forward(request, response);
	}

}
