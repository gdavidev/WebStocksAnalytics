package models;

public abstract class Stock {
	private int id;
	public String name;
	public String description;
	public float yield;
	
	public final int getId() {
		return this.id;
	}
	
	Stock(int id, String name, String description, float yield) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.yield = yield;
	}
}
