package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataAccess.DAOAccountHolder;
import dataAccess.DAOStocks;
import dataAccess.DAOTransactionHistory;
import dataAccess.DAOUsers;
import models.stocks.TransactionRegistry;
import models.users.AccountHolder;
import models.users.User;

@WebServlet(name="/SimulationController",
			urlPatterns = {"/admin/viewUsers", "/admin/viewUser"})
public class SimulationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOTransactionHistory daoTransactionHistory = new DAOTransactionHistory();
	DAOAccountHolder daoAccountHolder = new DAOAccountHolder();
	DAOStocks daoStocks = new DAOStocks();
	DAOUsers daoUsers = new DAOUsers();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isUserAllowed((User) request.getSession().getAttribute("user"))) {
			getServletContext().getRequestDispatcher("/home").forward(request, response);
			return;
		}
		
		switch (request.getServletPath()) {
		case "/admin/viewUsers":
			request.setAttribute("usersViewData", daoAccountHolder.getAll());
			getServletContext().getRequestDispatcher("/view/admin/viewUsers.jsp").forward(request, response);
			break;
		case "/admin/viewUser":
			SetupViewUserPage(request);
			getServletContext().getRequestDispatcher("/view/admin/simulation.jsp").forward(request, response);
			break;
		}
	}
	
	private boolean isUserAllowed(User user) {
		if (user == null)
			return false;
		return user.getIsAdmin();
	}
	
	private void SetupViewUserPage(HttpServletRequest request) {
		User user = daoUsers.getUser((int) request.getAttribute("userId"));
		AccountHolder accountHolder = daoAccountHolder.getAccountHolder((int) request.getAttribute("userId"));
		ArrayList<TransactionRegistry> trList = daoTransactionHistory.getTransactionHistoryFromAccount(accountHolder.autoInvestmentAccount.getId());
		
		request.setAttribute("targetUser", user);
		request.setAttribute("targetAccountHolder", accountHolder);
		request.setAttribute("transactionRegistryList", trList);
	}
}
