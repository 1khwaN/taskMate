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
		<title>View Project - TaskMate System</title>
		<!-- Google Font: Inter -->
		<link rel="preconnect" href="https://fonts.googleapis.com" />
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
		<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
		<!-- Main CSS -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
		<!-- Add Task-specific styles -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addTask.css" />
		<style>
		body {
        font-family: "Inter", sans-serif;
        background-color: var(--beige);; /* Replace with your dashboard's background color */
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }

      .form-frame {
        background-color: #ffffff;
        margin-top: 50px;
        margin-bottom: 50px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        width: 500px;
        max-width: 90%;
        padding: 24px;
        position: relative;
      }

      .form-frame .close-button {
        position: absolute;
        top: 16px;
        right: 16px;
      }

      .form-frame h1 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: 600;
      }

      .form {
        display: flex;
        flex-direction: column;
        gap: 16px;
      }

      .input,
      .textarea-input {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 8px;
      }

      .divided-inputs-container {
        display: flex;
        justify-content: space-between;
        gap: 12px;
      }

      .divided-inputs-container div {
        flex: 1;
      }

      .button {
        font-size: 16px;
        font-weight: 600;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
      }

      .cta-button {
        background-color: #4caf50;
        text-align: center;
        width: 100%;
      }

      .status-select {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 8px;
        position: relative;
      }

      .status-dropdown {
        position: absolute;
        margin-top: 4px;
        padding: 10px;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        list-style-type: none;
        z-index: 10;
        display: none; /* Initially hidden */
      }

      .status-dropdown li {
        margin-bottom: 8px;
        cursor: pointer;
      }

      .status-dropdown li:last-child {
        margin-bottom: 0;
      }

      .priority-select {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 8px;
        position: relative;
      }

      .priority-dropdown {
        position: absolute;
        margin-top: 900px;
        padding: 10px;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        list-style-type: none;
        z-index: 10;
        display: none; /* Initially hidden */
      }

      .priority-dropdown li {
        margin-bottom: 8px;
        cursor: pointer;
      }

      .priority-dropdown li:last-child {
        margin-bottom: 0;
      }
    </style>
</head>

<body>
	<div class="form-frame">
		<!-- Close button -->
		<button class="button circle-button blue-background flex justify-center items-center close-button" onclick="window.history.back();">
			<iconify-icon
				icon="material-symbols:close-rounded"
				style="color: black"
				width="26"
				height="26"
			></iconify-icon>
		</button>

		<h1>View Project</h1>
		<form class="form" action="${pageContext.request.contextPath}/ProjectController" method="POST">
		
			<label for="projectName" class="label">Project Name</label>
 			<input type="text" name="projectName" id="projectName" class="input white-background" value="<c:out value="${project.projectName}"/>" readonly/>
		
			<label for="description" class="label">Description</label>
			<textarea rows="5" name="description" id="description" class="textarea-input white-background" readonly><c:out value="${project.description}" /></textarea>
			
	        <div class="divided-inputs-container">
	          <div>
	            <label for="startDate" class="secondary-label">Start Date</label>
	            <input
	              type="date" name="startDate" id="startDate" class="input white-background" value="<c:out value="${project.startDate}"/>" readonly/>
	          </div>
	          <div>
	            <label for="endDate" class="secondary-label">Due Date</label>
	            <input
	              type="date" name="endDate" id="endDate" class="input white-background" value="<c:out value="${project.endDate}"/>" readonly/>
	          </div>
	 		</div>
	 	
	          <div>
	            <label for="projectStatus" class="label">Project Status</label>
	            <input
	              type="text" name="projectStatus" id="projectStatus" class="input white-background" value="<c:out value="${project.projectStatus}"/>" readonly/>
	          </div>
	 	
	          <div>
	            <label for="projectPriority" class="label">Project Priority</label>
	            <input
	              type="text" name="projectPriority" id="projectPriority" class="input white-background" value="<c:out value="${project.projectPriority}"/>" readonly/>
	          </div>

			<div class="text-center">
				<input type="button" value="Update Project" 
				       onclick="window.location.href='/taskMate/ProjectController?action=updateProject&projectID=${project.projectID}'"
				       class="button regular-button green-background cta-button">
			</div>
		</form>
	</div>

	<!-- Import Iconify -->
	<script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/addproject.js"></script>
</body>
</html>