<%@ page import="models.users.User" %>
<%
	User user = null;
	if (session.getAttribute("user") != null) {
		user = (User) session.getAttribute("user");
	}
%>

<nav id="navbar">
	<img alt="logo" id="nav-logo" src="https://placehold.co/35x35">
	<ul id="nav-menu">
		<li><a href="<%= request.getContextPath() %>/home">Home</a></li>
		<li><a href="<%= request.getContextPath() %>/stocks/view">Stocks</a></li>
	</ul>
	<%if (user != null) { %>
		<div id="nav-profile">
			<img alt="profile-img" id="nav-profile-img" src="https://placehold.co/20x20">
			<p id="nav-profile-name"><%= user.name %></p>
			<ion-icon name="caret-down-outline"></ion-icon>
		</div>
	<%} else { %>
		<div id="nav-profile" class="btn-container">
			<a class="btn btn-secondary" href="<%= request.getContextPath() %>/user/login">Login</a>
			<a class="btn btn-tertiary" href="<%= request.getContextPath() %>/user/register">SingIn</a>
		</div>
	<%} %>
</nav>