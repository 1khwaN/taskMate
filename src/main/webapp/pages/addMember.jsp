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
<div id="popup-form">
<%
    String projectID = request.getParameter("projectID");
    if (projectID == null) {
        projectID = "";
    }
%>
    <h2>Add Member</h2>
    <form action="UserController" method="post">
        <label for="memberName">Member Name:</label>
        <input type="text" id="userName" name="userName" autocomplete="off" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" autocomplete="off"required><br><br>
        
        <label for="email">Password:</label>
        <input type="password" name="password" autocomplete="off" required><br><br>
        
        <input type="hidden" name="typeID" value="2">
        <input type="hidden" name="projectID" value="<%= projectID%>">
        
        

        <button type="submit" class="button green-background">Submit</button>
    </form>
</div>
    