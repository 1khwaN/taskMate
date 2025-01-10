// Import Chart.js if you're using a bundler
import { Chart } from "chart.js/auto";

// Elements
const radioViewOptions = document.querySelectorAll("input[name='view-option']");
const trackView = document.getElementById("track-view");
const listView = document.getElementById("list-view");
const boardView = document.getElementById("board-view");
const addTaskCTA = document.getElementById("add-task-cta");
const setTaskOverlay = document.getElementById("set-task-overlay");
const closeButtons = document.querySelectorAll(".close-button");
const statusSelect = document.getElementById("status-select");
const statusDropdown = document.getElementById("status-dropdown");
const taskItems = document.querySelectorAll(".task-item");
const viewTaskOverlay = document.getElementById("view-task-overlay");
const deleteTaskCTA = document.getElementById("delete-task-cta");
const notification = document.getElementById("notification");
let activeOverlay = null;

// // Productivity tracking data and initialization
// function renderChart() {
//   const canvas = document.getElementById("taskChart");

//   if (!canvas) {
//     console.error("Canvas element not found.");
//     return;
//   }

//   const ctx = canvas.getContext("2d");

//   if (!ctx) {
//     console.error("Canvas context is invalid.");
//     return;
//   }

//   const taskData = {
//     completed: 35,
//     inProgress: 20,
//     pending: 45,
//   };

//   new Chart(canvas, {
//     type: "pie",
//     data: {
//       labels: ["Completed", "In Progress", "Pending"],
//       datasets: [
//         {
//           data: [taskData.completed, taskData.inProgress, taskData.pending],
//           backgroundColor: ["#36A2EB", "#FFCE56", "#FF6384"],
//           hoverOffset: 4,
//         },
//       ],
//     },
//     options: {
//       responsive: true,
//       plugins: {
//         legend: {
//           position: "top",
//         },
//         tooltip: {
//           enabled: true,
//         },
//       },
//     },
//   });
// }

// Event listeners & view switching logic
document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM fully loaded and parsed.");
  const initializeViews = () => {
    if (!trackView || !listView || !boardView) {
      console.error("One or more views not found in DOM.");
      return;
    }

    radioViewOptions.forEach((radioButton) => {
      radioButton.addEventListener("change", (event) => {
        const viewOption = event.target.value;

        switch (viewOption) {
          case "track":
            boardView.classList.add("hide");
            listView.classList.add("hide");
            trackView.classList.remove("hide");
            // renderChart(); // Trigger chart render when track view is shown
            break;
          case "list":
            boardView.classList.add("hide");
            trackView.classList.add("hide");
            listView.classList.remove("hide");
            break;
          case "board":
            trackView.classList.add("hide");
            listView.classList.add("hide");
            boardView.classList.remove("hide");
            break;
        }
      });
    });
  };

  // Attach listeners for overlay interactions
  addTaskCTA.addEventListener("click", () => {
    setTaskOverlay.classList.remove("hide");
    activeOverlay = setTaskOverlay;
    document.body.classList.add("overflow-hidden");
  });

  closeButtons.forEach((button) => {
    button.addEventListener("click", () => {
      activeOverlay.classList.add("hide");
      activeOverlay = null;
      document.body.classList.remove("overflow-hidden");
    });
  });

  statusSelect.addEventListener("click", () => {
    statusDropdown.classList.toggle("hide");
  });

  taskItems.forEach((task) => {
    task.addEventListener("click", () => {
      viewTaskOverlay.classList.remove("hide");
      activeOverlay = viewTaskOverlay;
      document.body.classList.add("overflow-hidden");
    });
  });

  deleteTaskCTA.addEventListener("click", () => {
    activeOverlay.classList.add("hide");
    activeOverlay = null;
    document.body.classList.remove("overflow-hidden");
    notification.classList.add("show");
    setTimeout(() => {
      notification.classList.remove("show");
    }, 3000);
  });

  

  initializeViews();
});
