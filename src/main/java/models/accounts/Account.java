package models.accounts;

import java.util.Arrays;

import models.users.AccountHolder;

public abstract class Account {
	public enum AccountType {
		CHECKING_ACCOUNT (1),
		IDR_ACCOUNT (2),
		AUTO_INVESTMENT_ACCOUNT (3);
		
		Integer accountTypeId;		
		AccountType(int accountTypeId) {
			this.accountTypeId = accountTypeId;
		}
		
		public static final AccountType byValue(Integer value) {
			return Arrays.stream(AccountType.values()).filter(accountType -> accountType.accountTypeId.equals(value)).findFirst().orElse(CHECKING_ACCOUNT);
		}
	}
	
	private int id = 0;
	private AccountHolder holder;
	public float balance = 0;
	
	public final int getId() {
		return this.id;
	}
	public final AccountHolder getHolder() {
		return this.holder;
	}
	
	Account(int id, AccountHolder holder, float balance) {
		this.id = id;
		this.holder = holder;
		this.balance = balance;
	}
	
	public float getTaxedAmount() {
		return 0f;
	}
}
