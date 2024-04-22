package models;

public class AutoInvestmentAccount extends Account {
	private static final float privatePersonMonthlyTax = 0.1f;
	private static final float legalPersonMonthlyTax = 0.15f;
	
	public static float getPrivatepersonmonthlytax() {
		return privatePersonMonthlyTax;
	}
	public static float getLegalpersonmonthlytax() {
		return legalPersonMonthlyTax;
	}
	
	public AutoInvestmentAccount(int id, AccountHolder holderId, float balance) {
		super(id, holderId, balance);
	}
}
