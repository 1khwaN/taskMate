<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
              onclick="window.location.href='/taskMate/pages/addTask.jsp';"
            >
              Add task
            </button>
            </c:if>
            
            <c:if test="${sessionScope.sessionTypeID == 1}">
			    <button
			        id="add-project-cta"
			        class="button regular-button green-background"
			        onclick="window.location.href='/taskMate/project/addProject.jsp';"
			    >
			        Add Project
			    </button>
			</c:if>

			<button class="sign-out-cta button regular-button red-background" onclick="confirmLogout();">
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
    
<!--         List
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
        <c:if test="${sessionScope.sessionTypeID == 1}">
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
        </c:if>
        
        <c:if test="${sessionScope.sessionTypeID == 2}">
          <div class="radio-container">
            <input
              type="radio"
              id="board"
              name="view-option"
              value="board"
              class="radio-input"
              
              onclick="window.location.href='/taskMate/TaskController?action=listTask&projectID=<c:out value='${sessionScope.projectID}'/>';"
            />
            <label for="board" class="radio-label">
              <iconify-icon
                icon="ic:round-grid-view"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>List of Tasks</span>
            </label>
          </div>
          </c:if>

        <!--Members-->
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

    

<%@ page import="java.util.Objects" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;
    
%>

<!-- Include SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        let username = "<%= Objects.toString(username, "") %>";
        if (username) {
            Swal.fire({
                title: "Welcome Back!",
                text: "Hello, " + username + "!",
                icon: "success",
                confirmButtonText: "OK",
                timer: 3500
            });

            // Clear session attribute after showing the message to prevent it from appearing again
            fetch('/taskMate/ClearSessionAttributeServlet?attr=sessionUsername', { method: 'GET' });
        }
    });
</script>
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

    <!-- import IconifyIcon web component -->
    <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
    <!-- js -->
     
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
  </body>
</html>
