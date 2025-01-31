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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/boardView.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MembersPage.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
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
                onclick="window.location.href='/taskMate/UserController?action=viewUser';"
            >
                <img src="/taskMate/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
            </button>

			<c:if test="${sessionScope.sessionTypeID == 2}">
            <button
              id="add-task-cta"
              class="button regular-button blue-background"
              onclick="window.location.href='pages/addTask.jsp';"
            >
              Add task
            </button>
            </c:if>
            
            <button
              id="add-project-cta"
              class="button regular-button green-background"
			        onclick="window.location.href='/taskMate/project/addProject.jsp';"
            >
              Add Project
            </button>
            <button class="sign-out-cta button regular-button red-background"
			onclick="confirmLogout();"            >
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
          
          <c:if test="${sessionScope.sessionTypeID == 1}">
	        <div class="radio-container">
            <input
              type="radio"
              id="members"
              name="view-option"
              value="members"
              class="radio-input"
              checked
            onclick="window.location.href='/taskMate/ProjectController?action=listProjectMembers';"
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
     </div>
     
     <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
	<!-- js -->
	<script src="../js/main.js"></script>
	
	<c:if test="${empty users}">
			<div class="centered-container">
				<h3>⋆˚𝜗𝜚˚⋆ Project : ${project.projectName}</h3>
		    </div><br>
		   	<div class="centered-container">
					    	<h4><i>No Members added yet</i></h4>
			</div>
		    <div id="board-view" class="board-view">
		    	<div style="display: flex; align-items: center; justify-content: space-between;">
				<h2 class="list-header">
				<a class="text" href="UserController?action=listByProjectID">List of Members for ${project.projectName}</a>

				</h2>
				<button id="add-project-cta"
					class="button regular-button green-background"
					onclick="openModal('${project.projectID}')">Add Member</button>
			</div>
			<!-- Modal Structure -->
			<div id="addMemberModal" class="modal">
        		<div class="modal-content">
            		<span class="close" onclick="closeModal()">&times;</span>
            			<div id="modal-body">
                			<!-- `addMembers.jsp` will be loaded here -->
            			</div>
        		</div>
    		</div>
		    </div>
		</c:if>
				<c:if test="${not empty users}">
		
<div class="centered-container">
				<h3>⋆˚𝜗𝜚˚⋆ Project : ${project.projectName}</h3>
				</div>
	<div id="board-view" class="board-view">
		<!-- list -->
		<div style = "">
			<div style="display: flex; align-items: center; justify-content: space-between;">
				<h2 class="list-header">
				<a class="text" href="UserController?action=listByProjectID">List of Members for ${project.projectName}</a>

				</h2>
				<button id="add-project-cta"
					class="button regular-button green-background"
					onclick="openModal('${project.projectID}')">Add Member</button>
			</div>
			<!-- Modal Structure -->
			<div id="addMemberModal" class="modal">
        		<div class="modal-content">
            		<span class="close" onclick="closeModal()">&times;</span>
            			<div id="modal-body">
                			<!-- `addMembers.jsp` will be loaded here -->
            			</div>
        		</div>
    		</div>

			
			<!-- Populate List -->
			<ul class="tasks-list blue">
				<c:forEach var="user" items="${users}">
					<li class="task-item">
						<div class="task-button">
							<div class="task-button">
								<p class="task-name">Username : <c:out value="${user.userName}"/></p>
								<p class="task-due-date">Email : <c:out value="${user.email}"/></p>									
							</div>
							<input type="hidden" id="userID-${user.userID}" value="${user.userID}">
							<input type="hidden" id="userName-${user.userName}" value="${user.userName}">
							
							<!-- arrow -->
							<button
								style='background: none; border: none; cursor: pointer; padding: 0;'
								onclick="confirmation('${user.userID}','${user.userName}','${project.projectID}')">
							<iconify-icon icon="material-symbols:delete-rounded"
								style="color: red" width="30" height="30">
							</iconify-icon>
							</button>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		</c:if>
		<script>
		function confirmation(userID, userName, projectID) {					  
		    Swal.fire({
		        title: "Are you sure?",
		        text: "You are about to remove " + userName + ". This action cannot be undone.",
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#d33",
		        cancelButtonColor: "#3085d6",
		        confirmButtonText: "Yes, delete!",
		        cancelButtonText: "Cancel"
		    }).then((result) => {
		        if (result.isConfirmed) {	
		            // Redirect to delete the user
		            window.location.href = 'UserController?action=deleteUser&userID=' + userID + '&projectID=' + projectID;
		        }
		    });
		}

	</script>
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		
	<!-- JavaScript for Modal and AJAX -->
    <script>
        function openModal(projectID) {
            document.getElementById("addMemberModal").style.display = "block";

            // Load addMembers.jsp dynamically
            let xhr = new XMLHttpRequest();
            xhr.open("GET", "pages/addMember.jsp?projectID=" + encodeURIComponent(projectID), true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("modal-body").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        function closeModal() {
            document.getElementById("addMemberModal").style.display = "none";
            document.getElementById("modal-body").innerHTML = ""; // Clear modal content
        }

        // Close modal when clicking outside the modal content
        window.onclick = function(event) {
            let modal = document.getElementById("addMemberModal");
            if (event.target === modal) {
                closeModal();
            }
        };
    </script>

	</div>
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
	<!-- js -->
   <script src="${pageContext.request.contextPath}/js/main.js"></script>

</body>
  </html>
      