<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel='stylesheet' href='/linked/resources/stylesheets/madhur.css' />
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
	
	function updateReview(obj) {
		var url = document.getElementById("url-"+obj).value;
		var overview = document.getElementById("overview-"+obj).value;
		new Ajax.Request('/linked/company/'+obj, {
	  		method:'put',
	  		parameters:{url:url, overview:overview},
	  		onSuccess: function(transport) {
	  			location.reload(true);
	  			
	  		},
	  		onFailure: function() { 
	  			
	  		}
		});
		
	}
</script>
</head>
<body>

<div id="header"
		class="global-header responsive-header nav-v5-2-header responsive-1 premium-member remote-nav"
		role="banner">
		<div id="top-header">
			<div class="wrapper">
				<div class="header-section first-child">
					<h2 class="logo-container" tabindex="0">
						<img class="logo" width="30" height="30" style="top:4px;position:absolute;left:5px;" alt="LinkedIn"
							src="/linked/resources/images/logo.png">
					</h2>
					
					<div style="left:135px;top:4px;position:absolute;height:0px" id="control_gen_2" class="search-scope global-nav-styled-dropdown">
<span class="label"></span><select name="type" id="main-search-category" class="search-category">

<option class="people" data-li-advanced-link="/vsearch/p?adv=true&amp;trk=advsrch" data-li-styled-dropdown-class="people" data-li-search-action="/vsearch/p" data-li-ghost-text="Search people..." data-li-trk-code="vsrp_people_vertical_selector_item" title="Keyword, name, company or title" value="people">People</option>
<option class="jobs" data-li-advanced-link="/vsearch/j?adv=true&amp;trk=hb_advjs" data-li-styled-dropdown-class="jobs" data-li-search-action="/vsearch/j" data-li-ghost-text="Search jobs..." data-li-trk-code="vsrp_jobs_vertical_selector_item" title="Keyword, company or job title" value="jobs">Jobs</option>
<option class="companies" data-li-styled-dropdown-class="companies" data-li-search-action="/vsearch/c" data-li-ghost-text="Search companies..." title="Keyword" data-li-trk-code="vsrp_companies_vertical_selector_item" value="companies">Companies</option>

</select>
<ul class="search-selector"></ul></div>
					
		<span style="left:250px;position: relative; display: inline-block; direction: ltr;" class="twitter-typeahead"><input style="top:5px;position: relative; vertical-align: top;" spellcheck="false" aria-autocomplete="list" aria-live="polite" aria-labelledby="main-search-box-label" aria-owns="tt-dataset-GLHD" role="combobox" name="keywords" id="main-search-box" class="search-term typeahead-instant tt-input" value="" autocomplete="off" dir="ltr" placeholder="Search for people, jobs, companies, and more..." type="text" size="50px"><pre style="position: absolute; visibility: hidden; white-space: pre; font-family: Helvetica,FreeSans,&quot;Liberation Sans&quot;,Helmet,Arial,sans-serif; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; word-spacing: 0px; letter-spacing: 0px; text-indent: 0px; text-rendering: optimizelegibility; text-transform: none;" aria-hidden="true"></pre><span style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none; right: auto;" class="tt-dropdown-menu clipped typeahead-actions colorful-suggestions blue-variant"><div class="tt-dataset-GLHD"></div></span></span>
				</div>
			</div>
		</div>
		<div class="responsive-nav" id="responsive-nav-scrollable">
<div class="wrapper">
<ul id="control_gen_4" class="nav main-nav" role="navigation">
<li class="nav-item">
<a href="/home?trk=nav_responsive_tab_home" class="nav-link">
Home
</a>
</li>
<li class="nav-item">
<a href="https://www.linkedin.com/profile/view?id=148982907&amp;trk=nav_responsive_tab_profile" class="nav-link">
Profile
</a>
<ul class="sub-nav" id="profile-sub-nav">
<li>
<a href="/profile/edit?trk=nav_responsive_sub_nav_edit_profile">
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
<a href="/linked/company">
Companies
</a>
</li>
</ul>
</li>
</ul>
<script id="controlinit-http-12274-exec-18259778-6" type="text/javascript+initialized" class="li-control">LI.Controls.addControl('control-http-12274-exec-18259778-6','NavAccessibility',{linkElement:"nav-item",subNav:"sub-nav",activeClass:"active"});</script>

<script id="controlinit-http-12274-exec-18259778-7" type="text/javascript+initialized" class="li-control">LI.Controls.addControl('control-http-12274-exec-18259778-7','NavAccessibility',{linkElement:"nav-item",subNav:"sub-nav",activeClass:"active"});</script>
</div>
</div>

<br>
<br>

<div style="padding: 0px;width:800px;margin: auto;background-color: #FFF;padding-left: 10px;padding-bottom: 10px;box-shadow: 0px 10px 20px 3px #D3D3D3">

<h3><b>Your Companies</b></h3>
	<c:if test="${ not empty companyProfile }">
		<ul>
			<c:forEach var="job" items="${companyProfile}">
				<br/>
				<div style="width:100%; height:1px; background:rgb(190,190,190)"></div>
				<div style="float:right"> 
   					<img alt="" style="border-radius: 4px;" src="/linked/resources/images/edit.png" height="16" width="16" onclick="enableEditing('${job.company_id}')"></img>
   				</div>
				<div>
				
				<li><b><a href="${pageContext.request.contextPath}/company/${job.company_id}">${job.company_id}</a></b></li>
				<div id="status-"+${job.company_id}>
					<textarea rows="1" cols="40" placeholder="What you upto?..."></textarea>
				</div>
				<div>
					<input type="button" action="postStatus('${job.company_id}')" value="Post">
				</div>
				<div id="div-url-${job.company_id}" >
					<span>URL: ${job.url}</span>
				</div>
				
				<div>
					<input style="display:none" id="url-${job.company_id}" value="${job.url}"/>
				</div>
				<div id="div-overview-${job.company_id}" >
					<span>Overview: ${job.overview}</span>
				</div>
				<div>
   					<textarea style="width: 400px; height: 50px;display:none" id="overview-${job.company_id}" >${job.overview}</textarea>
   				</div>
				</div>
				<button id="button-${job.company_id}" type="button" value="Update" onclick="updateReview('${job.company_id}')" style="display:none" class="ybtn ybtn-primary ytype">Update</button>
			</c:forEach>
		</ul>
	</c:if>
</div>
</body>
</html>