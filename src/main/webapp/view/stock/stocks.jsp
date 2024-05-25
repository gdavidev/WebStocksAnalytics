<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.stocks.Stock" %>
<%
	ArrayList<Stock> stocks = (ArrayList<Stock>) request.getAttribute("stockList");
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/tables.css">
	<title>Stocks - VcRiquinho</title>
</head>
<body>
	<%@ include file="/components/navbar.jsp" %>
	<main>	
		<h1>Stocks</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>

		<div class="scrollable-table-container">
			<div class="table table-search">
				<div class="header-row" style="grid-template-columns: 0.5fr 2fr 0.5fr 0.5fr 0.45fr;">
					<div class="header-cell code-col">Code</div>
					<div class="header-cell name-col">CompanyName</div>
					<div class="header-cell price-col">Price(R$)</div>
					<div class="header-cell price-col">Increase</div>
					<div class="header-cell action-col">Action</div>
				</div>
				<%for (int i = 0; i < stocks.size(); i++) { %>
					<div class="content-row" style="grid-template-columns: 0.5fr 2fr 0.5fr 0.5fr 0.45fr;">
						<div class="content-cell code-col"><%=stocks.get(i).code %></div>
						<div class="content-cell name-col"><%=stocks.get(i).companyName %></div>
						<div class="content-cell price-col"><%=stocks.get(i).price %></div>
						<%if (stocks.get(i).priceVariation > 0) { %>
							<div class="content-cell priceVarPos-col">
								<ion-icon name="arrow-up-outline"></ion-icon> <%=String.format("%.2f", stocks.get(i).priceVariation) %>%
							</div>
						<%} else { %>
							<div class="content-cell priceVarNeg-col">
								<ion-icon name="arrow-down-outline"></ion-icon> <%=String.format("%.2f", stocks.get(i).priceVariation) %>%
							</div>
						<%} %>
						<div class="content-cell action-col">
							<input id="details|<%=i %>" class="btn btn-primary" type="button" value="Details">
						</div>
					</div>
				<%} %>
			</div>
		</div>
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>

