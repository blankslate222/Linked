<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel='stylesheet' href='./resources/stylesheets/style.css' />
<link rel='stylesheet' href='../resources/stylesheets/madhur.css' />
<script src="http://ajax.googleapis.com/ajax/libs/prototype/1.7.2.0/prototype.js"></script>
<title>Home Page</title>
</head>

<body>

	<div id="header">
		<div class="container">

			<h1>
				<img class="logo" width="132" height="32" alt="LinkedIn"
					src="https://static.licdn.com/scds/common/u/img/logos/logo_132x32_2.png">
			</h1>
			<p class="textad"></p>
			<div class="login">
				<sf:form id="signin" modelAttribute="user"
					action="${pageContext.request.contextPath}/signin" method="post">

					<fieldset>
						<ul id="control_gen_1">
							<li><label for="session_key-login">Email address</label>
								<div class="fieldgroup">
									<span id="session_key-login-error" class="error"></span> <sf:input
										id="session_key-login" type="email" data-ime-mode-disabled=""
										size="27" tabindex="1" autofocus="" value=""
										path="email" required = "required"/>
								</div></li>
							<li><label for="session_password-login">Password</label>
								<div class="fieldgroup">
									<span id="session_password-login-error" class="error"></span> 
									<sf:input
										id="session_password-login" type="password" size="27"
										tabindex="2" value="" path="password" required = "required"/>
								</div></li>
							<li class="button"><input type="submit" id="signin"
								class="btn-secondary" name="signin" value="Sign In" tabindex="3" style="position:absolute;right:85px;top:22px"></li>
						</ul>
					</fieldset>
				</sf:form>
			</div>
		</div>
	</div>



	<div id="main-wrapper">
		<div id="main">
			<div id="global-error"></div>
			<header>
			<div id="content">
				<font size="40"> <b>Join the world's largest professional
						network.</b>
				</font>
			</div>
			</header>
			<section>
			<div class="two-row-image">
				<img width="150" height="150"
					src="https://static.licdn.com/scds/common/u/images/apps/home/guesthome/ghp_international_1_150x150_v1.png"
					alt="Male Headshot"> <img width="150" height="150"
					src="https://static.licdn.com/scds/common/u/images/apps/home/guesthome/ghp_international_2_150x150_v1.png"
					alt="Female Headshot"> <img width="150" height="150"
					src="https://static.licdn.com/scds/common/u/images/apps/home/guesthome/ghp_international_3_150x150_v1.png"
					alt="Male Headshot"> <img width="150" height="150"
					src="https://static.licdn.com/scds/common/u/images/apps/home/guesthome/ghp_international_4_150x150_v1.png"
					alt="Female Headshot"> <img width="150" height="150"
					src="https://static.licdn.com/scds/common/u/images/apps/home/guesthome/ghp_international_5_150x150_v1.png"
					alt="Male Headshot"> <img width="150" height="150"
					src="https://static.licdn.com/scds/common/u/images/apps/home/guesthome/ghp_international_6_150x150_v1.png"
					alt="Male Headshot">
			</div>
			</section>

			<section>
			<div id="module-id3" class="leo-module mod-feat jointoday">
				<sf:form id="signup" class="feature" modelAttribute="user"
					action="${pageContext.request.contextPath}/signup" method="post">

					<fieldset>
						<legend align="center">Sign Up</legend>
						<table cellspacing="10" cellpadding="10" border="10">
							<tr>
								<td><sf:input id="firstName-coldRegistrationForm" type="text"
									placeholder="First name" path="firstName" value=""
									autocomplete="on" size="50" maxlength="20" tabindex="5"
									required = "required"/></td>
							</tr>
							<tr>
								<td><sf:input id="lastName-coldRegistrationForm" type="text"
									placeholder="Last name" path="lastName" value=""
									autocomplete="on" size="50" maxlength="40" tabindex="6" 
									required = "required"/></td>
							</tr>
							<tr>
								<td><sf:input id="email-coldRegistrationForm" type="email"
									placeholder="Email address" path="email" value=""
									autocomplete="on" size="50" maxlength="128" tabindex="7"
									data-ime-mode-disabled="" required = "required"/></td>
							</tr>
							<tr>
								<td><sf:input id="password-coldRegistrationForm"
									type="password" placeholder="Password" path="password"
									size="50" value="" tabindex="8" required = "required"/></td>
							</tr>
							<tr>
								<td><input id="btn-submit" class="btn-action" type="submit"
									tabindex="9" value="Join now" name=""></td>
							</tr>
						</table>
					</fieldset>
				</sf:form>
				<c:if test="${not empty msg }">
				<p>${msg}</p>
				</c:if>
			</section>
		</div>
	</div>

</body>
</html>
