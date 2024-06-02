package models.users;

import java.util.ArrayList;

import models.accounts.Account;

public class AccountHolder {
	public int holderId;
	public UserInfo holderInfo;
	public ArrayList<Account> accounts;
	
	public AccountHolder() {
		this.holderId = 0;
		this.holderInfo = new UserInfo();
		this.accounts = new ArrayList<Account>();
	}
	
	public AccountHolder(int holderId, UserInfo holderInfo, ArrayList<Account> accounts) {
		this.holderId = holderId;
		this.holderInfo = holderInfo;
		this.accounts = accounts;
	}
}
