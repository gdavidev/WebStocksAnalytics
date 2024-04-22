package models;

public abstract class Account {
	private int id = 0;
	private AccountHolder holder;
	public float balance = 0;
	
	public final int getId() {
		return this.id;
	}
	public final AccountHolder getHolderId() {
		return this.holder;
	}
	
	Account(int id, AccountHolder holderId, float balance) {
		this.id = id;
		this.holder = holderId;
		this.balance = balance;
	}
	
	static final Boolean buyStock(int stockId) {
		return false;
	}
	static final Boolean sellStock(int stockId) {
		return false;
	}
}
