<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Task Management System - Login page</title>
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
    
    <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/entry-page.css" /> -->
    
    <!-- <link rel="stylesheet" href="../css/main.css" /> -->
    <!--<link rel="stylesheet" href="../css/entry-page.css" />-->
  </head>
  <body>
    <div class="row height-full">
      <!-- left side -->
      <div
        class="left-column flex flex-column height-full justify-center items-center" >
        
        <h1 class="taskmate-title"><b>Welcome to TaskMate</b></h1>
        <h3 class="welcoming-title">Login</h3>
        
        <form class="form" action="${pageContext.request.contextPath}/LoginController" method="POST"><!-- Update action to LoginController -->
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

          <button
            type="submit"
            class="button regular-button pink-background cta-btn"
          >
            Log in
          </button>
        </form>
        <p class="sign-up-prompt">
          Don’t have an account?
          <a href="./signup.jsp" class="sign-up-link">Sign up</a>
        </p>
      </div>
      <!-- right side -->
      <div class="right-column"></div>
    </div>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
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
    });
</script>

  </body>
</html>