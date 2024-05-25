<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.stocks.Stock" %>
<%
	ArrayList<Stock> hiestPosVarStockPrices = (ArrayList<Stock>) request.getAttribute("hiestIncStockPrices");
	ArrayList<Stock> hiestNegVarStockPrices = (ArrayList<Stock>) request.getAttribute("hiestDecStockPrices");
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/components/defaultPageHead.jsp" %>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/home.css">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/tables.css">
	<title>Home - VcRiquinho</title>
</head>
<body>
	<%@ include file="/components/navbar.jsp" %>
	<main>
		<div id="cover-img-container">
			<img alt="cover-img" src="media/images/global-stock-market.webp">
		</div>
		<h1>VcRiquinho</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>
		<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nunc ligula velit, rutrum in luctus ac, facilisis ac erat. Suspendisse eu maximus dui. Donec sagittis, risus vitae posuere scelerisque, diam elit varius ex, nec laoreet odio nibh ut ex. Nam lacinia, turpis sit amet eleifend convallis, massa elit efficitur magna, ut tincidunt eros dui a lacus. Nullam faucibus mollis diam, a pellentesque risus tempus et. Quisque nec luctus turpis. Phasellus eu varius dolor. Donec at ligula purus. Donec ut sodales diam, non euismod massa. Aenean ac metus ut tortor porta cursus.</p>
		
		<div class="multi-table-conainer">
			<div class="table-container">
				<h2 class="table-caption">Highest Increases Today</h2>
				<div class="table">
					<div class="header-row" style="grid-template-columns: 50px 2fr 4fr 2fr 3fr;">
						<div class="header-cell number-col">Nº</div>
						<div class="header-cell code-col">Code</div>
						<div class="header-cell name-col">CompanyName</div>
						<div class="header-cell price-col">Price(R$)</div>
						<div class="header-cell price-col">Increase</div>
					</div>
					<%for (int i = 0; i < hiestPosVarStockPrices.size(); i++) { %>
						<div class="content-row" style="grid-template-columns: 50px 2fr 4fr 2fr 3fr;">
							<div class="content-cell number-col"><%=i + 1 %></div>
							<div class="content-cell code-col"><%=hiestPosVarStockPrices.get(i).code %></div>
							<div class="content-cell name-col"><%=hiestPosVarStockPrices.get(i).companyName %></div>
							<div class="content-cell price-col"><%=hiestPosVarStockPrices.get(i).price %></div>
							<div class="content-cell priceVarPos-col">
								<ion-icon name="arrow-up-outline"></ion-icon> <%=String.format("%.2f", hiestPosVarStockPrices.get(i).priceVariation) %>%
							</div>
						</div>
					<%} %>
				</div>
			</div>
			<div class="table-container">
				<h2 class="table-caption">Highest Decreases Today</h2>
				<div class="table">
					<div class="header-row" style="grid-template-columns:  1fr 2fr 4fr 2fr 3fr;">
						<div class="header-cell number-col">Nº</div>
						<div class="header-cell code-col">Code</div>
						<div class="header-cell name-col">CompanyName</div>
						<div class="header-cell price-col">Price(R$)</div>
						<div class="header-cell price-col">Increase</div>
					</div>
					<%for (int i = 0; i < hiestNegVarStockPrices.size(); i++) { %>
						<div class="content-row" style="grid-template-columns:  1fr 2fr 4fr 2fr 3fr;">
							<div class="content-cell number-col"><%=i + 1 %></div>
							<div class="content-cell code-col"><%=hiestNegVarStockPrices.get(i).code %></div>
							<div class="content-cell name-col"><%=hiestNegVarStockPrices.get(i).companyName %></div>
							<div class="content-cell price-col"><%=hiestNegVarStockPrices.get(i).price %></div>
							<div class="content-cell priceVarNeg-col">
								<ion-icon name="arrow-down-outline"></ion-icon> <%=String.format("%.2f", hiestNegVarStockPrices.get(i).priceVariation) %>%
							</div>
						</div>
					<%} %>
				</div>
			</div>
		</div>		
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>