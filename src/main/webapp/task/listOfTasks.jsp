<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.addHeader("Cache-Control", "pre-check=0, post-check=0");
	response.setDateHeader("Expires", 0);
	if(session.getAttribute("sessionEmail")==null)
	{
		response.sendRedirect("pages/login.jsp");
	}
	%> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>List Tasks - Task Management System</title>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    
  </head>
	<body>
	<!-- Because body has height 100%, we need a container to wrap the individual elements. The purpose is to add top & bottom padding -->
	<div class="content-container">
		<!-- success notification -->
		<div id="notification" class="notification green-background">
			<iconify-icon icon="mdi:check-circle-outline" style="color: black" width="24" height="24"> </iconify-icon>
			<p>The task was deleted</p>
		</div>
		<!-- header -->
		<div class="max-width-container">
			<div class="header flex items-center justify-between">
          		<h1 class="title">Welcome to TaskMate System!</h1>
				<br>
				<div class="buttons-container">

				<button
                id="profile-button"
                class="button icon-button"
                onclick="window.location.href='/taskMate/UserController?action=viewUser';"
            >
                <img src="/taskMate/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
            	</button>
					<c:if test="${sessionScope.sessionTypeID == 1}">
					<button class="button regular-button green-background"
					    onclick="confirmDeleteAll(<c:out value='${param.projectID}' />)">
					    Delete All Tasks
					</button>
					</c:if>
					<c:set var="projectID" value="${param.projectID}" />
					<button id="add-task-cta" class="button regular-button blue-background"
					    onclick="window.location.href='/taskMate/TaskController?action=addMember&projectID=${projectID}';">
					    Add task
					</button>

					<button class="sign-out-cta button regular-button red-background" onclick="confirmLogout();">
					    Log out
					</button>
				</div>
			</div>
		</div>
		
		
	<div class="radio-buttons-container">
        <div class="max-width-container flex">
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
          
          <c:if test="${sessionScope.sessionTypeID == 1}">
          <div class="radio-container">
            <input
              type="radio"
              id="list"
              name="view-option"
              value="list"
              class="radio-input"
              checked
              onclick="window.location.href='/taskMate/ProjectController?action=listProject';"
            />
            <label for="list" class="radio-label">
              <iconify-icon
              icon="ic:round-grid-view"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Projects</span>
            </label>
          </div>
          </c:if>
          
          <c:if test="${sessionScope.sessionTypeID == 2}">
          <div class="radio-container">
            <input
              type="radio"
              id="list"
              name="view-option"
              value="list"
              class="radio-input"
              checked
              onclick="window.location.href='/taskMate/TaskController?action=listTask&projectID=<c:out value='${sessionScope.projectID}'/>';"
            />
            <label for="list" class="radio-label">
              <iconify-icon
                icon="material-symbols:format-list-bulleted-rounded"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>List of Tasks</span>
            </label>
          </div>
          </c:if>
          
          
          <!-- List -->
           <c:if test="${sessionScope.sessionTypeID == 1}">
	        <div class="radio-container">
            <input
              type="radio"
              id="members"
              name="view-option"
              value="members"
              class="radio-input"
              
            onclick="window.location.href='/taskMate/ProjectController?action=listProjectMembers';"
            />
            
            <label for="members" class="radio-label">
              <!-- grid -->
              <iconify-icon
                icon="ic:round-grid-view"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Members</span>
            </label>
          </div>
          </c:if>
        </div>
      </div>
		
		<!-- Check if tasks is null or empty -->
		<c:if test="${empty tasks}">
			<div class="centered-container">
				<h3>⋆˚𝜗𝜚˚⋆ Project : ${projectName}</h3>
		    </div><br>
			<div class="centered-container">
		    	<h4><i>No tasks added yet</i></h4>
		    </div>
		</c:if>
		
		<!-- Board View: Display tasks if present -->
		<c:if test="${not empty tasks}">
		<div class="centered-container">
				<h3>⋆˚𝜗𝜚˚⋆ Project : ${projectName}</h3>
				</div>
			<!-- board view -->
			<div id="board-view" class="board-view">
				<!-- list -->
				<div>
					<h2 class="list-header">
						<span class="circle pink-background"></span><span class="text">To do</span>
					</h2>
					<ul class="tasks-list pink">
						<c:forEach items="${tasks}" var="task">
							<c:if test="${task.taskStatus == 'To Do'}">
								<li class="task-item">
									<button class="task-button">
										<div>
					            			<p class="task-name"><c:out value="${task.taskName}"/></p>
					            			<p class="task-due-date">Due Date : <c:out value="${task.endDate}"/></p>
										</div>
							            <div class="icon-container">
							            <!-- delete icon -->
							            <c:if test="${sessionScope.sessionTypeID == 1}">
								            <iconify-icon
								            	icon="icomoon-free:bin"
								            	width="16"
								            	height="16"
								            	style="cursor: pointer;"
								            	onclick="confirmDelete(event, '${task.taskID}', '${param.projectID}')">
								            </iconify-icon>
								            </c:if>
				            				<!-- view -->
											<iconify-icon 
												icon="ep:arrow-right-bold"
												style="color: black" 
												width="18" 
												height="18"
												class="arrow-icon"
												onclick="window.location.href='/taskMate/TaskController?action=viewTask&taskID=<c:out value="${task.taskID}"/>&projectID=<c:out value="${param.projectID}"/>'">
											</iconify-icon>
										</div>
									</button>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
	
				<!-- list -->
				<div>
					<h2 class="list-header">
						<span class="circle blue-background"></span><span class="text">Doing</span>
					</h2>
					<ul class="tasks-list blue">
						<c:forEach items="${tasks}" var="task">
							<c:if test="${task.taskStatus == 'Doing'}">
								<li class="task-item">
									<button class="task-button">
										<div>
				            				<p class="task-name"><c:out value="${task.taskName}"/></p>
				            				<p class="task-due-date">Due Date : <c:out value="${task.endDate}"/></p>
										</div>
							            <div class="icon-container">
							            <!-- delete icon -->
							            <c:if test="${sessionScope.sessionTypeID == 1}">
								            <iconify-icon
								            	icon="icomoon-free:bin"
								            	width="16"
								            	height="16"
								            	style="cursor: pointer;"
								            	onclick="confirmDelete(event, '${task.taskID}', '${param.projectID}')">
								            </iconify-icon>
								            </c:if>
				            				<!-- view -->
											<iconify-icon 
												icon="ep:arrow-right-bold"
												style="color: black" 
												width="18" 
												height="18"
												class="arrow-icon"
												onclick="window.location.href='/taskMate/TaskController?action=viewTask&taskID=<c:out value="${task.taskID}"/>&projectID=<c:out value="${param.projectID}"/>'">
											</iconify-icon>
										</div>
									</button>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			    <!-- list -->
			    <div>
					<h2 class="list-header">
						<span class="circle green-background"></span><span class="text">Done</span>
					</h2>
					<ul class="tasks-list green">
						<c:forEach items="${tasks}" var="task">
							<c:if test="${task.taskStatus == 'Done'}">
								<li class="task-item">
									<button class="task-button">
										<div>
				            				<p class="task-name"><c:out value="${task.taskName}"/></p>
				            				<p class="task-due-date">Due Date : <c:out value="${task.endDate}"/></p>
										</div>
							            <div class="icon-container">
							            <!-- delete icon -->
											<!-- <iconify-icon
											    icon="icomoon-free:bin"
											    width="16"
											    height="16"
											    style="cursor: pointer;"
											    href="#"
											    onclick="confirmation(event, '${task.taskID}', '${projectID}')">
											</iconify-icon> -->
											<c:if test="${sessionScope.sessionTypeID == 1}">
								            <iconify-icon
								            	icon="icomoon-free:bin"
								            	width="16"
								            	height="16"
								            	style="cursor: pointer;"
								            	onclick="confirmDelete(event, '${task.taskID}', '${param.projectID}')">
								            </iconify-icon>
								            </c:if>
				            				<!-- view -->
											<iconify-icon 
												icon="ep:arrow-right-bold"
												style="color: black" 
												width="18" 
												height="18"
												class="arrow-icon"
												onclick="window.location.href='/taskMate/TaskController?action=viewTask&taskID=<c:out value="${task.taskID}"/>&projectID=<c:out value="${param.projectID}"/>'">
											</iconify-icon>
										</div>
									</button>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
		 	</div>
		</div>
	</c:if>

   <!-- import IconifyIcon web component -->
   <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
   <!-- js -->
   <script src="${pageContext.request.contextPath}/js/main.js"></script>
   
