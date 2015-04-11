<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Linked | Search</title>
</head>
<body>
	
	<h3>Linked | Search</h3>
	<form id="job_search" method="get" action="${pageContext.request.contextPath}/search/job">
	<p>Enter name of the job to be searched</p>
	<input type="text" id="name" name="name"/>
	<input type="submit" value="SearchJob"/>
	</form>
	<form id="person_search" method="get" action="${pageContext.request.contextPath}/search/people">
	<p>Enter email of the person to be searched</p>
	<input type="text" id="name" name="name"/>
	<input type="submit" value="SearchPerson"/>
	</form>
	<form id="company_search" method="get" action="${pageContext.request.contextPath}/search/company">
	<p>Enter name of the company to be searched</p>
	<input type="text" id="name" name="name"/>
	<input type="submit" value="SearchCompany"/>
	</form>	
	<h3>Results</h3>
	<p>Search parameter : ${searchTerm}</p>
	<c:choose>
		<c:when test="${ not empty jobResult }">
			<ul>
				<c:forEach var="job" items="${jobResult}">
					<li><a href="${pageContext.request.contextPath}/job/${job.id}">${job.name}</a></li>
				</c:forEach>
			</ul>
		</c:when>
		<c:when test="${ not empty companyResult }">
			<ul>
				<c:forEach var="company" items="${companyResult}">
					<li><a
						href="${pageContext.request.contextPath}/company/${company.company_id}">${company.company_id}</a></li>
				</c:forEach>
			</ul>
		</c:when>
		<c:when test="${ not empty personResult }">
			<ul>
				<c:forEach var="person" items="${personResult}">
					<li><a href="${pageContext.request.contextPath}/user-profile/${person.email}">${person.email}</a></li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<p>No matches found</p>
		</c:otherwise>
	</c:choose>
</body>
</html>