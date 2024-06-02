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
	<title>Home - VcRiquinho</title>
</head>
<body class="overflow-x-hidden min-vh-100">
	<%@ include file="/components/navbar.jsp" %>
	<main class="px-5 w-100 d-flex flex-column" style="padding-top: 5rem;">
		<h1>VcRiquinho</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>
		<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nunc ligula velit, rutrum in luctus ac, facilisis ac erat. Suspendisse eu maximus dui. Donec sagittis, risus vitae posuere scelerisque, diam elit varius ex, nec laoreet odio nibh ut ex. Nam lacinia, turpis sit amet eleifend convallis, massa elit efficitur magna, ut tincidunt eros dui a lacus. Nullam faucibus mollis diam, a pellentesque risus tempus et. Quisque nec luctus turpis. Phasellus eu varius dolor. Donec at ligula purus. Donec ut sodales diam, non euismod massa. Aenean ac metus ut tortor porta cursus.</p>

		<div class="row">		
			<div class="col">
				<h2 class="table-caption">Highest Increases Today</h2>
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
						<%for (int i = 0; i < hiestPosVarStockPrices.size(); i++) { %>
						<tr>
							<th scope="row" class="text-center"><%=i + 1 %></th>
							<td><%=hiestPosVarStockPrices.get(i).code %></td>
							<td><%=hiestPosVarStockPrices.get(i).companyName %></td>
							<td class="text-end"><%=hiestPosVarStockPrices.get(i).price %></td>
							<td>
								<div class="container-fluid d-flex justify-content-between align-items-center" style="color: green;">
									<ion-icon name="arrow-up-outline"></ion-icon>
									<%=String.format("%.2f", hiestPosVarStockPrices.get(i).priceVariation) %>%
								</div>
							</td>
						</tr>						
						<%} %>
					</tbody>					
				</table>
			</div>
			<div class="col">
				<h2 class="table-caption">Highest Decreases Today</h2>
				<table class="table table-striped table-hover">
					<thead class="thead-dark">
						<tr>
							<th scope="col" class="text-center">#</th>
							<th scope="col">Code</th>
							<th scope="col">CompanyName</th>
							<th scope="col" class="text-end">Price(R$)</th>
							<th scope="col" class="text-end">Increase</th>
						</tr>
					</thead>
					<tbody>
					<%for (int i = 0; i < hiestNegVarStockPrices.size(); i++) { %>
					<tr>
						<th scope="row" class="text-center"><%=i + 1 %></th>
						<td><%=hiestNegVarStockPrices.get(i).code %></td>
						<td><%=hiestNegVarStockPrices.get(i).companyName %></td>
						<td class="text-end"><%=hiestNegVarStockPrices.get(i).price %></td>
						<td>
							<div class="container-fluid d-flex justify-content-between align-items-center" style="color: red;">
								<ion-icon name="arrow-down-outline"></ion-icon>
								<%=String.format("%.2f", hiestNegVarStockPrices.get(i).priceVariation) %>%
							</div>							
						</td>
					</tr>						
					<%} %>
					</tbody>					
				</table>
			</div>
		</div>
		
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p>
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>