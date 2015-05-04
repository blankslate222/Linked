<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel='stylesheet' href='../resources/stylesheets/madhur.css' />
<script src="http://ajax.googleapis.com/ajax/libs/prototype/1.7.2.0/prototype.js"></script>
<title>Manage Companies</title>
<script type="text/javascript">
	function enableEditing(obj) {
		document.getElementById("div-url-"+obj).style.display="none";
		document.getElementById("div-overview-"+obj).style.display="none";
		document.getElementById("url-"+obj).style.display="block";
		document.getElementById("overview-"+obj).style.display="block";
		document.getElementById("button-"+obj).style.display="block";
	}
	
	function enableJob(obj) {
		
		document.getElementById("job-"+obj).style.display="block";
		
	}
	
	function updateReview(obj,prefix) {
		var url = document.getElementById("url-"+obj).value;
		var overview = document.getElementById("overview-"+obj).value;
		new Ajax.Request(prefix+'/company/'+obj, {
	  		method:'put',
	  		parameters:{url:url, overview:overview},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
		
	}
	
	function postStatus(obj, prefix) {
		var status = document.getElementById("status-"+obj).value;
		
		new Ajax.Request(prefix+'/company/status/'+obj, {
	  		method:'post',
	  		parameters:{status:status},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
	
	function deleteStatus(obj,name,prefix) {
		new Ajax.Request(prefix+'/company/status/'+name, {
	  		method:'delete',
	  		parameters:{status:obj},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
	
	function createJob(obj,prefix) {
		var jobId = document.getElementById(obj+"-job-id").value;
		var jobName = document.getElementById(obj+"-jobName").value;
		var desc = document.getElementById(obj+"-description").value;
		var expiry = document.getElementById(obj+"-expiry").value;
		new Ajax.Request(prefix+'/company/job/'+obj, {
	  		method:'post',
	  		parameters:{jobId:jobId,jobName:jobName,desc:desc,expiry:expiry},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
	
	function getJobs(obj,prefix) {
		new Ajax.Request(prefix+'/company/job/'+obj, {
	  		method:'get',
	  		onSuccess: function(transport) {
	  			
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
	
	function removeJobs(obj,jobId,prefix) {
		new Ajax.Request(prefix+'/company/job/'+jobId, {
	  		method:'delete',
	  		parameters:{jobId:obj},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
</script>
</head>
<body >

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
<li class="nav-item">
<a href="${pageContext.request.contextPath}/recommend/career-path" class="nav-link">
Career Path
</a>
</li>
</ul>
<b style="float:right"><font color="white"><%=request.getSession().getAttribute("name") %></font></b><br>
<b style="float:right"><font color="white">Last login time: <%=request.getSession().getAttribute("lastLogin") %></font></b>
</div>
</div>

<br>
<br>

<div style="overflow:auto;padding: 0px;width:800px;margin: auto;background-color: #FFF;padding-left: 10px;padding-bottom: 10px;box-shadow: 0px 10px 20px 3px #D3D3D3">



<h3><b>Your Companies</b></h3>
	<c:if test="${ not empty companyProfile }">
		<ul>
			<c:forEach var="job" items="${companyProfile}">
				<br/>
				<div style=" height:1px; background:rgb(190,190,190)"></div>
				<div style="float:right"> 
   					<img alt="" style="border-radius: 4px;" src="../resources/images/edit.png" height="16" width="16" onclick="enableEditing('${job.company_id}','${pageContext.request.contextPath}')"></img>
   				</div>
   				<div style="float:right"> 
   					<img alt="" style="border-radius: 4px;" src="../resources/images/job.png" height="16" width="16" onclick="enableJob('${job.company_id}','${pageContext.request.contextPath}')"></img>
   				</div>
				<div>
				
				<li><b><a href="${pageContext.request.contextPath}/company/${job.company_id}">${job.company_id}</a></b></li>
				<div id="status-"+${job.company_id}>
					<textarea id="status-${job.company_id}" rows="1" cols="40" placeholder="What you upto?..."></textarea>
				</div>
				<div>
					<input type="button" onclick="postStatus('${job.company_id}','${pageContext.request.contextPath}')" value="Post">
				</div>
				<div id="job-${job.company_id}" style="display:none">

								<table>
									<tr>
										<td>Job Id:</td>
										<td><input id="${job.company_id}-job-id" required="required" /></td>
									</tr>
									
									<tr>
										<td>Job Name:</td>
										<td><input id="${job.company_id}-jobName" name="jobName"
												required="required" /></td>
									</tr>
									<tr>
										<td>Description:</td>
										<td><input path="description" id="${job.company_id}-description"
												name="description" required="required" /></td>
									</tr>
									<tr>
										<td>Expiry:</td>
										<td><input id="${job.company_id}-expiry"
												name="expiry" required="required" /></td>
									</tr>
									<tr>
										<td><input type="submit" id="postJob" value="POST JOB" onclick="createJob('${job.company_id}','${pageContext.request.contextPath}')"/></td>
									</tr>
								</table>

							</div>
							<br>
							
				<div id="div-url-${job.company_id}" >
					<span><b>URL:</b> ${job.url}</span>
				</div>
				
				<div>
					<input style="display:none" id="url-${job.company_id}" value="${job.url}"/>
				</div>
				
				<div id="div-overview-${job.company_id}" >
					<span><b>Overview:</b> ${job.overview}</span>
				</div>
				<div>
   					<textarea style="width: 400px; height: 50px;display:none" id="overview-${job.company_id}" >${job.overview}</textarea>
   				</div>
				</div>
				<button id="button-${job.company_id}" type="button" value="Update" onclick="updateReview('${job.company_id}','${pageContext.request.contextPath}')" style="display:none" class="ybtn ybtn-primary ytype">Update</button>
				<div>
				<b>Status Posts</b>
				<c:if test="${ not empty job.statusPost }">
				<c:forEach var="s" items="${job.statusPost}"> 
				<br/>
				<div>
				<img alt="" style="border-radius: 4px;float:right" src="../resources/images/Delete.png" height="16" width="16" onclick="deleteStatus('${s}','${job.company_id}','${pageContext.request.contextPath}')"></img>
					<p>${s}</p>
					
				</div>
				
				
				</c:forEach>
				</c:if>
				</div>
				
				<div>
				<b>Jobs</b>
				<c:if test="${ not empty job.jobs}">
				<c:forEach var="j" items="${job.jobs}"> 
				<br/>
				<div>
				<img alt="" style="border-radius: 4px;float:right" src="../resources/images/Delete.png" height="16" width="16" onclick="removeJobs('${j}','${job.company_id}','${pageContext.request.contextPath}')"></img>
					<p>${j}</p>
					
				</div>
				
				
				</c:forEach>
				</c:if>
				</div>
				
				
			</c:forEach>
		</ul>
	</c:if>
</div>
</div>
</div>
</body>
</html>