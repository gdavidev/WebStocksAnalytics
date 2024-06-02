package models.accounts;

import models.users.AccountHolder;

public class IdrAccount extends Account {
	public static final float monthlyTax = 0.07f;

	@Override
	public float getTaxedAmount() {
		return this.balance * monthlyTax / 100;
	}
	
	public IdrAccount(int id, AccountHolder holderId, float balance) {
		super(id, holderId, balance);
	}
}
