package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.AccountHolder;
import models.AutoInvestmentAccount;
import models.CheckingAccount;
import models.IdrAccount;

@WebServlet(name = "/AccountController", urlPatterns = {"/account/*"})
public class AccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	// CHECKING ACCOUNTS
	public static CheckingAccount LoadCheckingAccount(AccountHolder holder) {
		// SQL
		return new CheckingAccount(0, holder, 0f);
	}
	public static void StoreCheckingAccount() {
		// SQL
	}
	public static void DeleteCheckingAccount() {
		// SQL
	}
	
	// AUTO INVESTMENT ACCOUNTS
	public static AutoInvestmentAccount LoadAutoInvestmentAccount(AccountHolder holder) {
		// SQL
		return new AutoInvestmentAccount(0, holder, 0f);
	}
	public static void StoreAutoInvestmentAccount() {
		// SQL
	}
	public static void DeleteAutoInvestmentAccount() {
		// SQL
	}
	
	// IDR ACCOUNTS
	public static IdrAccount LoadIdrAccount(AccountHolder holder) {
		// SQL
		return new IdrAccount(0, holder, 0f);
	}
	public static void StoreIdrAccount() {
		// SQL
	}
	public static void DeleteIdrAccount() {
		// SQL
	}
}
