<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel='stylesheet' href='/Linked/resources/stylesheets/madhur.css' />
<title>Linked | User Profile</title>
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
				<a style="float: right" href="/Linked/signout"> <b><font
						color="white">SignOut</font></b>
				</a>
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
<h3><b>Build your profile</b></h3>
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
</div>
</body>
</html>