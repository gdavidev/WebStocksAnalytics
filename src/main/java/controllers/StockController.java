package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataAccess.DAOStocks;
import models.accounts.Account;
import models.stocks.FixedIncomeStock;
import models.stocks.VariableIncomeStock;

@WebServlet(name = "/StockController",
			urlPatterns = {"/stocks/view"})//, "/stocks/create", "/stocks/delete"})
public class StockController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOStocks daoStocks = new DAOStocks();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("stockList", daoStocks.listAllStocks(0, DAOStocks.ListingOrder.COMPANY_NAME));
		getServletContext().getRequestDispatcher("/view/stock/stocks.jsp").forward(request, response);
	}
	
	// FIXED INCOME STOCKS
	public static FixedIncomeStock LoadCheckingAccount(Account holder) {
		// SQL
		return new FixedIncomeStock(0, "", "", "", 0.0f, 0);
	}
	public static void StoreCheckingAccount() {
		// SQL
	}
	public static void DeleteCheckingAccount() {
		// SQL
	}
	
	// VARIABLE INCOME STOCKS
	public static VariableIncomeStock LoadAutoInvestmentAccount(Account account) {
		// SQL
		return new VariableIncomeStock(0, "", "", "", 0f, 0f);
	}
	public static void StoreAutoInvestmentAccount() {
		// SQL
	}
	public static void DeleteAutoInvestmentAccount() {
		// SQL
	}
}
