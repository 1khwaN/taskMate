<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.addHeader("Cache-Control", "pre-check=0, post-check=0");
	response.setDateHeader("Expires", 0);
	
	%> 
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/listView.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    
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
          <h1 class="title">Projects</h1>
          <br>
          <div class="buttons-container">
          
          	<button
                id="profile-button"
                class="button icon-button"
                onclick="window.location.href='pages/accProfile.jsp';"
            >
                <img src="/taskMate/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
            </button>
          
            <button
              id="add-project-cta"
              class="button regular-button green-background"
              onclick="window.location.href='project/addProject.jsp';"
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
        
          <!-- List -->
          <div class="radio-container">
            <input
              type="radio"
              id="list"
              name="view-option"
              value="list"
              class="radio-input"
              checked
              onclick=""
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
          
          <!--Members-->
          <c:if test="${sessionScope.sessionTypeID == 1}">
	        <div class="radio-container">
            <input
              type="radio"
              id="members"
              name="view-option"
              value="members"
              class="radio-input"
              
              onclick="window.location.href='/taskMate/UserController?action=listByProjectID';"
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
          </c:if>
        </div>
      </div>
      
      
 
	 <!-- list view -->
	 <div id="list-view" class="list-view">
	    <div class="list-container pink">      
	  		<h2 class="list-header">
	    		<span class="circle pink-background"></span>
	    		<span class="text">To Do</span>
	  		</h2>
	  		<ul class="tasks-list">
	    		<c:forEach items="${projects}" var="project">
	      			<c:if test="${project.projectStatus == 'To Do'}">
	        			<li class="task-item">
	          				<button class="task-button">
	            				<p class="task-name"><c:out value="${project.projectName}"/></p>
	            				<p class="task-due-date"><c:out value="${project.endDate}"/></p>
	            				<div class="icon-container">
		            				<!-- view -->
		            				<iconify-icon 
		            					icon="mi:eye" 
		            					width="24" 
		            					height="24"
										onclick="window.location.href='/taskMate/ProjectController?action=viewProject&projectID=<c:out value='${project.projectID}'/>'">
		            				></iconify-icon>
						            <!-- delete icon -->
						            <iconify-icon
						            	icon="icomoon-free:bin"
						            	width="16"
						            	height="16"
						            	style="cursor: pointer;"
						            	href="#" onclick="confirmation(event, '${project.projectID}')">
									></iconify-icon>
		            				<!-- arrow -->
		            				<iconify-icon
		              					icon="ep:arrow-right-bold"
		              					style="color: black"
		              					width="18"
		              					height="18"
		              					class="arrow-icon"
										onclick="window.location.href='/taskMate/TaskController?action=listTask&projectID=<c:out value='${project.projectID}'/>'">
		            				></iconify-icon>
	            				</div>
	          				</button>
	        			</li>
	      			</c:if>
	    		</c:forEach>
	  		</ul>
		</div>
	
		<div class="list-container blue">      
	  		<h2 class="list-header">
	    		<span class="circle blue-background"></span>
	    		<span class="text">Doing</span>
	  		</h2>
	  		<ul class="tasks-list">
	    		<c:forEach items="${projects}" var="project">
	      			<c:if test="${project.projectStatus == 'Doing'}">
	        			<li class="task-item">
	          				<button class="task-button">
	            				<p class="task-name"><c:out value="${project.projectName}"/></p>
	            				<p class="task-due-date"><c:out value="${project.endDate}"/></p>
	            				<div class="icon-container">
	            				<!-- view -->
	            				<iconify-icon 
	            					icon="mi:eye" 
	            					width="24" 
	            					height="24"
	            					onclick="window.location.href='/taskMate/ProjectController?action=viewProject&projectID=<c:out value='${project.projectID}'/>'">
	            				></iconify-icon>
					            <!-- delete icon -->
					            <iconify-icon
					            	icon="icomoon-free:bin"
					            	width="16"
					            	height="16"
					            	style="cursor: pointer;"
					            	href="#" onclick="confirmation(event, '${project.projectID}')">
								></iconify-icon>
	            				<!-- arrow -->
	            				<iconify-icon
	              					icon="ep:arrow-right-bold"
	              					style="color: black"
	              					width="18"
	              					height="18"
	              					class="arrow-icon"
									onclick="window.location.href='/taskMate/TaskController?action=listTask&projectID=<c:out value='${project.projectID}'/>'">
	            				></iconify-icon>
	            				</div>
	          				</button>
	        			</li>
	      			</c:if>
	    		</c:forEach>
	  		</ul>
		</div>
	
		<div class="list-container green">      
	  		<h2 class="list-header">
	    		<span class="circle green-background"></span>
	    		<span class="text">Done</span>
	  		</h2>
	  		<ul class="tasks-list">
	    		<c:forEach items="${projects}" var="project">
	      			<c:if test="${project.projectStatus == 'Done'}">
	        			<li class="task-item">
	          				<button class="task-button">
	            				<p class="task-name"><c:out value="${project.projectName}"/></p>
	            				<p class="task-due-date"><c:out value="${project.endDate}"/></p>
	            				<div class="icon-container">
	            				<!-- view -->
	            				<iconify-icon 
	            					icon="mi:eye" 
	            					width="24" 
	            					height="24"
									onclick="window.location.href='/taskMate/ProjectController?action=viewProject&projectID=<c:out value='${project.projectID}'/>'">
	            				></iconify-icon>
					            <!-- delete icon -->
								<a href="/taskMate/TaskController?action=deleteTask&taskID=<c:out value='${task.taskID}'/>">
					            <iconify-icon
					            	icon="icomoon-free:bin"
					            	width="16"
					            	height="16"
					            	style="cursor: pointer;"
					            	href="#" onclick="confirmation(event, '${project.projectID}')">
								></iconify-icon></a>
	            				<!-- arrow -->
	            				<iconify-icon
	              					icon="ep:arrow-right-bold"
	              					style="color: black"
	              					width="18"
	              					height="18"
	              					class="arrow-icon"
									onclick="window.location.href='/taskMate/TaskController?action=listTask&projectID=<c:out value='${project.projectID}'/>'">
	            				></iconify-icon>
	            				</div>
	          				</button>
	        			</li>
	      			</c:if>
	    		</c:forEach>
	  		</ul>
		</div>
	</div>
</div>

   <!-- import IconifyIcon web component -->
   <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
   <!-- js -->
   <script src="${pageContext.request.contextPath}/js/main.js"></script>

	<script>
	function confirmation(event, projectID) {
	    event.preventDefault(); // Stop the default link action
	    if (confirm("Are you sure you want to delete this project?")) {
	        window.location.href = "/taskMate/ProjectController?action=deleteProject&projectID=" + projectID;
	    }
	}
	</script>
 </body>
</html>