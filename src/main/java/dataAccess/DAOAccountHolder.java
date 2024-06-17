package dataAccess;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import libs.util.ErrorHandler;
import models.accounts.Account;
import models.accounts.Account.AccountType;
import models.accounts.AccountsFactory;
import models.accounts.AutoInvestmentAccount;
import models.accounts.CheckingAccount;
import models.accounts.IdrAccount;
import models.stocks.Stock;
import models.users.AccountHolder;
import models.users.UserInfo;

public class DAOAccountHolder extends DAO {
	public ArrayList<AccountHolder> getAll() {
		String query =
				"   SELECT userInfo.userId, userInfo.completeName, userInfo.personTypeId, accounts.accountTypeId, accounts.id, accounts.balance "
				+ " FROM userInfo "
				+ " INNER JOIN accounts ON accounts.holderId = userInfo.userId "
				+ " ORDER BY userInfo.userId; ";
		try {
			ResultSet rs = executeQuery(query);
			return this.makeAccountHolderList(rs);			
		} catch (Exception e) {
			ErrorHandler.printToConsole("DAOAccountHolder.getAll" + e.getMessage());
			return null;
		}
	}
	
	public AccountHolder getAccountHolder(int userId) {
		String query =
				"   SELECT userInfo.userId, userInfo.completeName, userInfo.personTypeId, accounts.accountTypeId, accounts.id, accounts.balance "
				+ " FROM userInfo "
				+ " INNER JOIN accounts ON accounts.holderId = userInfo.userId "
				+ " WHERE userInfo.userId = "+ userId +"; ";
		try {
			ResultSet rs = executeQuery(query);
			return this.makeAccountHolderList(rs).get(0);
		} catch (Exception e) {
			ErrorHandler.printToConsole("DAOAccountHolder.getAll" + e.getMessage());
			return null;
		}
	}
	
	public ArrayList<Stock> getAccountTransactions(int userId) {
		return null;
	}
	
	public ArrayList<AccountHolder> makeAccountHolderList(ResultSet rs) throws SQLException, Exception {
		ArrayList<AccountHolder> holderList = new ArrayList<AccountHolder>();
		AccountHolder accountHolder = new AccountHolder();
		while (rs.next()) {
			if(accountHolder.holderId != rs.getInt("userInfo.userId")) {
				accountHolder = new AccountHolder();
				
				accountHolder.holderId = rs.getInt("userInfo.userId");
				accountHolder.holderInfo.completeName = rs.getString("userInfo.completeName");
				accountHolder.holderInfo.personTypeId = UserInfo.getPersonTypeFromValue(rs.getInt("userInfo.personTypeId"));
				
				holderList.add(accountHolder);
			}
			AccountType accountType = AccountType.byValue(rs.getInt("accounts.accountTypeId"));
			Account account = AccountsFactory.makeAccount(
					accountType,
					rs.getInt("accounts.id"),
					accountHolder,
					rs.getFloat("accounts.balance")
				);
			if (account instanceof CheckingAccount)
				accountHolder.checkingAccount = (CheckingAccount) account;
			else if (account instanceof IdrAccount)
				accountHolder.idrAccount = (IdrAccount) account;
			else if (account instanceof AutoInvestmentAccount)
				accountHolder.autoInvestmentAccount = (AutoInvestmentAccount) account;
		}
		return holderList;
	}
}
