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
    <link rel="stylesheet" href="../css/listView.css" />
    


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
                <img src="/img/profLogoDashboard.png" alt="Profile" class="profile-icon">
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
            onclick="window.location.href='/pages/login.jsp';"
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
              checked
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
        </div>
      </div>
 
 <!-- list view -->
 <div id="list-view" class="list-view">
    <div class="list-container pink">
      
      <h2 class="list-header">
        <span class="circle pink-background"></span
        ><span class="text">To do</span>
      </h2>
      <ul class="tasks-list">
        <li class="task-item">
          <button class="task-button">
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
    <div class="list-container blue">
      <h2 class="list-header">
        <span class="circle blue-background"></span
        ><span class="text">Doing</span>
      </h2>
      <ul class="tasks-list">
        <li class="task-item">
          <button class="task-button">
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
    <div class="list-container green">
      <h2 class="list-header">
        <span class="circle green-background"></span
        ><span class="text">Done</span>
      </h2>
      <ul class="tasks-list">
        <li class="task-item">
          <button class="task-button">
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
            <p class="task-name">Design UI</p>
            <p class="task-due-date">Due on January 7, 2020</p>
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
  

   <!-- import IconifyIcon web component -->
   <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
   <!-- js -->
   <script src="../js/main.js"></script>
 </body>
</html>