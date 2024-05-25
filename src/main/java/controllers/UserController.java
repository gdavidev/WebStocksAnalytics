package controllers;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataAccess.DAOUsers;
import libs.InputValidator;
import models.accounts.AutoInvestmentAccount;
import models.accounts.CheckingAccount;
import models.accounts.IdrAccount;
import models.users.AccountHolder;
import models.users.User;

@WebServlet(name = "/UserController",
			urlPatterns = {"/user/login", "/user/register"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUsers daoUsers = new DAOUsers();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			switch (request.getServletPath()) {
				case "user/login":				
					request.setAttribute("user", makeUserLogin(request.getParameterMap()));
					break;
				case "user/register":
					request.setAttribute("user", makeUserRegister(request.getParameterMap()));
					break;
			}
			getServletContext().getRequestDispatcher("/view/content/home.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			request.setAttribute("pageState", request.getServletPath());
			getServletContext().getRequestDispatcher("/view/user/userLoginRegister.jsp").forward(request, response);
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("pageState", request.getServletPath());
		getServletContext().getRequestDispatcher("/view/user/userLoginRegister.jsp").forward(request, response);				
	}
	
	private User makeUserLogin(Map<String, String[]> parameters) throws Exception {
		String email = parameters.get("email")[0];
		String password = parameters.get("password")[0];
		if (InputValidator.validateEmail(email) && InputValidator.validatePassword(password)) {
			int userId = daoUsers.getUserLoginId(email, password);
			return daoUsers.getUser(userId);
		}
		return null;
	}
	
	private User makeUserRegister(Map<String, String[]> parameters) throws Exception {
//		String name = request.getParameter("name");
//		String email = request.getParameter("email");
//		String password = request.getParameter("password");
//		String completeName = request.getParameter("completeName");
//		String phone = request.getParameter("phone");
//		String personTypeId= request.getParameter("personTypeId");
//		String document = request.getParameter("document");
		return new User(); // placeholder
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
