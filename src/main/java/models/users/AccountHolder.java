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
	
	public float getTotalBalance() {
		return	  (this.autoInvestmentAccount 	!= null ? this.autoInvestmentAccount.balance 	: 0)
				+ (this.idrAccount	 			!= null ? this.idrAccount.balance 				: 0)
				+ (this.checkingAccount 		!= null ? this.checkingAccount.balance 			: 0);
	}
	
	public float getTotalTax() {
		return 	  (this.autoInvestmentAccount 	!= null ? this.autoInvestmentAccount.getTaxedAmount() 	: 0)
				+ (this.idrAccount	 			!= null ? this.idrAccount.getTaxedAmount() 				: 0)
				+ (this.checkingAccount 		!= null ? this.checkingAccount.getTaxedAmount() 		: 0);
	}
}
