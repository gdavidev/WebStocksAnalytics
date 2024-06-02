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
	<title>Stocks - VcRiquinho</title>
</head>
<body class="overflow-x-hidden min-vh-100">
	<%@ include file="/components/navbar.jsp" %>
	<main class="px-5 w-100 d-flex flex-column" style="padding-top: 5rem;">	
		<h1>Stocks</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mauris velit, posuere nec mollis a, blandit ut neque. Maecenas iaculis tellus turpis. Cras tincidunt odio ac libero cursus, in porta magna viverra. Nam rhoncus a mauris vitae aliquam. Sed et feugiat quam. Nullam posuere laoreet risus, et euismod nibh tempus nec. Donec vehicula congue ipsum non laoreet.</p><br>
		
		<h2>All Stocks</h2>
		<table class="table table-striped w-50 align-self-center">
			<thead>
				<tr>
					<th scope="col">Code</th>
					<th scope="col">CompanyName</th>
					<th scope="col" class="text-end">Price(R$)</th>
					<th scope="col" class="text-end">Increase</th>
				</tr>
			</thead>
			<tbody>
				<%for (int i = 0; i < stocks.size(); i++) { %>
				<tr>
					<td><%=stocks.get(i).code %></td>
					<td><%=stocks.get(i).companyName %></td>
					<td class="text-end"><%=stocks.get(i).price %></td>
					<td>
						<div class="container-fluid d-flex justify-content-between align-items-center" 
							 style="color: <%=(stocks.get(i).priceVariation) > 0 ? "green": "red" %>">
							<%if(stocks.get(i).priceVariation > 0) { %>
								<ion-icon name="arrow-up-outline"></ion-icon>
								<%=String.format("%.2f", stocks.get(i).priceVariation) %>%
							<%} else { %>
								<ion-icon name="arrow-down-outline"></ion-icon>
								<%=String.format("%.2f", stocks.get(i).priceVariation) %>%
							<%} %>
						</div>
					</td>
				</tr>						
				<%} %>
			</tbody>					
		</table>		
	</main>
	<%@ include file="/components/footer.jsp" %>
</body>
</html>

