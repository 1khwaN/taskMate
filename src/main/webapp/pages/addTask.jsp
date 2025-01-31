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
    <title>Add Task - TaskMate System</title>
    <!-- Google Font: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
    <!-- Main CSS -->
    <link rel="stylesheet" href="../css/main.css" />
    <!-- Add Task-specific styles -->
    <link rel="stylesheet" href="../css/addTask.css" />
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
      <button
        class="button circle-button blue-background flex justify-center items-center close-button"
        onclick="window.location.href='/taskMate/prodTrackingController';"
      >
        <iconify-icon
          icon="material-symbols:close-rounded"
          style="color: black"
          width="26"
          height="26"
        ></iconify-icon>
      </button>
      <h1>Add Task</h1>
      <form class="form" autocomplete="off" action="" method="post">
        <label for="task-name" class="label">Task Name</label>
        <input
          type="text"
          name="task-name"
          id="task-name"
          class="input white-background"
          placeholder="Enter task name"
          required
        />
        <label for="task-description" class="label">Task Description</label>
        <textarea
          name="task-description"
          id="task-description"
          rows="5"
          class="textarea-input white-background"
          placeholder="Enter task description"
          required
        ></textarea>
        <h2 class="label">Due Date</h2>
        <div class="divided-inputs-container">
          <div>
            <label for="due-day" class="secondary-label">Day</label>
            <input
              type="number"
              name="due-day"
              id="due-day"
              class="input white-background"
              placeholder="DD"
              min="1"
              max="31"
              required
            />
          </div>
          <div>
            <label for="due-month" class="secondary-label">Month</label>
            <input
              type="number"
              name="due-month"
              id="due-month"
              class="input white-background"
              placeholder="MM"
              min="1"
              max="12"
              required
            />
          </div>
          <div>
            <label for="due-year" class="secondary-label">Year</label>
            <input
              type="number"
              name="due-year"
              id="due-year"
              class="input white-background"
              placeholder="YYYY"
              min="2024"
              required
            />
          </div>
        </div>
        <h2 class="label">Status</h2>
        <div
          id="status-select"
          class="status-select white-background flex items-center justify-between cursor-pointer"
        >
          <span id="selected-status">To Do</span>
          <iconify-icon
            icon="material-symbols:arrow-drop-down"
            style="color: black"
            width="18"
            height="18"
            class="arrow-icon"
          ></iconify-icon>
        </div>
        <ul id="status-dropdown" class="status-dropdown white-background">
          <li data-status="To Do">To Do</li>
          <li data-status="Doing">Doing</li>
          <li data-status="Done">Done</li>
        </ul>
        <input type="hidden" name="task-status" id="hidden-status" value="To Do" />
        <div class="text-center">
          <button
            type="submit"
            class="button regular-button green-background cta-button"
          >
            Add Task
          </button>
        </div>
      </form>
    </div>
    <!-- Import Iconify -->
    <script src="https://code.iconify.design/iconify-icon/1.0.5/iconify-icon.min.js"></script>
    <script src="../js/addTask.js"></script>
  </body>
</html>
