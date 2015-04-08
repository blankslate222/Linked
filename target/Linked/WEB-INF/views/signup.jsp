<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Linked | Signup</title>
</head>
<body>
<h3>Linekd Signup</h3>
<sf:form id="signup" modelAttribute="user" action="${pageContext.request.contextPath}/signup" method="post">
<table>
<tr><td>First Name:</td><td><sf:input path="firstName" id="firstname" type="text" required = "required"/></td></tr>
<tr><td>Last Name:</td><td><sf:input path="lastName" id="lastname" type="text" required = "required"/></td></tr>
<tr><td>Email:</td><td><sf:input path="email" id="email" type="email" required = "required"/></td></tr>
<tr><td>Password:</td><td><sf:password path="password" id="password" required = "required"/></td></tr>
<tr><td><input type="submit" id="create" value="Signup"/></td></tr>
</table>
</sf:form>
</body>
</html>