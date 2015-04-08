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
	<h3>Companies</h3>
	<c:if test="${ not empty companyList }">
		<ul>
			<c:forEach var="company" items="${companyList}">
				<li><a href="${pageContext.request.contextPath}/company/${company.company_id}">${company.company_id}</a></li>
			</c:forEach>
		</ul>
	</c:if>
</body>
</html>