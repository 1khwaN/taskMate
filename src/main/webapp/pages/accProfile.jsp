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
	rel="stylesheet" />
<!-- main css -->
<!-- <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="../css/entry-page.css" /> -->
<link rel="stylesheet" href="/taskMate/css/bootstrap.min.css" />
<link rel="stylesheet" href="/taskMate/css/accProfile.css" />

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
					<h2 class="list-header">Account Profile</h2>
				</div>

				<!-- BreadCrumb -->
				<!-- <div class="col-12 col-md-6 order-md-2 order-first">
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Profile</li>
                    </ol>
                </nav>
            </div> -->
			</div>
		</div>
		<section class="section">
			<div class="row">
				<!-- Profile Picture Section -->
				<div class="col-12 col-lg-4">
					<div class="card h-100">
						<div class="card-body">
							<div
								class="d-flex justify-content-center align-items-center flex-column">
								<div class="avatar avatar-xl">
									<img src="../img/profPic.png" alt="Avatar">
								</div>
								<h3 class="mt-3">${"Izzy"}</h3>
								<!-- Retrive from db -->
								<p class="text-small">${"Project Manager"}</p>
								<!-- Retrive from db -->
							</div>
						</div>
					</div>
				</div>

				<!-- Form Section -->
				<div class="col-12 col-lg-8">
					<div class="card h-100">
						<div class="card-body">
							<form action="accProfile.jsp" method="post">
								<input type="hidden" name="id" id="id" class="form-control"
									value="${user.id}">
								<div class="form-group">
									<label for="name" class="form-label">Name</label> <input
										type="text" name="name" id="name" class="form-control"
										value="${user.name}">
								</div>
								<div class="form-group">
									<label for="email" class="form-label">Email</label> <input
										type="text" name="email" id="email" class="form-control"
										value="${user.email}">
								</div>
								<div class="form-group">
									<label for="phone" class="form-label">Password:</label> <input
										type="text" name="phone" id="phone" class="form-control"
										value="${user.password}">
								</div>
								<div class="form-group">
									<br>
									<button type="submit" class="btn btn-primary">Save</button>

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