<%-- <c:set var="projectID" value="${project.projectID}" /> --%>

	<script>
	function confirmDelete(event, taskID, projectID) {
	    event.preventDefault(); // Stop the default link action

	    Swal.fire({
	        title: "Are you sure?",
	        text: "You are about to delete this task. This action cannot be undone.",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#d33",
	        cancelButtonColor: "#3085d6",
	        confirmButtonText: "Yes, delete it!",
	        cancelButtonText: "Cancel"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            console.log("Deleting task with ID:", taskID);
	            window.location.href = "/taskMate/TaskController?action=deleteTask&taskID=" + taskID + "&projectID=" + projectID;
	        }
	    });
	}

	function confirmDeleteAll(projectID) {
	    Swal.fire({
	        title: "Are you sure?",
	        text: "You are about to delete all tasks in this project. This action cannot be undone.",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#d33",
	        cancelButtonColor: "#3085d6",
	        confirmButtonText: "Yes, delete all!",
	        cancelButtonText: "Cancel"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            console.log("Deleting all tasks for project:", projectID);
	            window.location.href = "/taskMate/TaskController?action=deleteAllTasks&projectID=" + projectID;
	        }
	    });
	}

</script>
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	    function confirmLogout() {
	        Swal.fire({
	            title: "Are you sure?",
	            text: "You will be logged out of the system.",
	            icon: "warning",
	            showCancelButton: true,
	            confirmButtonColor: "#d33",
	            cancelButtonColor: "#3085d6",
	            confirmButtonText: "Yes, log me out!",
	            cancelButtonText: "Cancel"
	        }).then((result) => {
	            if (result.isConfirmed) {
	                window.location.href = "/taskMate/LogoutController";
	            }
	        });
	    }
	</script>
	
</body>
</html>