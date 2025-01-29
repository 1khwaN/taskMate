<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="popup-form">
    <h2>Add Member</h2>
    <form action="UserController" method="post">
        <label for="memberName">Member Name:</label>
        <input type="text" id="userName" name="userName" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>
        
        <label for="email">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        
        <input type="hidden" name="typeID" value="2">
        <input type="hidden" name="projectID" value="1">
        
        

        <button type="submit" class="button green-background">Submit</button>
    </form>
</div>
    