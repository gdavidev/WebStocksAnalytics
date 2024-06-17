<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.users.User" %>
<%@ page import="models.users.UserInfo" %>
<%@ page import="models.users.AccountHolder" %>
<%@ page import="models.accounts.*" %>
<%@ page import="models.stocks.TransactionRegistry" %>
<%
	User targetUser = (User) request.getAttribute("targetUser");
	AccountHolder accountHolder = (AccountHolder) request.getAttribute("targetAccountHolder");
	ArrayList<TransactionRegistry> transactionList = (ArrayList<TransactionRegistry>) request.getAttribute("transactionRegistryList");
	
	CheckingAccount checkingAccount = accountHolder.checkingAccount;
	IdrAccount idrAccount = accountHolder.idrAccount;
	AutoInvestmentAccount autoInvAccount = accountHolder.autoInvestmentAccount;
	
	float totalApplied = 0f;
	float totalNotApplied = 0f;
	
	for (TransactionRegistry tr : transactionList) {
		if (tr.actionType == TransactionRegistry.ActionType.BUY)
			totalApplied += tr.price;
		else
			totalApplied -= tr.price;
	}
	
	totalNotApplied = accountHolder.getTotalBalance() - totalApplied;
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
		<p>
			<b>Email:</b> <%=targetUser.email %>				<br>
			<b>Document:</b> <%=targetUser.userInfo.document %> <br>
			<b>Phone:</b> <%=targetUser.userInfo.phone %>		<br>
		</p>
		
		<h3>Accounts</h3>
		<div class="d-flex column-gap-3 mb-5">
			<%if (checkingAccount != null) { %>
				<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">Checking Account</h5>
				    <p class="card-text">R$ <%=checkingAccount.balance %></p>
				  </div>
				</div>
			<%} %>
			<%if (autoInvAccount != null) { %>
				<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">IDR Account</h5>
				    <p class="card-text">R$ <%=autoInvAccount.balance %></p>
				  </div>
				</div>
			<%} %>
			<%if (idrAccount != null) { %>
				<div class="card" style="width: 18rem;">
				  <div class="card-body">
				    <h5 class="card-title">Auto Invest. Account</h5>
				    <p class="card-text">R$ <%=idrAccount.balance %></p>
				  </div>
				</div>
			<%} %>
		</div>
		
		<div class="row">		
			<div class="col">
				<h2 class="table-caption">History</h2>
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col" class="text-center">#</th>
							<th scope="col">Code</th>
							<th scope="col">CompanyName</th>
							<th scope="col">Moment</th>
							<th scope="col">Price</th>
							<th scope="col" class="text-end">Action</th>
						</tr>
					</thead>
					<tbody>
						<%for (int i = 0; i < transactionList.size(); i++) { %>
						<tr>
							<th scope="row" class="text-center"><%=i + 1 %></th>
							<td><%=transactionList.get(i).stockCode %></td>
							<td><%=transactionList.get(i).stockName %></td>
							<td><%=transactionList.get(i).dateTime %></td>
							<td><%=transactionList.get(i).price %></td>
							<%if (transactionList.get(i).actionType == TransactionRegistry.ActionType.BUY) { %>
								<td class="text-end text-success">BUY</td>
							<%} else { %>
								<td class="text-end text-danger">SELL</td>
							<%} %>
						</tr>
						<%} %>
					</tbody>					
				</table>
			</div>
			<div class="col">
				<h2>Analytics</h2>
				<h5>Total Balance:</h5>
				<p class="p-1 border-bottom border-primary">R$ <span class="fs-5"><%=String.format("%.2f", accountHolder.getTotalBalance()) %></span></p>
				<div class="row">
					<div class="col">
						<h5>Applied:</h5>
						<p class="p-1 border-bottom border-primary">R$ <span class="fs-5"><%=String.format("%.2f", totalApplied) %></span></p>
					</div>
					<div class="col">
						<h5>Not Applied:</h5>
						<p class="p-1 border-bottom border-primary">R$ <span class="fs-5"><%=String.format("%.2f", totalNotApplied) %></span></p>
					</div>
				</div>
				<h5>Total Taxed:</h5>
				<p class="p-1 border-bottom border-primary">R$ <span class="fs-5"><%=String.format("%.2f", accountHolder.getTotalTax()) %></span></p>
			</div>
		</div>
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>