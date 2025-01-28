<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Invalid Login - Task Management System</title>
    <!-- google font: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
    <!-- main css -->
    <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="../css/entry-page.css" />
  </head>
  <body>
    <div class="row height-full">
      <!-- left side -->
      <div
        class="left-column flex flex-column height-full justify-center items-center"
      >
        <h1 class="welcoming-title">Invalid Login</h1>
        <p class="error-message">
          The email or password you entered is incorrect. Please try again.
        </p>

        <p class="sign-up-prompt">
          Remembered your credentials?
          <a href="login.jsp" class="sign-up-link">Go back to Login</a>
        </p>
      </div>
      <!-- right side -->
      <div class="right-column"></div>
    </div>
  </body>
</html>
