package models.stocks;

public abstract class Stock {
	private int id;
	public String companyName;
	public String code;
	public String description;
	public float price;
	
	public final int getId() {
		return this.id;
	}
	
	Stock(int id, String companyName, String code, String description, float price) {
		this.id = id;
		this.code = code;
		this.companyName = companyName;
		this.description = description;
		this.price = price;
	}
}
