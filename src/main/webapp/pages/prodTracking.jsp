<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Task Management System - Dashboard</title>
    <!-- google font: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prodTrack.css" />
    
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
	<%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.addHeader("Cache-Control", "pre-check=0, post-check=0");
	response.setDateHeader("Expires", 0);
	
	%> 
  </head>
  <body>
    <!-- Because body has height 100%, we need a container to wrap the individual 
    elements. The purpose is to add top & bottom padding -->
    <div class="content-container">
      <!-- success notification -->
      <div id="notification" class="notification green-background">
        <iconify-icon
          icon="mdi:check-circle-outline"
          style="color: black"
          width="24"
          height="24"
        ></iconify-icon>
        <p>The task was deleted</p>
      </div>
      <!-- header -->
      <div class="max-width-container">
        <div class="header flex items-center justify-between">
          <h1 class="title">Welcome to TaskMate System!</h1>
          <br>
          <div class="buttons-container">
            <!-- New Profile Button -->
            <button
                id="profile-button"
                class="button icon-button"
                onclick="window.location.href='pages/accProfile.jsp';"
            >
                <img src="/taskMate/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
            </button>

            <button
              id="add-task-cta"
              class="button regular-button blue-background"
              onclick="window.location.href='pages/addTask.jsp';"
            >
              Add task
            </button>
            
            <button
              id="add-task-cta"
              class="button regular-button blue-background"
              onclick="window.location.href='/taskMate/ProjectController?action=listProject';"
            >
              View Project
            </button>
            <button
              id="add-project-cta"
              class="button regular-button green-background"
              onclick="window.location.href='/taskMate/project/addProject.jsp';"
            >
              Add Project
            </button>
            <button class="sign-out-cta"
            class="button regular-button red-background"
            onclick="window.location.href='/taskMate/LogoutController';"
            >
            Log out
            	
            
            </button>
          </div>
        </div>
      </div>
      <div class="radio-buttons-container">
        <div class="max-width-container flex">
          <!-- Productivity Tracking -->
          <div class="radio-container">
            <input
              type="radio"
              id="track"
              name="view-option"
              value="track"
              class="radio-input"
              checked
              onclick="window.location.href='/taskMate/prodTrackingController';"
              
            />
            <label for="track" class="radio-label">
              <iconify-icon
                icon="mdi:chart-line"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Productivity Tracking</span>
            </label>
          </div>
      
          <!-- <!-- List
          <div class="radio-container">
            <input
              type="radio"
              id="list"
              name="view-option"
              value="list"
              class="radio-input"
              
              onclick="window.location.href='listView.jsp';"
            />
            <label for="list" class="radio-label">
              <iconify-icon
                icon="material-symbols:format-list-bulleted-rounded"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>List</span>
            </label>
          </div> --> 
      
          <!-- Board -->
          <div class="radio-container">
            <input
              type="radio"
              id="board"
              name="view-option"
              value="board"
              class="radio-input"
              
              onclick="window.location.href='/taskMate/ProjectController?action=listProject';"
            />
            <label for="board" class="radio-label">
              <iconify-icon
                icon="ic:round-grid-view"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Projects</span>
            </label>
          </div>
          
          <!--Members-->
	        <div class="radio-container">
            <input
              type="radio"
              id="members"
              name="view-option"
              value="members"
              class="radio-input"
              
              onclick="window.location.href='pages/memberView.jsp';"
            />
            <label for="members" class="radio-label">
              <!-- grid -->
              <iconify-icon
                icon="tdesign:member-filled"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Members</span>
            </label>
          </div>
        </div>
      </div>
     </div>
    
    <!-- Productivity Charts -->
    

<div class="prod-Container" style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;">
<%
    int userRole = (int) session.getAttribute("role"); // Assume role is stored in the session
    String taskStatuses = (String) request.getAttribute("taskStatuses");
    String taskCounts = (String) request.getAttribute("taskCounts");
    String projectStatuses = (String) request.getAttribute("projectStatuses");
    String projectCounts = (String) request.getAttribute("projectCounts");

    // Debugging in JSP
    System.out.println("User Role: " + userRole);
    System.out.println("Task Statuses: " + taskStatuses);
    System.out.println("Task Counts: " + taskCounts);
    System.out.println("Project Statuses: " + projectStatuses);
    System.out.println("Project Counts: " + projectCounts);
%>


    <!-- Display charts based on user role -->
    <% if (userRole == 2) { %> <!-- Member -->
        <!-- Stacked Bar Chart -->
        <div class="chart-frame">
            <canvas id="stackedBarChart"></canvas>
        </div>
    <% } else if (userRole == 1) { %> <!-- Project Manager -->
        <!-- Stacked Bar Chart -->
        <div class="chart-frame">
            <canvas id="stackedBarChart"></canvas>
        </div>
        <!-- Pie Chart -->
        <div class="chart-frame">
            <canvas id="pieChart"></canvas>
        </div>
    <% } %>
</div>

<script>
    // Pass data from servlet to JavaScript
    const taskStatuses = ${taskStatuses}; // Example: ["To Do", "Doing", "Done"]
    const taskCounts = ${taskCounts}; // Example: [5, 3, 7]

    <% if (userRole == 1) { %> 
    const projectStatuses = ${projectStatuses}; // Example: ["Ongoing", "Completed", "Pending"]
    const projectCounts = ${projectCounts}; // Example: [2, 4, 1]
    <% } %>

    // Render the stacked bar chart for tasks
    new Chart("stackedBarChart", {
        type: "bar",
        data: {
            labels: taskStatuses,
            datasets: [{
                label: "User Tasks",
                backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56"],
                data: taskCounts
            }]
        },
        options: {
            indexAxis: 'x',
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: "Task Distribution by Status"
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.dataset.label + ": " + context.raw;
                        }
                    }
                }
            },
            scales: {
                x: { stacked: true },
                y: { 
                    stacked: true,
                    beginAtZero: true 
                }
            }
        }
    });

    <% if (userRole == 1) { %>
    // Render the pie chart for projects (only for project managers)
    new Chart("pieChart", {
        type: "pie",
        data: {
            labels: projectStatuses,
            datasets: [{
                label: "Projects by Status",
                backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56"],
                data: projectCounts
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: "Projects by Status"
                }
            }
        }
    });
    <% } %>
</script>



        
    <!-- import IconifyIcon web component -->
    <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
    <!-- js -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
  </body>
</html>