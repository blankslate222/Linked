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
<body style="overflow:auto;height:100px">

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
<a href="" class="nav-link">
Home
</a>
</li>
<li class="nav-item">
<a href="" class="nav-link">
Profile
</a>
<ul class="sub-nav" id="profile-sub-nav">
<li>
<a href="">
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

	
		<h1><b><font size="20" color="#008CC9">${user.firstName} ${user.lastName}</font></b></h1>
		
		<p><b>Companies that you are following</b></p>
		<c:forEach items="${companies}" var="company"
			varStatus="status">
			${company}
		</c:forEach>
	<p><b>Status posts of the companies you are following</b></p>
	<c:forEach items="${posts}" var="post"
			varStatus="status">
			${post}
		</c:forEach>
		</div>
		</div>
</body>
</html>