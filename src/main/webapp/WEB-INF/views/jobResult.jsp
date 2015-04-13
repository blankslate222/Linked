<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel='stylesheet' href='../resources/stylesheets/madhur.css' />
<script src="http://ajax.googleapis.com/ajax/libs/prototype/1.7.2.0/prototype.js"></script>
<script type="text/javascript">

function applyJob(jobId,company,prefix) {
	new Ajax.Request(prefix+'/apply/job', {
  		method:'get',
  		parameters:{jobId:jobId,company:company},
  		onSuccess: function(transport) {
  			document.getElementById("apply-button").style.display="none";
  			
  			
  			document.getElementById("result").innerHTML="You applied to this job";
  			
  		},
  		onFailure: function() { 
  			
  		}
	});
}

function applyJobStatus(jobId,company,prefix) {
	
	new Ajax.Request(prefix+'/apply/job/status', {
  		method:'get',
  		parameters:{jobId:jobId,company:company},
  		onSuccess: function(transport) {
  			if(transport.responseText.trim() === "true") {
  				document.getElementById("apply-button").style.display="none";
  	  			document.getElementById("result").innerHTML="You applied to this job already!!!";
  			}
  			
  			
  		},
  		onFailure: function() { 
  			
  		}
	});
}

</script>
<title>Job</title>
</head>
<body onload="applyJobStatus('${jobPosting.id}','${jobPosting.companyName}','${pageContext.request.contextPath}')">
<div id="header" style="position:absolute"
		class="global-header responsive-header nav-v5-2-header responsive-1 remote-nav"
		>
		<div id="top-header">
			<div class="wrapper">
				<div class="header-section first-child">
					<h2 class="logo-container" tabindex="0">
						<img class="logo" width="30" height="30" style="top:4px;position:absolute;left:5px;" alt="LinkedIn"
							src="../resources/images/logo.png">
					</h2>
					
					
					
		
				</div>
				<a style="float: right" href="${pageContext.request.contextPath}/signout"> <b><font
						color="white">SignOut</font></b>
				</a>
			</div>
		</div>
		<div class="responsive-nav">
<div class="wrapper">
<ul id="control_gen_4" class="nav main-nav">
<li class="nav-item">
<a href="${pageContext.request.contextPath}/home/<%=request.getSession().getAttribute("user") %>" class="nav-link">
Home
</a>
</li>
<li class="nav-item">
<a href="${pageContext.request.contextPath}/search" class="nav-link">
Search
</a>
</li>
<li class="nav-item">
<a href="" class="nav-link">
Profile
</a>
<ul class="sub-nav" id="profile-sub-nav">
<li>
<a href="${pageContext.request.contextPath}/user-profile/<%= request.getSession().getAttribute("user")%>">
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
<a href="${pageContext.request.contextPath}/company">
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

<input id="apply-button" type="button" value="Apply" onclick="applyJob('${jobPosting.id}','${jobPosting.companyName}','${pageContext.request.contextPath}')" style="background-color: #F6E312;border-color: #E9AC1A;
    border-top-color: #E9AC1A;
    border-right-color-value: #E9AC1A;
    border-bottom-color: #E9AC1A;
    border-left-color-value: #E9AC1A;background-image: -moz-linear-gradient(center top , #F6E312 0%, #F9C80D 100%);">
    <div id="result"></div>

<sf:form id="applyJob" modelAttribute="applyJob" action="" method="GET">
<table>
<tr><td><b>Job Id:</b></td><td>${jobPosting.id}</td></tr>
<tr><td><b>Company Name:</b></td><td>${jobPosting.companyName}</td></tr>
<tr><td><b>Job Name:</b></td><td>${jobPosting.jobName}</td></tr>
<tr><td><b>Description:</b></td><td>${jobPosting.description}</td></tr>
<tr><td><b>Expiry:</b></td><td>${jobPosting.expiry}</td></tr>

</table>
</sf:form>
</div>
</body>
</html>