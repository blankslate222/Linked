<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' href='/Linked/resources/stylesheets/madhur.css' />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Linked | Search</title>
</head>
<body>
<div id="header" style="position:absolute"
		class="global-header responsive-header nav-v5-2-header responsive-1 remote-nav"
		>
		<div id="top-header">
			<div class="wrapper">
				<div class="header-section first-child">
					<h2 class="logo-container" tabindex="0">
						<img class="logo" width="30" height="30" style="top:4px;position:absolute;left:5px;" alt="LinkedIn"
							src="/Linked/resources/images/logo.png">
					</h2>
					
					
					
		
				</div>
			</div>
		</div>
		<div class="responsive-nav">
<div class="wrapper">
<ul id="control_gen_4" class="nav main-nav">
<li class="nav-item">
<a href="/Linked/home/<%=request.getSession().getAttribute("user") %>" class="nav-link">
Home
</a>
</li>
<li class="nav-item">
<a href="/Linked/search" class="nav-link">
Search
</a>
</li>
<li class="nav-item">
<a href="" class="nav-link">
Profile
</a>
<ul class="sub-nav" id="profile-sub-nav">
<li>
<a href="/Linked/user-profile/<%= request.getSession().getAttribute("user")%>">
Edit Profile
</a>
</li>

</ul>
</li>
<li class="nav-item">
<button id="nav-link-interests" class="nav-link no-link">
Interests
</button>
<ul class="sub-nav" id="interests-sub-nav">
<li>
<a href="/Linked/company">
Companies
</a>
</li>
</ul>
</li>
</ul>
<b style="float:right"><font color="white"><%=request.getSession().getAttribute("name") %></font></b><br>
<b style="float:right"><font color="white">Last login time: <%=request.getSession().getAttribute("lastLogin") %></font></b>
</div>
</div>

<br>
<br>
	<div style="overflow:auto;padding: 0px;width:800px;margin: auto;background-color: #FFF;padding-left: 10px;padding-bottom: 10px;box-shadow: 0px 10px 20px 3px #D3D3D3">
	<h2><b>Search</b></h2>
	<form id="job_search" method="get" action="${pageContext.request.contextPath}/search/job">
	<p>Enter name of the job to be searched</p>
	<input type="text" id="name" name="name"/>
	<input type="submit" value="Search"/>
	</form>
	<br>
	<br>
	<form id="person_search" method="get" action="${pageContext.request.contextPath}/search/people">
	<p>Enter email of the person to be searched</p>
	<input type="text" id="name" name="name"/>
	<input type="submit" value="Search"/>	
	</form>
	<br>
	<br>
	<form id="company_search" method="get" action="${pageContext.request.contextPath}/search/company">
	<p>Enter name of the company to be searched</p>
	<input type="text" id="name" name="name"/>
	<input type="submit" value="Search"/>
	</form>	
	<br>
	<br>
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
	</div>
</body>
</html>