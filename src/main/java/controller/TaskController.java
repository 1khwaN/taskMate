package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Task;
import model.User;

import java.io.IOException;
import java.util.List;

import dao.ProjectDAO;
import dao.TaskDAO;
import dao.UserDAO;

/**
 * Servlet implementation class TaskController
 */
//@WebServlet("/TaskController")
public class TaskController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	private int taskID;
	private static String LIST = "task/listOfTasks.jsp";
	private static String VIEW = "task/viewTask.jsp";
	private static String UPDATE = "task/updateTask.jsp";
	private static String ADD = "/task/addTask.jsp";
	private static String LISTALL = "/task/listAll.jsp";
       
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
		        System.out.println("Received taskID: " + taskIDParam); // Debugging

		        if (taskIDParam != null && !taskIDParam.isEmpty()) {
		            taskID = Integer.parseInt(taskIDParam);
		            
		            // Get projectID before deleting task
		            Task task = TaskDAO.getTaskByID(taskID);
		            if (task != null) {
		                int projectID = task.getProjectID(); // Save projectID
		                
		                // Delete the task
		                TaskDAO.deleteTask(taskID);
		                System.out.println("Deleted task with ID: " + taskID); // Debugging
		                
		                // Fetch updated tasks for the project
		                request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID));
		                request.setAttribute("projectName", ProjectDAO.getProjectByID(projectID).getProjectName());
		                request.setAttribute("projectID", projectID);// Keep projectName
		            } else {
		                System.out.println("Task not found.");
		            }
		        } else {
		            System.out.println("Invalid taskID received");
		        }
		        
		        view = request.getRequestDispatcher(forward);
		        view.forward(request, response);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}

		
		if(action.equalsIgnoreCase("deleteAllTasks")) {
			forward = LIST;
			int projectID = Integer.parseInt(request.getParameter("projectID"));  
			TaskDAO.deleteAllTasksByProject(projectID);
			request.setAttribute("projects", TaskDAO.getTasksByProjectID(projectID));    
		}
		
		if(action.equalsIgnoreCase("addMember")) {
		    int projectID = Integer.parseInt(request.getParameter("projectID"));
		    
		    System.out.println("Project ID received in TaskController: " + projectID); // Debugging

		    forward = ADD;            
		    List<User> users = UserDAO.getAllUsersByProjectID(projectID);

		    System.out.println("Users retrieved: " + users.size()); // Debugging

		    request.setAttribute("taskMembers", users);  
		    request.setAttribute("projectID", projectID);
		}
		
		if (action.equalsIgnoreCase("deleteTask")) {
            try {
                String taskIDParam = request.getParameter("taskID");
                System.out.println("Received taskID: " + taskIDParam); // Debug the received taskID
                
                if (taskIDParam != null && !taskIDParam.isEmpty()) {
                    int taskID = Integer.parseInt(taskIDParam);
                    TaskDAO.deleteTask(taskID);
                    System.out.println("Deleted task with ID: " + taskID); // Debug success
                } else {
                    System.out.println("Invalid taskID received");
                }

                int projectID = Integer.parseInt(request.getParameter("projectID")); // Ensure we reload tasks for the correct project
                request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID));
                
                view = request.getRequestDispatcher(LIST);
                view.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        if (action.equalsIgnoreCase("deleteAllTasks")) {
            try {
                int projectID = Integer.parseInt(request.getParameter("projectID"));
                System.out.println("Received projectID for deleteAllTasks: " + projectID);
                
                TaskDAO.deleteAllTasksByProject(projectID);
                
                request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID)); // Correct attribute name
                view = request.getRequestDispatcher(LIST);
                view.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
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

	    String projectIdParam = request.getParameter("projectID");
	    if (projectIdParam == null || projectIdParam.trim().isEmpty()) {
	        throw new IllegalArgumentException("Project ID is missing or invalid.");
	    }

	    int projectID = Integer.parseInt(projectIdParam);
	    task.setProjectID(projectID);

	    // Retrieve selected userID from the dropdown
	    String userIdParam = request.getParameter("taskMember");
	    if (userIdParam == null || userIdParam.trim().isEmpty()) {
	        throw new IllegalArgumentException("User ID is missing or invalid.");
	    }
	    int userID = Integer.parseInt(userIdParam);
	    
	    int taskID;

	    // Check if taskID exists (edit mode) or add a new task
	    String taskIDParam = request.getParameter("taskID");
	    if (taskIDParam != null && !taskIDParam.isEmpty()) {
	        task.setTaskID(Integer.parseInt(taskIDParam));
	        try {
	            TaskDAO.updateTask(task);
	            taskID = task.getTaskID();
	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new ServletException("Error updating task", e);
	        }
	    } else {
	        taskID = TaskDAO.addTask(task); // Now returns the new taskID
	    }

	    // Add user to task_member table
	    TaskDAO.addTaskMember(taskID, userID);

	    // Forward to list of tasks page for the given project
	    request.setAttribute("tasks", TaskDAO.getTasksByProjectID(projectID));
	    
	    String projectName = ProjectDAO.getProjectByID(projectID).getProjectName();
	    request.setAttribute("projectName", projectName);

	    RequestDispatcher view = request.getRequestDispatcher("/task/listOfTasks.jsp");
	    view.forward(request, response);
	}


}
