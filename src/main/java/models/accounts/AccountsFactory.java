package models.accounts;

import models.accounts.Account.AccountType;
import models.users.AccountHolder;

public final class AccountsFactory {	
	public static Account makeAccount(AccountType accountTypeId, int id, AccountHolder holder, float balance) throws Exception {
		switch (accountTypeId) {
		case CHECKING_ACCOUNT:
			return new CheckingAccount(id, holder, balance);			
		case IDR_ACCOUNT:
			return new IdrAccount(id, holder, balance);
		case AUTO_INVESTMENT_ACCOUNT:
			return new AutoInvestmentAccount(id, holder, balance);
		default:
			throw new Exception("Account type can't be null");
		}
	}
	
	public static Account makeAccount(int accountTypeId, int id, AccountHolder holder, float balance) throws Exception {
		return makeAccount(AccountType.byValue(accountTypeId), id, holder, balance);
	}
}
