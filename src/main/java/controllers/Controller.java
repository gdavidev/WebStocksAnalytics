package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataAccess.DAOStocks;

@WebServlet(name = "/Controller",
			urlPatterns = {"/home"})
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOStocks daoStocks = new DAOStocks();
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
	}
    
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("hiestIncStockPrices", daoStocks.listAllStocks(10, DAOStocks.ListingOrder.HIGHEST_INCREASE));
		request.setAttribute("hiestDecStockPrices", daoStocks.listAllStocks(10, DAOStocks.ListingOrder.HIGHEST_DECREASE));
		getServletContext().getRequestDispatcher("/view/content/home.jsp").forward(request, response);
	}
}
