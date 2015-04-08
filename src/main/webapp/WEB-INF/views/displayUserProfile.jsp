<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Linked | User</title>
</head>
<body>

<h3>User profile</h3>
<br/>
<table>
<tr><td>Bio:</td><td>${userProfile.summary}</td></tr>
<tr><td>Highest Degree:</td><td>${userProfile.highestDegree}</td></tr>
<tr><td>University:</td><td>${userProfile.university}</td></tr>
<tr><td>Skills:</td><td>${userProfile.skills}</td></tr>
<tr><td>Certifications:</td><td>${userProfile.certifications}</td></tr>
<tr><td>Experience</td></tr>
<c:forEach items="${userProfile.experience}" var="experience" varStatus="status">
 	<tr><td>Company:</td>
 	<td>${experience.getCompany()}</td>
 	<td>Number of Years:</td>
 	<td>${experience.getNumberOfYears()}</td></tr>
 </c:forEach>
</table>
<br/>
<a href="${pageContext.request.contextPath}/user-profile/update">Update Profile</a>
</body>
</html>