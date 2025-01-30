<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TaskMate - Sign up</title>
    <!-- google font: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
    <!-- New Font: Playwrite ZA -->
	<link href="https://fonts.googleapis.com/css2?family=Playwrite+ZA&display=swap" rel="stylesheet">
    
    <!-- Font Awesome for icons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/entry-page.css" />
    <%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.addHeader("Cache-Control", "pre-check=0, post-check=0");
	response.setDateHeader("Expires", 0);
	
	%> 
    <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/entry-page.css" /> -->
    
    <!-- <link rel="stylesheet" href="../css/main.css" /> -->
    <!--<link rel="stylesheet" href="../css/entry-page.css" />-->
  </head>
 
  <body>
    <div class="row height-full">
      <!-- left side -->
      <div class="left-column flex flex-column height-full justify-center items-center">
        <h1  class="taskmate-title"><b>Hello Project Manager!</b></h1>
<!--         <h3 class="welcoming-title">Register</h3> -->

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
		<p id="error-message" style="color: red; font-weight: bold;">
		    <% if (errorMessage != null) { %>
		        <%= errorMessage %>
		    <% } %>
		</p>
		
        <form class="form" action="${pageContext.request.contextPath}/RegisterController" method="POST">
          <label for="userName" class="label">Username</label>
          <input type="text" name="userName" id="userName" class="input" required />
          
          <label for="email" class="label">Email</label>
          <input type="email" name="email" id="email" class="input" required />

          <label for="password" class="label">Password</label>
		<div class="input-container">
		    <input type="password" name="password" id="password" class="input" required />
		    <span id="password-error" class="error-bubble"></span>
		    <span class="toggle-password" id="toggle-password">
		        <i id="toggle-password-icon" class="fa-solid fa-eye"></i>
		    </span>
		</div>
		
		<label for="confirmPassword" class="label">Confirm Password</label>
		<div class="input-container">
		    <input type="password" name="confirmPassword" id="confirmPassword" class="input" required />
		    <span id="confirm-password-error" class="error-bubble"></span>
		    <span class="toggle-password" id="toggle-confirm-password">
		        <i id="toggle-confirm-password-icon" class="fa-solid fa-eye"></i>
		    </span>
		</div>

          <button type="submit" class="button regular-button pink-background cta-btn">
            Sign up
          </button>
        </form>
        <p class="login-prompt">
          Already have an account? <a href="${pageContext.request.contextPath}/pages/login.jsp" class="log-in-link">Log in</a>
        </p>
      </div>
      <!-- right side -->
      <div class="right-column"></div>
    </div>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        function showError(inputId, errorId, message) {
            let errorBubble = document.getElementById(errorId);
            errorBubble.textContent = message;
            errorBubble.classList.add("show-error");

            setTimeout(() => {
                errorBubble.classList.remove("show-error");
            }, 3000);
        }

        function togglePassword(inputId, iconId) {
            let inputField = document.getElementById(inputId);
            let icon = document.getElementById(iconId);

            if (inputField.type === "password") {
                inputField.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash"); // Change to slash icon
            } else {
                inputField.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye"); // Change back to normal eye
            }
        }

        document.getElementById("toggle-password").addEventListener("click", function () {
            togglePassword("password", "toggle-password-icon");
        });

        document.getElementById("toggle-confirm-password").addEventListener("click", function () {
            togglePassword("confirmPassword", "toggle-confirm-password-icon");
        });

        document.querySelector("form").addEventListener("submit", function (event) {
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;

            let passwordError = document.getElementById("password-error");
            let confirmPasswordError = document.getElementById("confirm-password-error");

            passwordError.classList.remove("show-error");
            confirmPasswordError.classList.remove("show-error");

            let passwordRegex = /^(?=.*[A-Z])(?=.*[\W_]).{6,}$/;

            if (!passwordRegex.test(password)) {
                showError("password", "password-error", "Password must have 6+ chars, 1 uppercase, 1 special char");
                event.preventDefault();
            }

            if (password !== confirmPassword) {
                showError("confirmPassword", "confirm-password-error", "Passwords do not match");
                event.preventDefault();
            }
        });
    });

</script>
  </body>
</html>
