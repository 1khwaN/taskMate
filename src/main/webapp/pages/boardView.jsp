<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="../css/dashboard.css" />
    <link rel="stylesheet" href="../css/boardView.css" />


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
                onclick="window.location.href='accProfile.jsp';"
            >
                <img src="/taskMate/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
            </button>

            <button
              id="add-task-cta"
              class="button regular-button blue-background"
              onclick="window.location.href='addTask.jsp';"
            >
              Add task
            </button>
            <button
              id="add-project-cta"
              class="button regular-button green-background"
              onclick="window.location.href='addProject.jsp';"
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
              checked
              onclick="window.location.href='/taskMate/project/listOfTasks.jsp';"
            />
            <label for="board" class="radio-label">
              <iconify-icon
                icon="ic:round-grid-view"
                style="color: black"
                width="24"
                height="24"
              ></iconify-icon>
              <span>Board</span>
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
              onclick="window.location.href='memberView.jsp';"
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
        

<!-- board view -->
<div id="board-view" class="board-view">
    <!-- list -->
    <div>
      <h2 class="list-header">
        <span class="circle pink-background"></span
        ><span class="text">To do</span>
      </h2>
      <ul class="tasks-list pink">
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
      </ul>
    </div>
    <!-- list -->
    <div>
      <h2 class="list-header">
        <span class="circle blue-background"></span
        ><span class="text">Doing</span>
      </h2>
      <ul class="tasks-list blue">
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
      </ul>
    </div>
    <!-- list -->
    <div>
      <h2 class="list-header">
        <span class="circle green-background"></span
        ><span class="text">Done</span>
      </h2>
      <ul class="tasks-list green">
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
        <li class="task-item">
          <button class="task-button">
            <div>
              <p class="task-name">Design UI</p>
              <p class="task-due-date">Due on January 7, 2020</p>
            </div>
            <!-- arrow -->
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </button>
        </li>
      </ul>
    </div>
  </div>
</div>
</div>

<!-- Update Task Overlay -->
<div id="update-task-overlay" class="overlay hide">
  <div class="overlay-content blue-background">
    <!-- Close button -->
    <button
      class="button circle-button flex justify-center items-center close-button"
    >
      <iconify-icon
        icon="material-symbols:close-rounded"
        style="color: black"
        width="26"
        height="26"
      ></iconify-icon>
    </button>

    <!-- Update Task Form -->
    <h1 class="header no-margin">Update Task</h1>
    <form>
      <div class="form-group">
        <label for="update-task-name" class="header">Task Name</label>
        <input
          type="text"
          id="update-task-name"
          class="form-input value"
          placeholder="Enter task name"
        />
      </div>

      <div class="form-group">
        <label for="update-task-description" class="header">Task Description</label>
        <textarea
          id="update-task-description"
          class="form-input value"
          placeholder="Enter task description"
        ></textarea>
      </div>

      <div class="form-group flex items-center">
        <label for="update-task-due-date" class="header min-width">Due Date</label>
        <input
          type="date"
          id="update-task-due-date"
          class="form-input value"
        />
      </div>

      <div class="form-group flex items-center">
        <label for="update-task-status" class="header min-width">Status</label>
        <select id="update-task-status" class="form-input value">
          <option value="To Do">To Do</option>
          <option value="Doing">Doing</option>
          <option value="Done">Done</option>
        </select>
      </div>

      <div class="control-buttons-container">
        <!-- Save button -->
        <button
          type="button"
          id="save-task-btn"
          class="button circle-button green-background flex justify-center items-center"
        >
          <iconify-icon
            icon="material-symbols:check-circle"
            style="color: black"
            width="24"
            height="24"
          ></iconify-icon>
        </button>

        <!-- Delete button -->
        <button
          type="button"
          id="delete-task-btn"
          class="button circle-button red-background flex justify-center items-center"
        >
          <iconify-icon
            icon="ic:round-delete"
            style="color: black"
            width="24"
            height="24"
          ></iconify-icon>
        </button>
      </div>
    </form>
  </div>
</div>



<script>
// Select necessary elements
const updateTaskOverlay = document.getElementById("update-task-overlay");
const closeOverlayButton = document.querySelector(".close-button");
const saveTaskBtn = document.getElementById("save-task-btn");
const deleteTaskBtn = document.getElementById("delete-task-btn");

// Attach event listeners to all task buttons
document.querySelectorAll(".task-button").forEach((taskButton) => {
  taskButton.addEventListener("click", () => {
    updateTaskOverlay.classList.remove("hide");
    
    // Optionally, populate the form with task details
    const taskName = taskButton.querySelector(".task-name").textContent;
    const taskDueDate = taskButton.querySelector(".task-due-date").textContent;

    document.getElementById("update-task-name").value = taskName;
    document.getElementById("update-task-due-date").value = taskDueDate;

    console.log("Task selected:", { taskName, taskDueDate });
  });
});

// Close overlay on close button click
closeOverlayButton.addEventListener("click", () => {
  updateTaskOverlay.classList.add("hide");
});

// Handle the save button click
saveTaskBtn.addEventListener("click", () => {
  const updatedName = document.getElementById("update-task-name").value;
  const updatedDescription = document.getElementById("update-task-description").value;
  const updatedDueDate = document.getElementById("update-task-due-date").value;
  const updatedStatus = document.getElementById("update-task-status").value;

  console.log("Task Updated:", {
    name: updatedName,
    description: updatedDescription,
    dueDate: updatedDueDate,
    status: updatedStatus,
  });

  updateTaskOverlay.classList.add("hide");
});

// Handle the delete button click
deleteTaskBtn.addEventListener("click", () => {
  console.log("Task Deleted");
  updateTaskOverlay.classList.add("hide");
});
</script>

<!-- import IconifyIcon web component -->
<script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
<!-- js -->
<script src="../js/main.js"></script>
</body>
</html>