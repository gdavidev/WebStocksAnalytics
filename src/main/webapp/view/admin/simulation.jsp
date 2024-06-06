<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.users.User" %>
<%@ page import="models.users.UserInfo" %>
<%@ page import="models.users.AccountHolder" %>
<%@ page import="models.accounts.*" %>
<%@ page import="models.stocks.Stock" %>
<%
	User targetUser = (User) request.getAttribute("targetUser");
	AccountHolder accountHolder = (AccountHolder) request.getAttribute("targetAccountHolder");
	List<Stock> stockList = (List<Stock>) request.getAttribute("transactionRegistryList");
	
	CheckingAccount checkingAccount = accountHolder.checkingAccount;
	IdrAccount idrAccount = accountHolder.idrAccount;
	AutoInvestmentAccount autoInvAccount = accountHolder.autoInvestmentAccount;
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<title>Simulation - VcRiquinho</title>
</head>
<body class="overflow-x-hidden min-vh-100">
	<%@ include file="/components/navbar.jsp" %>
	<main class="px-5 w-100 d-flex flex-column" style="padding-top: 5rem;">
		<h1>Single User Simulation</h1>
		<h2><%=targetUser.name %> - <%=targetUser.userInfo.completeName %></h2>
		<p><span class="text-bold">Email:</span> <%=targetUser.email %></p>
		<p><span class="text-bold">Document:</span> <%=targetUser.userInfo.document %></p>
		<p><span class="text-bold">Phone:</span> <%=targetUser.userInfo.phone %></p>
		
		<div class="row">
			<div class="col">
				<%if (idrAccount != null) { %>
					<div class="card" style="width: 18rem;">
					  <div class="card-body">
					    <h5 class="card-title">Checking Account</h5>
					    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  </div>
					</div>
				<%} %>
			</div>
			<div class="col">
				<%if (autoInvAccount != null) { %>
					<div class="card" style="width: 18rem;">
					  <div class="card-body">
					    <h5 class="card-title">IDR Account</h5>
					    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  </div>
					</div>
				<%} %>
			</div>
			<div class="col">
				<%if (checkingAccount != null) { %>
					<div class="card" style="width: 18rem;">
					  <div class="card-body">
					    <h5 class="card-title">Auto Invest. Account</h5>
					    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  </div>
					</div>
				<%} %>
			</div>
		</div>
		
		<div class="row">		
			<div class="col">
				<h2 class="table-caption">Stocks owned</h2>
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col" class="text-center">#</th>
							<th scope="col">Code</th>
							<th scope="col">CompanyName</th>
							<th scope="col" class="text-end">Price(R$)</th>
							<th scope="col" class="text-end">Increase</th>
						</tr>
					</thead>
					<tbody>
						<%for (int i = 0; i < stockList.size(); i++) { %>
						<tr>
							<th scope="row" class="text-center"><%=i + 1 %></th>
							<td><%=stockList.get(i).code %></td>
							<td><%=stockList.get(i).companyName %></td>
							<td class="text-end"><%=stockList.get(i).price %></td>
						</tr>						
						<%} %>
					</tbody>					
				</table>
			</div>
			<div class="col">
				<h2 class="table-caption">Analytics</h2>
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">Balance</th>
							<th scope="col" class="text-end">Total Applied</th>
							<th scope="col" class="text-end">Grand Total</th>
						</tr>
					</thead>
					<tbody>
						<%for (int i = 0; i < stockList.size(); i++) { %>
						<tr>
							<th scope="row" class="text-center"><%=i + 1 %></th>
							<td><%=stockList.get(i).code %></td>
							<td><%=stockList.get(i).companyName %></td>
							<td class="text-end"><%=stockList.get(i).price %></td>
						</tr>						
						<%} %>
					</tbody>					
				</table>
			</div>
		</div>
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>