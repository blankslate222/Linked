<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Linked | Jobs</title>
</head>
<body>
	<h3>Lineked Jobs List</h3>
	<c:if test="${ not empty joblist }">
		<ul>
			<c:forEach var="job" items="${joblist}">
				<li><a href="${pageContext.request.contextPath}/job/${job.key}">${job.value}</a></li>
			</c:forEach>
		</ul>
	</c:if>
</body>
</html>