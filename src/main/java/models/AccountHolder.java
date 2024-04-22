package models;

public class AccountHolder {
	public int id;
	public String name;
	private String documentNumber;
	
	public String getDocumentNumber() {
		return this.documentNumber;
	}
	
	public AccountHolder(int id, String name, String documentNumber) {
		this.id = id;
		this.name = name;
		this.documentNumber = documentNumber;
	}
}
