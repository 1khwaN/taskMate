<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management System</title>
</head>
<body>
	<h1 class="header">Add Project</h1>
        <form class="form" autocomplete="off">
          <label for="name" class="label">Name</label>
          <input
            type="text"
            name="name"
            id="name"
            class="input white-background"
            required
          />
          <label for="description" class="label">Description</label>
          <textarea
            name="description"
            id="description"
            rows="8"
            class="textarea-input white-background"
            required
          ></textarea>
          <h2 class="label">Deadline</h2>
          
            <div>
              <input
                type="text"
                name="due-date-day"
                id="due-date-day"
                class="input white-background"
                required
              />
            </div>
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
            
              
              <input
                type="text"
                name="due-date-year"
                id="due-date-year"
                class="input white-background"
                required
              />
            
          
          <h2 class="label">Status</h2>
          <div
            id="status-select"
            class="status-select white-background flex items-center justify-between cursor-pointer"
          >
            <span>To do</span>
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </div>
          <ul
            id="status-dropdown"
            class="status-dropdown white-background hide"
          >
            <li>
              <input
                type="radio"
                id="to-do-radio"
                name="status-option"
                value="To do"
                class="radio-input"
              />
              <label for="to-do-radio" class="radio-label">
                <span class="circle pink-background"></span><span>To do</span>
              </label>
            </li>
            <li>
              <input
                type="radio"
                id="doing-radio"
                name="status-option"
                value="Doing"
                class="radio-input"
              />
              <label for="doing-radio" class="radio-label">
                <span class="circle blue-background"></span><span>Doing</span>
              </label>
            </li>
            <li>
              <input
                type="radio"
                id="done-radio"
                name="status-option"
                value="Done"
                class="radio-input"
              />
              <label for="done-radio" class="radio-label">
                <span class="circle green-background"></span><span>Done</span>
              </label>
            </li>
          </ul>


          <h2 class="label">Priority</h2>
          <div
            id="priority-select"
            class="status-select white-background flex items-center justify-between cursor-pointer"
          >
            <span>High</span>
            <iconify-icon
              icon="material-symbols:arrow-back-ios-rounded"
              style="color: black"
              width="18"
              height="18"
              class="arrow-icon"
            ></iconify-icon>
          </div>
          <ul
            id="priority-dropdown"
            class="status-dropdown white-background hide"
          >
            <li>
              <input
                type="radio"
                id="high-radio"
                name="priority-option"
                value="High"
                class="radio-input"
              />
              <label for="high-radio" class="radio-label">
                <span class="circle pink-background"></span><span>High</span>
              </label>
            </li>
            <li>
              <input
                type="radio"
                id="medium-radio"
                name="priority-option"
                value="Medium"
                class="radio-input"
              />
              <label for="medium-radio" class="radio-label">
                <span class="circle blue-background"></span><span>Medium</span>
              </label>
            </li>
            <li>
              <input
                type="radio"
                id="low-radio"
                name="priority-option"
                value="Low"
                class="radio-input"
              />
              <label for="low-radio" class="radio-label">
                <span class="circle green-background"></span><span>Low</span>
              </label>
            </li>
          </ul>



          <div class="text-center">
            <button
              type="submit"
              class="button regular-button green-background cta-button"
            >
              Add Project
            </button>
          </div>
        </form>
      </div>
    </div>
</body>
</html>