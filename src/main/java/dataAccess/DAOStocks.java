package dataAccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import models.stocks.FixedIncomeStock;
import models.stocks.Stock;
import models.stocks.VariableIncomeStock;

public final class DAOStocks extends DAO {
	public static enum ListingOrder {
		HIGHEST_INCREASE,
		HIGHEST_DECREASE,
		STOCK_ID,
		COMPANY_NAME,
		HIGHEST_VALUE,
		LOWEST_VALUE,
	}
	
	public ArrayList<Stock> listAllStocks() {
		return listAllStocks(0, ListingOrder.STOCK_ID);
	}
	
	public ArrayList<Stock> listAllStocks(int quantity, ListingOrder orderBy) {
		String query = 
			" WITH hiestHighsTable AS ( "
			+ " 	WITH resultTable AS ( "
			+ " 		WITH tableMomentRanksWithMaxMoment AS ( "
			+ " 			WITH tableMomentRanks AS ( "
			+ " 				SELECT *, ROW_NUMBER() OVER(PARTITION BY stockId ORDER BY moment) AS momentRank "
			+ " 				FROM stockhistory) "
			+ " 			SELECT *, MAX(momentRank) OVER(PARTITION BY stockId) AS maxMomentRank "
			+ " 			FROM tableMomentRanks) "
			+ " 		SELECT *, ROW_NUMBER() OVER(PARTITION BY stockId) AS rowNum "
			+ " 		FROM tableMomentRanksWithMaxMoment WHERE momentRank > maxMomentRank - 2) "
			+ " 	SELECT rt1.stockId, rt1.price AS latestPrice, ROUND((rt2.price - rt1.price) * 100 / rt2.price, 2) * -1 AS lastVariationPerc "
			+ " 	FROM resultTable AS rt1 "
			+ " 	INNER JOIN resultTable AS rt2 "
			+ " 		ON rt1.stockId = rt2.stockId AND rt1.momentRank = rt2.momentRank + 1) "
			+ " SELECT s.id, s.companyName, s.stockCode, s.stockTypeId, h.latestPrice, h.lastVariationPerc, s.gracePeriodDays "
			+ " FROM stocks s "
			+ " INNER JOIN hiestHighsTable h "
			+ " 	ON s.id = h.stockId ";				
		switch (orderBy) {
			case HIGHEST_INCREASE: 	{ query += " ORDER BY h.lastVariationPerc DESC "; 	break; }
			case HIGHEST_DECREASE: 	{ query += " ORDER BY h.lastVariationPerc ASC "; 	break; }
			case STOCK_ID: 		   	{ query += " ORDER BY s.id DESC "; 					break; }
			case COMPANY_NAME: 		{ query += " ORDER BY s.companyName ASC "; 			break; }
			case HIGHEST_VALUE: 	{ query += " ORDER BY h.latestPrice DESC "; 		break; }
			case LOWEST_VALUE: 		{ query += " ORDER BY h.latestPrice ASC "; 			break; } 
		}
		query += (quantity > 0 ? " LIMIT " + String.valueOf(quantity) : ""); 
		try {
			Connection con = this.connect();
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			ArrayList<Stock> result = new ArrayList<>();
			while (rs.next()) {				
				int id = Integer.parseInt(rs.getString(1));
				String companyName = rs.getString(2);
				String stockCode = rs.getString(3);
				String stockTypeId = rs.getString(4);
				float price = Float.parseFloat(rs.getString(5));
				float priceVariation = Float.parseFloat(rs.getString(6));
				int gracePeriodDays = Integer.parseInt(rs.getString(7));
				
				if (gracePeriodDays > 0) {
					result.add(new FixedIncomeStock(id, companyName, stockCode + stockTypeId, "", price, gracePeriodDays, priceVariation));
				} else {
					result.add(new VariableIncomeStock(id, companyName, stockCode + stockTypeId, "", price, 0.0f, priceVariation));
				}
			}
			con.close();
			return result;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
