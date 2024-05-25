<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/formItems.tld" prefix="form" %>
<%
	String currentPageStateName = (request.getAttribute("pageState").equals("/user/login")) ? "Login" : "Register"; 
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/formComponents.css">
	<title>Insert title here</title>
</head>
<body>
	<%@ include file="/components/navbar.jsp" %>
	<main>
		<div class="form-container">
			<h2><%=currentPageStateName %></h2>
			<div class="form-line-container">
				<form:textField name="first-name" label="Nome:" placeholder="Nome" />
				<form:textField name="last-name" label="Sobrenome:" placeholder="Sobrenome" />
			</div>
			<form:textField name="email" label="Email:" placeholder="Email" />
			
			<div class="btn-container">
				<a type="button" class="btn btn-primary" href="<%= request.getContextPath() + "/" + request.getAttribute("pageState")%>"><%=currentPageStateName %></a>
				<a type="button" class="btn btn-secondary" href="<%= request.getContextPath() %>/home">Cancel</a>
			</div>
		</div>
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>