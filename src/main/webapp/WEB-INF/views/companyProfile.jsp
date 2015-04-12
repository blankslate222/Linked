<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%

String email = (String) request.getSession().getAttribute("user");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel='stylesheet' href='/Linked/resources/stylesheets/madhur.css' />
<title>Company Profile</title>
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


<h1 style="position:absolute;right:200px;top:80px"><a href="/Linked/company/manage">Manage Companies</a></h1>
<div id="linked-main-div">

<div style="position:absolute;top:150px;left:400px">
<h1 style="left:150px;position:relative"><b>Company profile</b></h1>
<br>
<sf:form id="companyProfile" modelAttribute="companyProfile" action="${pageContext.request.contextPath}/company" method="post">
<table>
<tr><td>Company Name:</td><td><sf:input size="24" path="company_id" id="company_id" name="company_id" type="text" required = "required"/></td></tr>
<tr><td>Company Overview:</td><td><sf:textarea path="overview" id="overview" name="overview" required = "required"/></td></tr>
<tr><td>Company URL:</td><td><sf:input size="24" path="url" id="url" name="url" required = "required"/></td></tr>
<tr><td>Your email address at company:&nbsp</td><td><sf:input size="24" path="email" id="email" name="email" type="email" value = "<%=email %>" readonly="true" required = "required"/></td></tr>
<tr><td></td><td></td></tr>
<tr><td><input  style="left:180px;position:relative" type="submit" id="company" value="create"/></td></tr>
</table>
</sf:form>
	</div>
	

</div>


</div>


<br>
</body>
</html>