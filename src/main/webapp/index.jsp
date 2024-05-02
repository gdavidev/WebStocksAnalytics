<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="models.stocks.Stock" %>
<%
	ArrayList<HashMap<String, Object>> hiestPosVarStockPrices = (ArrayList<HashMap<String, Object>>) request.getAttribute("hiestPosVarStockPrices");
	ArrayList<HashMap<String, Object>> hiestNegVarStockPrices = (ArrayList<HashMap<String, Object>>) request.getAttribute("hiestNegVarStockPrices");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script type="nomodule" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	<script type="text/javascript" src="scripts/jquery.min.js"></script>
	<link rel="stylesheet" href="styles/styles.css">
	<link rel="stylesheet" href="styles/home.css">
	<title>Home</title>
</head>
<body>
	<%@ include file="/shared/navbar.jsp" %>
	<main>
		<div id="cover-img-container">
			<img alt="cover-img" src="media/images/global-stock-market.webp">
		</div>
		<h1>VcRiquinho</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>
		<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nunc ligula velit, rutrum in luctus ac, facilisis ac erat. Suspendisse eu maximus dui. Donec sagittis, risus vitae posuere scelerisque, diam elit varius ex, nec laoreet odio nibh ut ex. Nam lacinia, turpis sit amet eleifend convallis, massa elit efficitur magna, ut tincidunt eros dui a lacus. Nullam faucibus mollis diam, a pellentesque risus tempus et. Quisque nec luctus turpis. Phasellus eu varius dolor. Donec at ligula purus. Donec ut sodales diam, non euismod massa. Aenean ac metus ut tortor porta cursus.</p>
		<div style="display: flex; column-gap: 20px;">
			<table id="hiestPosVarStocks-table" class="table">
				<thead>
					<tr class="row header-row">
						<th class="cell header">Nº</th>
						<th class="cell header">Code</th>
						<th class="cell header">CompanyName</th>
						<th class="cell header">Price(R$)</th>
						<th class="cell header">Var.</th>
					</tr>
				</thead>
				<tbody>
					<%for (int i = 0; i < hiestPosVarStockPrices.size(); i++) { %>
						<tr class="row content-row">
							<td class="cell nuumber"><%=hiestPosVarStockPrices.get(i).get("number") %></td>
							<td class="cell code"><%=hiestPosVarStockPrices.get(i).get("stockCode") %></td>
							<td class="cell name"><%=hiestPosVarStockPrices.get(i).get("companyName") %></td>
							<td class="cell price"><%=hiestPosVarStockPrices.get(i).get("price") %></td>
							<td class="cell priceVarPos"><ion-icon name="arrow-up-outline"></ion-icon> <%=String.format("%.2f", hiestPosVarStockPrices.get(i).get("priceVariation")) %>%</td>
						</tr>
					<%} %>
				</tbody>
			</table>
			<table id="hiestPosVarStocks-table" class="table">
				<thead>
					<tr class="row header-row">
						<th class="cell header">Nº</th>
						<th class="cell header">Code</th>
						<th class="cell header">CompanyName</th>
						<th class="cell header">Price(R$)</th>
						<th class="cell header">Var.</th>
					</tr>
				</thead>
				<tbody>
					<%for (int i = 0; i < hiestNegVarStockPrices.size(); i++) { %>
						<tr class="row content-row">
							<td class="cell number"><%=hiestNegVarStockPrices.get(i).get("number") %></td>
							<td class="cell code"><%=hiestNegVarStockPrices.get(i).get("stockCode") %></td>
							<td class="cell name"><%=hiestNegVarStockPrices.get(i).get("companyName") %></td>
							<td class="cell price"><%=hiestNegVarStockPrices.get(i).get("price") %></td>
							<td class="cell priceVarNeg"><ion-icon name="arrow-down-outline"></ion-icon> <%=String.format("%.2f", hiestNegVarStockPrices.get(i).get("priceVariation")) %>%</td>
						</tr>
					<%} %>
				</tbody>
			</table>
		</div>
	</main>
	<%@ include file="/shared/footer.jsp" %>
</body>
</html>