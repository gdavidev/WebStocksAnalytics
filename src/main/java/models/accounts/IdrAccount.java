package models.accounts;

import models.users.AccountHolder;

public class IdrAccount extends Account {
	public static final float monthlyTax = 0.07f;

	public IdrAccount(int id, AccountHolder holderId, float balance) {
		super(id, holderId, balance);
	}
}
