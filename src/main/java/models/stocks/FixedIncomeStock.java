package models.stocks;

public class FixedIncomeStock extends Stock {	
	private int gracePeriodDays;
	
	public int getGracePeriodDays() {
		return this.gracePeriodDays;
	}
	
	public FixedIncomeStock(int id, String companyName, String code, String description, float price, int gracePeriodDays) {
		super(id, companyName, code, description, price);
		this.gracePeriodDays = gracePeriodDays;
	}

}
