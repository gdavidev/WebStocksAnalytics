package models.repositories;

import java.util.HashMap;

public class UsersViewRepository extends Repository {
	private static final long serialVersionUID = 1L;
	
	@Override
	public void load() {
		loadHeaderNames();
	}
	
	private void loadHeaderNames() {
		HashMap<String , String> newColumnNames = new HashMap<String , String>() {
			private static final long serialVersionUID = 1L;
		{
			put("holderId", "ID");
			put("userName", "User Name");
			put("personType", "Person Type");
			put("checkingAccountBalance", "Checking");
			put("checkingAccountTotalTax", "Checking Tax");
			put("idrAccountBalance", "IDR");
			put("idrAccountTotalTax", "IDR Tax");
			put("autoInvestAccountBalance", "Auto Invest");
			put("autoInvestAccountTotalTax", "Auto Invest Tax");
			put("totalTax", "Total Tax");
		}};
		columnNames = newColumnNames;
	}
}
