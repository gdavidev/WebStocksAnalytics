package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dataAccess.DAOUsers;
import libs.InputValidator;
import libs.customExceptions.UserInputException;
import libs.util.ErrorHandler;
import models.accounts.AutoInvestmentAccount;
import models.accounts.CheckingAccount;
import models.accounts.IdrAccount;
import models.users.AccountHolder;
import models.users.User;
import models.users.UserInfo;

@WebServlet(name = "/UserController",
			urlPatterns = {"/user/login", "/user/register", "/user/logout"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUsers daoUsers = new DAOUsers();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			switch (request.getServletPath()) {
				case "/user/login":
					request.getSession().setAttribute("user", doUserLogin(request));
					break;
				case "/user/register":
					request.getSession().setAttribute("user", doUserRegister(request));
					break;
				case "/user/logout":
					request.getSession().removeAttribute("user");
					break;
			}
			getServletContext().getRequestDispatcher("/home").forward(request, response);
		} catch (UserInputException e) {
			request.setAttribute("error", e.getDisplayableMessage());
			request.setAttribute("servletPath", request.getServletPath());
			doGet(request, response);
		} catch (Exception e) {
			ErrorHandler.printToConsole("UserController.doPost: " + e.toString());
			doGet(request, response);
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("servletPath", request.getServletPath());
		getServletContext().getRequestDispatcher("/view/user/userLoginRegister.jsp").forward(request, response);				
	}
	
	private User doUserLogin(HttpServletRequest request) throws UserInputException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		if (InputValidator.validateEmail(email) && InputValidator.validatePassword(password)) {
			int userId = daoUsers.getUserLoginId(email, password);
			if(userId == 0)
				throw new UserInputException("Usuário não encontrado.");
			return daoUsers.getUser(userId);
		}
		return null;
	}
	
	private User doUserRegister(HttpServletRequest request) throws UserInputException {
		validateRegisterFormFields(request);
		
		String name = request.getParameter("name");
		String completeName = request.getParameter("completeName");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String personTypeId= request.getParameter("personTypeId");
		String document = request.getParameter("document");
		
		try {
			UserInfo userInfo = new UserInfo(completeName, phone, UserInfo.getPersonTypeFromValue(Integer.parseInt(personTypeId)), document);
			User user = new User(0, name, email, password, userInfo, false);
			daoUsers.storeUser(user);
			return user;
		} catch (Exception e) {
			ErrorHandler.printToConsole("UserController.doUserRegister: " + e.toString());
			e.printStackTrace(System.out);
			throw new UserInputException("Erro: Erro de conexão por favor tente mais tarde");
		}
	}
	
	private boolean validateRegisterFormFields(HttpServletRequest request) throws UserInputException {
		InputValidator.validateEmail(request.getParameter("email"));
		if (daoUsers.isUserEmailAvailable(request.getParameter("email")))
			throw new  UserInputException("Este email não está disponível.");
		InputValidator.validateRequiredField("Nome de usuário", request.getParameter("name"));
		InputValidator.validateRequiredField("Nome Completo", request.getParameter("completeName"));
		InputValidator.validatePassword(request.getParameter("password"));
		InputValidator.validatePhone(request.getParameter("phone"));
		if (UserInfo.getPersonTypeFromValue(Integer.parseInt(request.getParameter("personTypeId"))) == UserInfo.personType.PRIVATE_PERSON)
			InputValidator.validateCPF(request.getParameter("document"));
		else
			InputValidator.validateCNPJ(request.getParameter("document"));
		return true;
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
