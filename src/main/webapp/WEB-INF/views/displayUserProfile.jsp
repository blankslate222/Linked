<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel='stylesheet' href='/Linked/resources/stylesheets/madhur.css' />
<script src="http://ajax.googleapis.com/ajax/libs/prototype/1.7.2.0/prototype.js"></script>
<script type="text/javascript">

function followUser(str) {
	alert(str);
	new Ajax.Request('/Linked/follow/user', {
  		method:'get',
  		parameters:{email:str},
  		onSuccess: function(transport) {
  			location.reload(true);
  			
  		},
  		onFailure: function() { 
  			
  		}
	});
}

function followUserStatus(str) {
	new Ajax.Request('/Linked/follow/user/status', {
  		method:'get',
  		parameters:{email:str},
  		onSuccess: function(transport) {
  			if(transport.responseText.trim() == "true") {
  				document.getElementById('follow-button').style.display="none";
  			} else {
  				
  			}
  			
  		},
  		onFailure: function() { 
  			
  		}
	});
}

</script>
<title>Linked | User</title>
</head>
<body onload="followUserStatus('${userProfile.email}')">
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
<h1><b>User profile</b></h1>
<br/>
<c:if test="${sessionScope.user ne userProfile.email}">
<input id="follow-button" type="button" value="follow" onclick="followUser('${userProfile.email}')" style="background-color: #F6E312;border-color: #E9AC1A;
    border-top-color: #E9AC1A;
    border-right-color-value: #E9AC1A;
    border-bottom-color: #E9AC1A;
    border-left-color-value: #E9AC1A;background-image: -moz-linear-gradient(center top , #F6E312 0%, #F9C80D 100%);">
</c:if>
<table>
<tr><td>Bio:</td><td>${userProfile.summary}</td></tr>
<tr><td>Highest Degree:</td><td>${userProfile.highestDegree}</td></tr>
<tr><td>University:</td><td>${userProfile.university}</td></tr>
<tr><td>Skills:</td><td>${userProfile.skills}</td></tr>
<tr><td>Certifications:</td><td>${userProfile.certifications}</td></tr>
<tr><td>Experience</td></tr>
<c:forEach items="${userProfile.experience}" var="experience" varStatus="status">
 	<tr><td>Company:</td>
 	<td>${experience.getCompany()}</td>
 	<td>Number of Years:</td>
 	<td>${experience.getNumberOfYears()}</td></tr>
 </c:forEach>
 
 <tr><td>Status updates</td></tr>
<c:forEach items="${userProfile.status}" var="statusU" varStatus="status">
 	<tr>
 	<td>${statusU}</td>
 	</tr>
 </c:forEach>
</table>
<br/>
<c:if test="${sessionScope.user eq userProfile.email}">
<a href="${pageContext.request.contextPath}/user-profile/update">Update Profile</a>
</c:if>
</div>
</div>
</body>
</html>