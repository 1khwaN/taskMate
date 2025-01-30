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
    <title>Add Task - TaskMate System</title>
    <!-- Google Font: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
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
    </style>
   
</head>
<body>
	<div class="form-frame">
		<!-- Close button -->
		<button class="button circle-button blue-background flex justify-center items-center close-button" onclick="window.history.back();">
			<iconify-icon icon="material-symbols:close-rounded" style="color: black" width="26" height="26"></iconify-icon>
		</button>

		<h1>Add Task</h1>
		<form class="form" autocomplete="off" action="TaskController" method="post">

			<label for="task-name" class="label">Task Name</label>
			<input type="text" name="taskName" id="taskName" class="input white-background" placeholder="Enter task name" required /> 

			<label for="task-description" class="label">Task Description</label>
			<textarea name="description" id="description" rows="5" class="textarea-input white-background" placeholder="Enter task description" ></textarea>

			<h2 class="label">Start Date</h2>
			<div><input type="date" name="startDate" id="startDate" class="input white-background" required /></div>

			<h2 class="label">Due Date</h2>
			<div class="divided-inputs-container">
				<div><input type="date" name="endDate" id="endDate" class="input white-background" required /></div>
			</div>

			<h2 class="label">Status</h2>
			<div id="status-select"
				class="status-select white-background flex items-center justify-between cursor-pointer"
				onclick="toggleDropdown()">
				<span id="taskStatus">To Do</span>
				<iconify-icon icon="material-symbols:arrow-drop-down" style="color: black" width="18" height="18" class="arrow-icon"></iconify-icon>
			</div>
			<ul id="taskStatus" class="status-dropdown white-background" style="display: none;">
				<li onclick="selectStatus('To Do')">To Do</li>
				<li onclick="selectStatus('Doing')">Doing</li>
				<li onclick="selectStatus('Done')">Done</li>
			</ul>
			<input type="hidden" name="taskStatus" id="hidden-status" value="To Do" />

			<div class="text-center">
				<button type="submit" class="button regular-button green-background cta-button">Add Task</button>
			</div>
		</form>
	</div>
	
	<!-- Import Iconify -->
	<script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/addTask.js"></script>
	<script>
		function toggleDropdown() {
			const dropdown = document.getElementById('status-dropdown');
			dropdown.style.display = dropdown.style.display === 'none' ? 'block' : 'none';
		}
	
		function selectStatus(status) {
			document.getElementById('selected-status').textContent = status;
			document.getElementById('hidden-status').value = status;
			document.getElementById('status-dropdown').style.display = 'none';
		}
	
		// Close the dropdown if the user clicks outside of it
		document.addEventListener('click', function(event) {
			const selectBox = document.getElementById('status-select');
			const dropdown = document.getElementById('status-dropdown');
			if (!selectBox.contains(event.target)) {
				dropdown.style.display = 'none';
			}
		});
	</script>
</body>
</html>
