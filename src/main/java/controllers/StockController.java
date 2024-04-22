package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Account;
import models.FixedIncomeStock;
import models.VariableIncomeStock;

@WebServlet("/StockController")
public class StockController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public StockController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	// FIXED INCOME STOCKS
	public static FixedIncomeStock LoadCheckingAccount(Account holder) {
		// SQL
		return new FixedIncomeStock(0, "", "", 0f, 0);
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
		return new VariableIncomeStock(0, "", "", 0f, 0f);
	}
	public static void StoreAutoInvestmentAccount() {
		// SQL
	}
	public static void DeleteAutoInvestmentAccount() {
		// SQL
	}
}
