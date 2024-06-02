<%@ page import="models.users.User" %>
<%
	User user = null;
	if (session.getAttribute("user") != null) 
		user = (User) session.getAttribute("user");
%>

<nav class="navbar bg-dark border-bottom border-body w-100 position-fixed z-3" data-bs-theme="dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="#"><img alt="logo" id="nav-logo" src="https://placehold.co/180x35"></a>
		<ul class="nav">
	        <li class="nav-item">
	          	<a href="<%= request.getContextPath() %>/home" class="nav-link" aria-current="page">Home</a>
	        </li>
	        <li class="nav-item">
	         	<a href="<%= request.getContextPath() %>/stocks/view" class="nav-link" aria-current="page">Stocks</a>
	        </li>
		</ul>
		<%if (user != null) { %>
			<ul class="nav">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						<%=user.name %>
					</a>
		          	<form action="<%= request.getContextPath() %>/user/logout" method="POST">
			          	<ul class="dropdown-menu">
			          		<%if (user.getIsAdmin() == true) { %>
				            	<li><a class="dropdown-item" href="<%= request.getContextPath() %>/admin/viewUsers">Admin Menu</a></li>			          		
			        		<%} %>
			            	<li><a class="dropdown-item" href="#">Profile</a></li>
			            	<li><button type="submit" class="dropdown-item">Logout</button></li>
			         	</ul>
		          	</form>
		        </li>
			</ul>
		<%} %>			     	
		<%if (user == null) { %>
			<div class="nav gap-1">
		        <a class="col btn btn-primary" href="<%= request.getContextPath() %>/user/login">Login</a>
		        <a class="col btn btn-secondary" href="<%= request.getContextPath() %>/user/register">SingIn</a>
	      	</div>
		<%} %>		
	</div>
</nav>