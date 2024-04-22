package models;

public class FixedIncomeStock extends Stock {
	private int gracePeriodDays;
	
	public int getGracePeriodDays() {
		return this.gracePeriodDays;
	}
	
	public FixedIncomeStock(int id, String name, String description, float yield, int gracePeriodDays) {
		super(id, name, description, yield);
		this.gracePeriodDays = gracePeriodDays;
	}

}
