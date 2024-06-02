package models.accounts;

import models.users.AccountHolder;
import models.users.UserInfo;

public class AutoInvestmentAccount extends Account {
	private static final float privatePersonMonthlyTax = 0.1f;
	private static final float legalPersonMonthlyTax = 0.15f;
	
	@Override
	public float getTaxedAmount() {
		float appliedTaxRate = (this.getHolder().holderInfo.personTypeId == UserInfo.personType.LEGAL_PERSON ? legalPersonMonthlyTax : privatePersonMonthlyTax);
		return this.balance * appliedTaxRate / 100;
	}
	
	public AutoInvestmentAccount(int id, AccountHolder holderId, float balance) {
		super(id, holderId, balance);
	}
}
