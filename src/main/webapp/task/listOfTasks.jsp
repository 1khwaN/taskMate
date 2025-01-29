<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Task Management System</title>
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
				<h1 class="title">Project: ${projectName}</h1>
				<br>
				<div class="buttons-container">

					<%-- <button class="btn btn-danger" id="delete-project-<c:out value="${project.projectID}"/>"
						onclick="confirmation(<c:out value="${project.projectID}"/>)">Delete</button> --%>

					<button id="update-task-cta" class="button regular-button green-background"
						onclick="window.location.href='ProjectController?action=updateProject&projectID=${project.projectID}';">Update Project
					</button>
					
					<c:set var="projectID" value="${param.projectID}" />
					<button id="add-task-cta" class="button regular-button blue-background"
					    onclick="window.location.href='/taskMate/task/addTask.jsp?projectID=${projectID}';">
					    Add task
					</button>

					<button class="sign-out-cta" class="button regular-button red-background"
						onclick="window.location.href='login.jsp';">
						Log out
					</button>
		            </button>
				</div>
			</div>
		</div>
		
		
	<div class="radio-buttons-container">
        <div class="max-width-container flex">
          <!-- List -->
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
                icon="material-symbols:format-list-bulleted-rounded"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Projects List</span>
            </label>
          </div>
          
          <!-- List -->
          <div class="radio-container">
            <input
              type="radio"
              id="list"
              name="view-option"
              value="list"
              class="radio-input"
              checked
            />
            <label for="list" class="radio-label">
              <iconify-icon
                icon="material-symbols:format-list-bulleted-rounded"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Tasks List</span>
            </label>
          </div>
        </div>
      </div>
		
		
		

		<!-- Check if tasks is null or empty -->
		<c:if test="${empty tasks}">
		    <h3>No tasks added yet</h3>
		</c:if>
		
		<!-- Board View: Display tasks if present -->
		<c:if test="${not empty tasks}">
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
					            			<p class="task-due-date"><c:out value="${task.endDate}"/></p>
										</div>
							            <!-- delete icon -->
							           	<a href="/taskMate/TaskController?action=deleteTask&taskID=<c:out value='${task.taskID}'/>">
							            <iconify-icon
							            	icon="icomoon-free:bin"
							            	width="16"
							            	height="16"
							            	style="cursor: pointer;"
							            	onclick="confirmation('${task.taskID}')"
										></iconify-icon>
										<!-- arrow -->
										<iconify-icon 
											icon="material-symbols:arrow-back-ios-rounded"
											style="color: black" 
											width="18" 
											height="18"
											class="arrow-icon">
										</iconify-icon>
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
				            				<p class="task-due-date"><c:out value="${task.endDate}"/></p>
										</div>
							            <!-- delete icon -->
							            <a href="/taskMate/TaskController?action=deleteTask&taskID=<c:out value='${task.taskID}'/>">
							            <iconify-icon
							            	icon="icomoon-free:bin"
							            	width="16"
							            	height="16"
							            	style="cursor: pointer;"
							            	onclick="confirmation('${task.taskID}')"
										></iconify-icon>
										<!-- arrow -->
										<iconify-icon 
											icon="material-symbols:arrow-back-ios-rounded"
											style="color: black" 
											width="18" 
											height="18"
											class="arrow-icon">
										</iconify-icon>
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
				            				<p class="task-due-date"><c:out value="${task.endDate}"/></p>
										</div>
							            <!-- delete icon -->
							            <a href="/taskMate/TaskController?action=deleteTask&taskID=<c:out value='${task.taskID}'/>">
							            <iconify-icon
							            	icon="icomoon-free:bin"
							            	width="16"
							            	height="16"
							            	style="cursor: pointer;"
							            	onclick="confirmation('${task.taskID}')"
										></iconify-icon>
										<!-- arrow -->
										<iconify-icon 
											icon="material-symbols:arrow-back-ios-rounded"
											style="color: black" 
											width="18" 
											height="18"
											class="arrow-icon">
										</iconify-icon>
									</button>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
		 	</div>
		</div>
		<!-- view task -->
		<div id="view-task-overlay" class="overlay view-task-overlay hide">
			<div class="overlay-content green-background">
	
			<!-- close button -->
				<button class="button circle-button blue-background flex justify-center items-center close-button" >
					<iconify-icon icon="material-symbols:close-rounded" style="color: black" width="26" height="26"></iconify-icon>
				</button>
	
				<c:forEach items="${tasks}" var="task">
					<h1 class="header no-margin">Task Name :</h1>
					<p class="value">${task.taskName}</p>
	
					<h1 class="header">Description</h1>
					<p class="value">${task.description}</p>
	
					<div class="flex items-center">
						<h1 class="header min-width">Due date</h1>
						<p class="value">${task.endDate}</p>
					</div>
	
					<div class="flex items-center">
						<h1 class="header min-width">Status</h1>
						<p class="value status-value">
							<span class="circle blue-background"></span><span>${task.taskStatus}</span>
						</p>
					</div>
				</c:forEach>
				<div class="control-buttons-container">
	
					<!-- edit button -->
					<button class="button circle-button pink-background flex justify-center items-center">
						<iconify-icon icon="material-symbols:edit-rounded" style="color: black" width="24"height="24"></iconify-icon>
					</button>
		
					<!-- delete button -->
					<button id="delete-task-cta" class="button circle-button pink-background flex justify-center items-center">
						<iconify-icon icon="ic:round-delete" style="color: black" width="24" height="24"></iconify-icon>
					</button>
				</div>
			</div>
		</div>
	</c:if>


   <!-- import IconifyIcon web component -->
   <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
   <!-- js -->
   <script src="${pageContext.request.contextPath}/js/main.js"></script>
   
    <script>
    function confirmation(taskID) {
    	  const userConfirmation = confirm("Are you sure you want to delete this task?");
    	  
    	  if (userConfirmation) {
    	    const deleteURL = `/taskMate/TaskController?action=deleteTask&taskID=${taskID}`;
    	    console.log("Delete URL:", deleteURL); // Debug the URL
    	    fetch(deleteURL, {
    	      method: "GET",
    	    })
    	      .then(response => {
    	        if (response.ok) {
    	          alert("Task successfully deleted");
    	          // Optionally reload the page to refresh the task list
    	          location.reload();
    	        } else {
    	          alert("Failed to delete the task. Please try again.");
    	        }
    	      })
    	      .catch(error => {
    	        console.error("Error deleting task:", error);
    	        alert("An error occurred while deleting the task.");
    	      });
    	  }
    	}
</script>

</body>
</html>