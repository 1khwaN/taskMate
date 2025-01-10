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
    <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="../css/dashboard.css" />
    


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
                <img src="taskMate/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
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
            onclick="window.location.href='login.jsp';"
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
              
              onclick="window.location.href='prodTracking.jsp';"
              
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
          </div>
      
          <!-- Board -->
          <div class="radio-container">
            <input
              type="radio"
              id="board"
              name="view-option"
              value="board"
              class="radio-input"
              checked
              onclick="window.location.href='boardView.jsp';"
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
	        <div>
	          <h2 class="label"><br>Members</h2>
	          <input
	            type="text"
	            name="due-date-month"
	            id="due-date-month"
	            class="input white-background"
	            required
	          />
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

<!-- view task -->
<div id="view-task-overlay" class="overlay view-task-overlay hide">
  <div class="overlay-content green-background">
    <!-- close button -->
    <button
      class="button circle-button blue-background flex justify-center items-center close-button"
    >
      <iconify-icon
        icon="material-symbols:close-rounded"
        style="color: black"
        width="26"
        height="26"
      ></iconify-icon>
    </button>
    <h1 class="header no-margin">Name</h1>
    <p class="value">some long task name</p>
    <h1 class="header">Description</h1>
    <p class="value">
      some long task namesome long task namesome long task name
    </p>
    <div class="flex items-center">
      <h1 class="header min-width">Due date</h1>
      <p class="value">January 7, 2020</p>
    </div>
    <div class="flex items-center">
      <h1 class="header min-width">Status</h1>
      <p class="value status-value">
        <span class="circle blue-background"></span><span>Doing</span>
      </p>
    </div>
    <div class="control-buttons-container">
      <!-- edit button -->
      <button
        class="button circle-button pink-background flex justify-center items-center"
      >
        <iconify-icon
          icon="material-symbols:edit-rounded"
          style="color: black"
          width="24"
          height="24"
        ></iconify-icon>
      </button>
      <!-- delete button -->
      <button
        id="delete-task-cta"
        class="button circle-button pink-background flex justify-center items-center"
      >
        <iconify-icon
          icon="ic:round-delete"
          style="color: black"
          width="24"
          height="24"
        ></iconify-icon>
      </button>
    </div>
  </div>
</div>

<!-- import IconifyIcon web component -->
<script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
<!-- js -->
<script src="../js/main.js"></script>
</body>
</html>