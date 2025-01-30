<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/entry-page.css" />
    
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
			</div>
	
			<label for="confirmPassword" class="label">Confirm Password</label>
			<div class="input-container">
		    <input type="password" name="confirmPassword" id="confirmPassword" class="input" required />
		    <span id="confirm-password-error" class="error-bubble"></span>
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
  	document.querySelector(".form").addEventListener("submit", function(event) {
      let password = document.getElementById("password").value;
      let confirmPassword = document.getElementById("confirmPassword").value;
      let passwordError = document.getElementById("password-error");
      let confirmPasswordError = document.getElementById("confirm-password-error");

      // Regular expression for at least 1 uppercase, 1 special character, and min 6 characters
      let passwordRegex = /^(?=.*[A-Z])(?=.*[\W]).{6,}$/;

      let hasError = false;

      // Password validation
      if (!passwordRegex.test(password)) {
          passwordError.innerText = "Must be at least 6 characters, 1 uppercase, 1 special character!";
          passwordError.classList.add("show-error");
          hasError = true;
      } else {
          passwordError.classList.remove("show-error");
      }

      // Confirm password validation
      if (password !== confirmPassword) {
          confirmPasswordError.innerText = "Passwords do not match!";
          confirmPasswordError.classList.add("show-error");
          hasError = true;
      } else {
          confirmPasswordError.classList.remove("show-error");
      }

      // Stop form submission if errors exist
      if (hasError) {
          event.preventDefault();
      }
  });
</script>
  </body>
</html>
