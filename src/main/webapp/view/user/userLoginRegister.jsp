<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/formItems.tld" prefix="formItem" %>
<% 
	String pageStateName = request.getAttribute("servletPath").equals("/user/login") ? "Login" : "Register"; 
	Object pageError = request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<title>Insert title here</title>
</head>
<body class="overflow-x-hidden min-vh-100">
	<%@ include file="/components/navbar.jsp" %>
	<main class="px-5 w-100 d-flex flex-column align-items-center" style="padding-top: 5rem;">
		<form action="<%= request.getContextPath() + request.getAttribute("servletPath") %>" method="POST" class="form-container w-50 my-5">
			<h2><%=pageStateName %></h2>
			<%if (pageStateName.equals("Login")) { %>
			
				<formItem:textField name="email" label="Email:" placeholder="Email" />
				<formItem:textField name="password" label="Senha:" placeholder="Senha" />
				
			<%} else { %>
				
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
				
			<%} %>
			
			<%if (pageError != null && !pageError.equals("")) { %>
				<div class="d-grid gap-1 d-md-flex w-100 border-start border-danger bg-danger-subtle mb-3 p-2">
					<p>Erro: <%=pageError.toString() %></p>
				</div>
			<%} %>
			
			<div class="d-grid gap-1 d-md-flex justify-content-md-end">
				<button type="submit" class="btn btn-primary"><%=pageStateName %></button>
				<a type="button" class="btn btn-secondary" href="<%= request.getContextPath() %>/home">Cancel</a>
			</div>
		</form>
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
	<script type="text/javascript">		
		function updateDocumentInput() {			
			let documentLabel = $('div:has(#document) > label');
			let documentInput = $('div:has(#document) > input');
			let selectedOption = $('#personType option:selected');
			let documentHiddenField = $('#personTypeId');
			
			let newLabelText;
			let newPlaceholderText;
			let newPersonTypeId;
			
			if ($(selectedOption).html() === "CPF") {
				newLabelText = "CPF:";
				newPlaceHolder = "000.000.000-00";
				newPersonTypeId = 0;
			} else {
				newLabelText = "CNPJ:";
				newPlaceHolder = "00.000/0001-00";
				newPersonTypeId = 1;
			}
			$(documentHiddenField).attr("value", newPersonTypeId);
			$(documentLabel).html(newLabelText);
			$(documentInput).attr("placeholder", newPlaceHolder);
		}
	</script>
</html>