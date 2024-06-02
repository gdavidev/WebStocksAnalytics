package models.accounts;

import models.users.AccountHolder;
import models.users.UserInfo;

public class CheckingAccount extends Account {
	public CheckingAccount(int id, AccountHolder holderId, float balance) {
		super(id, holderId, balance);
	}
}
