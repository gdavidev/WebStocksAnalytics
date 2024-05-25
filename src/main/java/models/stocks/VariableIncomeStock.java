package models.stocks;

public class VariableIncomeStock extends Stock {
	public float expectancy;
	
	public VariableIncomeStock(int id, String companyName, String code, String description, float price, float expectancy) {
		super(id, companyName, code, description, price);
		this.expectancy = expectancy;
	}
	public VariableIncomeStock(int id, String companyName, String code, String description, float price, float expectancy, float priceVariation) {
		super(id, companyName, code, description, price, priceVariation);
		this.expectancy = expectancy;
	}

}
