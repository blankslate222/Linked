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
	
	function postStatus(obj,prefix) {
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
	  			buildUI(transport.responseText);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
	
	function buildUI(str) {
		var obj = JSON.parse(str);
		var table = document.createElement("table");
		
		for(var i=0;i<obj.length;i++) {
			var tr = document.createElement("tr");
			var td1 = document.createElement("td");
			td1.innerHTML = "<b>Job Id: </b>"+obj[i].id+"&nbsp;";
			var td2 = document.createElement("td");
			td2.innerHTML = "<b>Job Name: </b>"+obj[i].jobName+"&nbsp;";
			var td3 = document.createElement("td");
			td3.innerHTML = "<b>Available till: </b>"+obj[i].expiry+"&nbsp;";
			tr.appendChild(td1);
			tr.appendChild(td2);
			tr.appendChild(td3);
			table.appendChild(tr);
			var tr2 = document.createElement("tr");
			var td4 = document.createElement("td");
			td4.innerHTML = obj[i].description;
			tr2.appendChild(td4);
			table.appendChild(tr2);
			var tr3 = document.createElement("tr");
			var td5 = document.createElement("td");
			tr3.appendChild(td5);
			table.appendChild(tr3);
		}
		document.getElementById('job-detail').appendChild(table);
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
	
	function followCompany(str,prefix) {
		new Ajax.Request(prefix+'/follow/company/', {
	  		method:'get',
	  		parameters:{id:str},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
	}
	
	function followCompanyStatus(str,prefix) {
		new Ajax.Request(prefix+'/follow/company/status', {
	  		method:'get',
	  		parameters:{id:str},
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
</head>
<body onload="getJobs('${companyProfile.company_id}','${pageContext.request.contextPath}');followCompanyStatus('${companyProfile.company_id}','${pageContext.request.contextPath}');">

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
<div style="padding: 0px;width:800px;margin: auto;background-color: #FFF;padding-left: 10px;padding-bottom: 10px;box-shadow: 0px 10px 20px 3px #D3D3D3">
<br>
<br>
<h3><b><font color="blue" size="10px" style="font-size:35px">${companyProfile.company_id}</font></b></h3>

<br>

<div style="">
      <p class="followers-count">
            <span class="followers-count-num">${companyProfile.numberOfFollowers}</span> <span class="stats-type">follower(s)</span>
      
      <input id="follow-button" type="button" value="follow" onclick="followCompany('${companyProfile.company_id}','${pageContext.request.contextPath}')" style="background-color: #F6E312;border-color: #E9AC1A;
    border-top-color: #E9AC1A;
    border-right-color-value: #E9AC1A;
    border-bottom-color: #E9AC1A;
    border-left-color-value: #E9AC1A;background-image: -moz-linear-gradient(center top , #F6E312 0%, #F9C80D 100%);">
    
    
  </div>


	
	<c:if test="${ not empty companyProfile }">
		<div> 
   					<img alt="" style=" float:right;border-radius: 4px;" src="../resources/images/company.jpeg" height="100" width="100" onclick="enableEditing('${job.company_id}'),'${pageContext.request.contextPath}'"></img>
   				</div>
		<ul>
			
				<br/>
				<div style="width:100%; height:1px; background:rgb(190,190,190)"></div>
				
				<div>
				
				<br>
				
				<div id="div-overview-${companyProfile.company_id}" >
					<span> ${companyProfile.overview}</span>
				</div>
				<br>
				<div id="div-url-${companyProfile.company_id}" >
					<span><b>URL</b></span><br>
					<span>${companyProfile.url}</span>
				</div>
				
				</div>
				<br>
				<div>
				<b>Status Posts</b>
				<c:if test="${ not empty companyProfile.statusPost }">
				<c:forEach var="s" items="${companyProfile.statusPost}"> 
				<br/>
				<div>
				
					<p>${s}</p>
					
				</div>
				
				
				</c:forEach>
				</c:if>
				</div>
				<br>
				<div>
				<b>Jobs</b>
				<br>
				<dir id="job-detail"></dir>
<%-- 				<c:if test="${ not empty companyProfile.jobs}"> --%>
<%-- 				<c:forEach var="j" items="${companyProfile.jobs}">  --%>
<!-- 				<br/> -->
<!-- 				<div> -->
				
<%-- 					<p>${j}</p> --%>
					
<!-- 				</div> -->
				
				
<%-- 				</c:forEach> --%>
<%-- 				</c:if> --%>
				</div>
				
				
		
		</ul>
	</c:if>
</div>
</body>
</html>