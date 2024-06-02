<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.stream.*" %>
<%@ page import="models.accounts.Account" %>
<%@ page import="models.accounts.CheckingAccount" %>
<%@ page import="models.accounts.IdrAccount" %>
<%@ page import="models.accounts.AutoInvestmentAccount" %>
<%@ page import="models.users.AccountHolder" %>
<%@ page import="models.users.UserInfo" %>
<%
	ArrayList<AccountHolder> users = (ArrayList<AccountHolder>) request.getAttribute("usersViewData");
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<title>Users - VcRiquinho</title>
</head>
<body class="overflow-x-hidden min-vh-100">
	<%@ include file="/components/navbar.jsp" %>
	<main class="px-5 w-100 d-flex flex-column" style="padding-top: 5rem;">	
		<h1>Users</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>
		
		<h2>All Users</h2>
		<table class="table table-striped w-100 align-self-center">
			<thead>
				<tr>
					<th colspan="3" scope="colgroup" rowspan="2" class="align-middle text-center">Account Holder Info</th>
					<th colspan="6" scope="colgroup" class="text-center">Accounts</th>
					<th colspan="2" scope="colgroup" rowspan="2" class="align-middle text-center">Total</th>
				</tr>
				<tr>
					<th colspan="2" scope="col" class="text-center">Checking</th>
					<th colspan="2" scope="col" class="text-center">IDR</th>
					<th colspan="2" scope="col" class="text-center">Auto Invest</th>					
				</tr>
				<tr>
					<th scope="col">Id</th>
					<th scope="col">User Name</th>
					<th scope="col">Person Type</th>
					<th scope="col" class="text-end">Balance</th>
					<th scope="col" class="text-end">Tax</th>
					<th scope="col" class="text-end">Balance</th>
					<th scope="col" class="text-end">Tax</th>
					<th scope="col" class="text-end">Balance</th>
					<th scope="col" class="text-end">Tax</th>
					<th scope="col" class="text-end">Balance</th>
					<th scope="col" class="text-end">Tax</th>
				</tr>
			</thead>
			<tbody>
				<% 
					float finalTotalBalance = 0f;
					float finalTotalTax = 0f;
				%>
				<%for (int i = 0; i < users.size(); i++) {
					CheckingAccount checkingAccount = null;
					IdrAccount idrAccount = null;
					AutoInvestmentAccount autoInvAccount = null;
					
					float autoInvAccountBalance = 0f;
					float idrAccountBalance = 0f;
					float checkingAccountBalance = 0f;
					
					float autoInvAccountTax = 0f;
					float idrAccountTax = 0f;
					float checkingAccountTax = 0f;
					
					for (int j = 0; j < users.get(i).accounts.size(); j ++) {
						ArrayList<Account> accounts = users.get(i).accounts;
						if (accounts.get(j) instanceof CheckingAccount) {
							checkingAccount = (CheckingAccount) accounts.get(j);
							checkingAccountBalance = checkingAccount.balance;
							checkingAccountTax = checkingAccount.getTaxedAmount();
						}
						if (accounts.get(j) instanceof IdrAccount) {
							idrAccount = (IdrAccount) accounts.get(j);
							idrAccountBalance = idrAccount.balance;
							idrAccountTax = idrAccount.getTaxedAmount();
						}
						if (accounts.get(j) instanceof AutoInvestmentAccount) {
							autoInvAccount = (AutoInvestmentAccount) accounts.get(j);
							autoInvAccountBalance = autoInvAccount.balance;
							autoInvAccountTax = autoInvAccount.getTaxedAmount();
						}
					}
					
					float totalBalance = autoInvAccountBalance + idrAccountBalance + checkingAccountBalance;
					float totalTax = autoInvAccountTax + idrAccountTax + checkingAccountTax;
					finalTotalBalance += totalBalance;
					finalTotalTax += totalTax;
				%>
				<tr>
					<td><%=users.get(i).holderId %></td>
					<td><%=users.get(i).holderInfo.completeName %></td>
					<td><%=users.get(i).holderInfo.personTypeId == UserInfo.personType.PRIVATE_PERSON ? "CPF" : "CNPJ" %></td>
					<% if (checkingAccount != null) { %>
						<td class="text-end"><%=String.format("%.2f", checkingAccountBalance) %></td>
						<td class="text-end"><%=String.format("%.2f", checkingAccount.getTaxedAmount()) %></td>					
					<% } else { %>						
						<td></td>
						<td></td>
					<% } %>
					<% if (idrAccount != null) { %>
						<td class="text-end"><%=String.format("%.2f", idrAccountBalance) %></td>
						<td class="text-end"><%=String.format("%.2f", idrAccountTax) %></td>					
					<% } else { %>						
						<td></td>
						<td></td>
					<% } %>
					<% if (autoInvAccount != null) { %>
						<td class="text-end"><%=String.format("%.2f", autoInvAccountBalance) %></td>
						<td class="text-end"><%=String.format("%.2f", autoInvAccountTax) %></td>					
					<% } else { %>
						<td></td>
						<td></td>
					<% } %>
					<% if (totalBalance != 0) { %>
						<td class="text-end"><%=String.format("%.2f", totalBalance) %></td>
						<td class="text-end"><%=String.format("%.2f", totalTax) %></td>					
					<% } else { %>
						<td></td>
						<td></td>
					<% } %>
				</tr>						
				<%} %>
				<tr>
					<td scope="row" class="fw-bolder text-center" rowspan="9">TOTAL</td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td rowspan="0"></td>
					<td scope="row" class="fw-bolder text-end"><%=String.format("%.2f", finalTotalBalance) %></td>
					<td scope="row" class="fw-bolder text-end"><%=String.format("%.2f", finalTotalTax) %></td>
				</tr>
			</tbody>					
		</table>		
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>

