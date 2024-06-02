package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataAccess.DAOAccountHolder;
import models.users.User;

@WebServlet(name="/SimulationController",
			urlPatterns = {"/admin/viewUsers"})
public class SimulationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOAccountHolder daoAccountHolders = new DAOAccountHolder();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isUserAllowed((User) request.getSession().getAttribute("user"))) {
			getServletContext().getRequestDispatcher("/home").forward(request, response);
			return;
		}
		request.setAttribute("usersViewData", daoAccountHolders.getAll());
		getServletContext().getRequestDispatcher("/view/admin/viewUsers.jsp").forward(request, response);
	}
	
	private boolean isUserAllowed(User user) {
		if (user == null)
			return false;
		return user.getIsAdmin();
	}
}
