package models.users;

import models.accounts.AutoInvestmentAccount;
import models.accounts.CheckingAccount;
import models.accounts.IdrAccount;

public class AccountHolder {
	public int holderId;
	public UserInfo holderInfo;
	public CheckingAccount checkingAccount;
	public IdrAccount idrAccount;
	public AutoInvestmentAccount autoInvestmentAccount;
	
	public AccountHolder() {
		this.holderId = 0;
		this.holderInfo = new UserInfo();
		this.checkingAccount = null;
		this.idrAccount = null;
		this.autoInvestmentAccount = null;
	}
	
	public AccountHolder(int holderId, UserInfo holderInfo, CheckingAccount checkingAccount, IdrAccount idrAccount, AutoInvestmentAccount autoInvestmentAccount) {
		this.holderId = holderId;
		this.holderInfo = holderInfo;
		this.checkingAccount = checkingAccount;
		this.idrAccount = idrAccount;
		this.autoInvestmentAccount = autoInvestmentAccount;
	}
}
