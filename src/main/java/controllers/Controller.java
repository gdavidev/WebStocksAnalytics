package controllers;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataAccessClasses.DAOStocks;

@WebServlet(name = "/main", urlPatterns = "/index")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOStocks daoStocks = new DAOStocks();
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//ArrayList<Stock> stockList = daoStocks.listAllStocks();
		//request.setAttribute("stocks", stockList);
		request.setAttribute("hiestPosVarStockPrices", daoStocks.listStocksByIncrease(10, true));
		request.setAttribute("hiestNegVarStockPrices", daoStocks.listStocksByIncrease(10, false));
		getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
	}
}
