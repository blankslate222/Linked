<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Company Profile</title>
</head>
<body>

<h3>company profile</h3>
<sf:form id="companyProfile" modelAttribute="companyProfile" action="${pageContext.request.contextPath}/company" method="post">
<table>
<tr><td>Name:</td><td><sf:input path="company_id" id="company_id" name="company_id" type="text" required = "required"/></td></tr>
<tr><td>Overview:</td><td><sf:input path="overview" id="overview" name="overview" required = "required"/></td></tr>
<tr><td>Url:</td><td><sf:input path="url" id="url" name="url" required = "required"/></td></tr>
</table>
</sf:form>
</body>
</html>