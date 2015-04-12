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
	<div id="header"
		class="global-header responsive-header nav-v5-2-header responsive-1 premium-member remote-nav"
		>
		<div id="top-header">
			<div class="wrapper">
				<div class="header-section first-child">
					<h2 class="logo-container" tabindex="0">
						<img class="logo" width="30" height="30" style="top:4px;position:absolute;left:5px;" alt="LinkedIn"
							src="/Linked/resources/images/logo.png">
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
<a href="/Linked/company">
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