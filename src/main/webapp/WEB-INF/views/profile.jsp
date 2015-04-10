<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel='stylesheet' href='/Linked/resources/stylesheets/madhur.css' />
<title>Home | ${user.firstName}</title>
</head>
<body>
	
		<h3>Welcome ${user.firstName} ${user.lastName}</h3>
		<p>Your news feed</p>
		<p>Companies that you are following</p>
		<c:forEach items="${companies}" var="company"
			varStatus="status">
			${company}
		</c:forEach>
	<p>Status posts of the companies you are following</p>
	<c:forEach items="${posts}" var="post"
			varStatus="status">
			${post}
		</c:forEach>
</body>
</html>