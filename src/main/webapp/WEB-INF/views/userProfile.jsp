<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Linked | User Profile</title>
</head>
<body>

<h3>Build your profile</h3>
<sf:form id="userProfile" modelAttribute="userProfile" action="${pageContext.request.contextPath}/user-profile/build" method="post">


<table>
<tr><td>Summary or Bio:</td><td><sf:input path="summary" id="summary" name="summary" type="text" /></td></tr>
<tr><td>Highest Degree:</td><td><sf:input path="highestDegree" id="highestDegree" name="highestDegree" required = "required"/></td></tr>
<tr><td>University of highest degree:</td><td><sf:input path="university" id="university" name="university" required = "required"/></td></tr>
<tr><td>Skills:</td><td><sf:input path="skills" id="skills" name="skills"/></td></tr>
<tr><td>Certifications:</td>
<td><sf:input path="certifications" id="certifications" name="certifications"/></td></tr>
<tr><td>Work Experience</td></tr>
 <c:forEach items="${userProfile.experience}" var="exp" varStatus="status">

 	<tr><td>Company:</td>
	<td><input name="experience[${status.index}].company" value="${exp.company}"/></td>
 	<td>Number of Years:</td>
 	<td><input name="experience[${status.index}].numberOfYears" value="${exp.numberOfYears}"/></td></tr>
</c:forEach>
<tr><td><input type="submit" id="company" value="Save"/></td></tr>
</table>
</sf:form>
</body>
</html>