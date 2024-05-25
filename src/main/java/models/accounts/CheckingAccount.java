package models.accounts;

import models.users.AccountHolder;

public class CheckingAccount extends Account {
	public CheckingAccount(int id, AccountHolder holderId, float balance) {
		super(id, holderId, balance);
	}
}
