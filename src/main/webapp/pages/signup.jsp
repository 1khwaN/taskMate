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
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/entry-page.css" />
    
    <!-- <link rel="stylesheet" href="../css/main.css" /> -->
    <!--<link rel="stylesheet" href="../css/entry-page.css" />-->
  </head>
  <body>
    <div class="row height-full">
      <!-- left side -->
      <div class="left-column flex flex-column height-full justify-center items-center">
        <h1 class="welcoming-title">Hello Project Manager!</h1>
        <form class="form" action="${pageContext.request.contextPath}/RegisterController" method="POST">
          <label for="userName" class="label">Username</label>
          <input type="text" name="userName" id="userName" class="input" required />
          
          <label for="email" class="label">Email</label>
          <input type="email" name="email" id="email" class="input" required />

          <label for="password" class="label">Password</label>
          <input type="password" name="password" id="password" class="input" required />
          
          <label for="confirmPassword" class="label">Confirm Password</label>
          <input type="password" name="confirmPassword" id="confirmPassword" class="input" required />

          <button type="submit" class="button regular-button pink-background cta-btn">
            Sign up
          </button>
        </form>
        <p class="login-prompt">
          Already have an account? <a href="./login.jsp" class="log-in-link">Log in</a>
        </p>
      </div>
      <!-- right side -->
      <div class="right-column"></div>
    </div>
  </body>
</html>
