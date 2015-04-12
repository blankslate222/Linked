<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LinkedIN | Job Posting</title>
</head>
<body>
<h3>LinkedIN Job Posting</h3>
<sf:form id="postJob" modelAttribute="jobPosting" action="${pageContext.request.contextPath}/postJob" method="post">
<table>
<tr><td>Job Id:</td><td><sf:input path="id" id="id" required = "required"/></td></tr>
<tr><td>Company Name:</td><td><sf:input path="companyName" id="companyName" required = "required"/></td></tr>
<tr><td>Job Name:</td><td><sf:input path="jobName" id="jobName" name="jobName" required = "required"/></td></tr>
<tr><td>Description:</td><td><sf:input path="description" id="description" name="description" required = "required"/></td></tr>
<tr><td>Expiry:</td><td><sf:input type="date" path="expiry" id="expiry" name="expiry"  required = "required"/></td></tr>
<tr><td><input type="submit" id="postJob" value="POST JOB"/></td></tr>
</table>
</sf:form>
</body>
</html>