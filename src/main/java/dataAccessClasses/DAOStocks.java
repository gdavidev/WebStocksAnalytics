package dataAccessClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import models.stocks.FixedIncomeStock;
import models.stocks.Stock;
import models.stocks.VariableIncomeStock;

public class DAOStocks extends DAO {
	public ArrayList<Stock> listAllStocks() {
		String query = 
			"SELECT stocks.id, stocks.companyName, stocks.stockCode, stocks.stockTypeId, sh1.price, stocks.gracePeriodDays "
			+ "FROM stocks "
			+ "INNER JOIN "
			+ "		(stockHistory sh1 LEFT JOIN stockHistory sh2 ON sh1.moment < sh2.moment) "
			+ "		ON sh1.stockId = stocks.id "
			+ "WHERE sh2.moment IS NULL";
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
				int gracePeriodDays = Integer.parseInt(rs.getString(6));
				
				if (gracePeriodDays > 0) {
					result.add(new FixedIncomeStock(id, companyName, stockCode + stockTypeId, "", price, gracePeriodDays));
				} else {
					result.add(new VariableIncomeStock(id, companyName, stockCode + stockTypeId, "", price, 0.0f));
				}
			}
			con.close();
			return result;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
	
	public ArrayList<HashMap<String, Object>> listStocksByIncrease(int quantity, boolean positiveIncrese) {
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
			+ " SELECT s.companyName, s.stockCode, s.stockTypeId, h.latestPrice, h.lastVariationPerc "
			+ " FROM stocks s "
			+ " INNER JOIN hiestHighsTable h "
			+ " 	ON s.id = h.stockId "
			+ " ORDER BY h.lastVariationPerc " + (positiveIncrese ? "DESC" : "ASC")
			+ " LIMIT " + String.valueOf(quantity);
		try {
			Connection con = this.connect();
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
			int i = 1;
			while (rs.next()) {
				String companyName = rs.getString(1);
				String stockCode = rs.getString(2);
				String stockTypeId = rs.getString(3);
				float price = Float.parseFloat(rs.getString(4));
				float priceVariation = Float.parseFloat(rs.getString(5));
				
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("number", i);
				hm.put("stockCode", stockCode + stockTypeId);
				hm.put("companyName", companyName);
				hm.put("price", price);
				hm.put("priceVariation", priceVariation);
				
				result.add(hm);
				i++;
			}
			con.close();
			return result;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
