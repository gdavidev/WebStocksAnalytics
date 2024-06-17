package dataAccess;

import java.sql.ResultSet;
import java.util.ArrayList;

import libs.util.ErrorHandler;
import models.accounts.Account;
import models.accounts.AccountsFactory;
import models.stocks.TransactionRegistry;
import models.users.AccountHolder;
import models.users.UserInfo;

public class DAOTransactionHistory extends DAO {
	public ArrayList<TransactionRegistry> getTransactionHistoryFromAccount(int accountId) {
		String query =
				"   SELECT s.stockCode, s.companyName, tr.actionId, tr.actionDate, tr.price FROM transactionregistry AS tr "
				+ " INNER JOIN stocks s ON s.id = tr.stockId "
				+ " WHERE tr.accountId = "+ accountId
				+ " ORDER BY actionDate ASC;";
		try {
			ArrayList<TransactionRegistry> trList = new ArrayList<TransactionRegistry>();
			ResultSet rs = executeQuery(query);
			
			while (rs.next()) {
				TransactionRegistry tr =
					new TransactionRegistry(
							accountId,
							rs.getString("s.stockcode"),
							rs.getString("s.companyname"),
							rs.getDate("tr.actionDate"),
							rs.getInt("tr.actionid") == 1 ? TransactionRegistry.ActionType.BUY : TransactionRegistry.ActionType.SELL,
							rs.getFloat("tr.price")
						);
				trList.add(tr);
			}
			return trList;
		} catch (Exception e) {
			ErrorHandler.printToConsole("DAOTransactionHistory.getTransactionHistoryFromUser" + e.getMessage());
			return null;
		}
	}
}
