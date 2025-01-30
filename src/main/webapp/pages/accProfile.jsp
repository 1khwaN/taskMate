<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Task Management System - Profile Page</title>
    <!-- google font: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
    <!-- main css -->
    <!-- <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="../css/entry-page.css" /> -->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/accProfile.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/boardView.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MembersPage.css" />

	<%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.addHeader("Cache-Control", "pre-check=0, post-check=0");
	response.setDateHeader("Expires", 0);
	
	%> 

  </head>

<body>
<div class="page-heading">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-6 order-md-1 order-last">
                <h3>Account Profile</h3>
            </div>
            <div class="col-12 col-md-6 order-md-2 order-first">
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="pages/dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Profile</li>
                    </ol>
                </nav>
            </div>
	</div>
    </div>
    <section class="section">
    <div class="row">
        <!-- Profile Picture Section -->
        <div class="col-12 col-lg-4">
            <div class="card h-100">
                <div class="card-body">
               
                    <div class="d-flex justify-content-center align-items-center flex-column">
                        <h3 class="mt-3">${user.userName}</h3>
                        <p class="text-small">
        				<c:choose>
            				<c:when test="${user.typeID == 1}">Project Manager</c:when>
            				<c:when test="${user.typeID == 2}">Member</c:when>
            				<c:otherwise>Unknown Role</c:otherwise>
        				</c:choose>
    					</p>
    					 <div class="avatar avatar-xl">
                            <img src="${pageContext.request.contextPath}/img/profPic.png" alt="Avatar">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Form Section -->
        <div class="col-12 col-lg-8">
            <div class="card h-100">
                <div class="card-body">
                    <form action="UserController" method="post">
                        <input type="hidden" name="userID" value="${user.userID}">               
                        <div class="form-group">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" name="userName" id="name" class="form-control" value="${user.userName}">
                        </div>
                        <div class="form-group">
                            <label for="email" class="form-label">Email</label>
                            <input type="text" name="email" id="email" class="form-control" value="${user.email}">
                        </div>
                        <div class="form-group">
                            <label for="phone" class="form-label">Password:</label>
                            <input type="password" name="password" id="password" class="form-control" value="${user.password}">
                        </div>
                        <div class="form-group">
                            <br>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

</div>
</body> 
</html>