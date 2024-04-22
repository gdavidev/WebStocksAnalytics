package models;

public class VariableIncomeStock extends Stock {
	public float expectancy;
	
	public VariableIncomeStock(int id, String name, String description, float yield, float expectancy) {
		super(id, name, description, yield);
		this.expectancy = expectancy;
	}

}
