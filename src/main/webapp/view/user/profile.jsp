<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/formItems.tld" prefix="formItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.stocks.Stock" %>
<%
	Object pageError = request.getAttribute("error");
	User userProfileData = null;
	if(request.getAttribute("userProfileData") != null)
		userProfileData = (User) request.getAttribute("userProfileData");
	else if (request.getAttribute("user") != null)
		userProfileData = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<title>Stocks - VcRiquinho</title>
</head>
<body class="overflow-x-hidden min-vh-100">
	<%@ include file="/components/navbar.jsp" %>
	<main class="px-5 w-100 d-flex flex-column" style="padding-top: 5rem;">	
		<h1>Profile: <%=userProfileData.name %></h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>
		
		<div class="w-50"><formItem:textField name="name" label="Nome de Usuário:" placeholder="Nome" /></div>
		<div class="w-100"><formItem:textField name="completeName" label="Nome Completo:" placeholder="Nome Completo" /></div>
		<div class="row">
			<div class="col"><formItem:textField name="email" label="Email:" placeholder="Email" /></div>
			<div class="col"><formItem:textField name="password" label="Senha:" placeholder="Senha" /></div>
		</div>
		<div class="row">
			<div class="col-md-6"><formItem:textField name="phone" label="Telefone:" placeholder="(11)90000-0000" /></div>
			<div class="col-md-3"><formItem:comboBox name="personType" label="Tipo:" onChange="updateDocumentInput();" dataSource="CPF,CNPJ" /></div>
			<div class="col-md-3"><formItem:textField name="document" label="CPF:" placeholder="000.000.000-00" /></div>
		</div>
		<input id="personTypeId" name="personTypeId" type="hidden" value="0">				
			
		<%if (pageError != null && !pageError.equals("")) { %>
			<div class="d-grid gap-1 d-md-flex w-100 border-start border-danger bg-danger-subtle mb-3 p-2">
				<p>Erro: <%=pageError.toString() %></p>
			</div>
		<%} %>
		
		<div class="d-grid gap-1 d-md-flex justify-content-md-end">
			<button type="submit" class="btn btn-primary">Update</button>
			<a type="button" class="btn btn-secondary" href="<%= request.getContextPath() %>/home">Cancel</a>
		</div>
		
		
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
	<script type="text/javascript">
		function toggleUserInfoForm() {
			$("name").attr("disabled", toggleBooleanProperty(index, attr));
			$("completeName").attr("disabled", toggleBooleanProperty(index, attr));
			$("email").attr("disabled", toggleBooleanProperty(index, attr));
			$("password").attr("disabled", toggleBooleanProperty(index, attr));
			$("phone").attr("disabled", toggleBooleanProperty(index, attr));
			$("personType").attr("disabled", toggleBooleanProperty(index, attr));
			$("document").attr("disabled", toggleBooleanProperty(index, attr));
		}
		
		function toggleBooleanProperty(value) {
			return value == true ? false : true;
		}		
		
	</script>
</html>

