package models.stocks;

import java.util.Date;
import models.stocks.TransactionRegistry.ActionType;

public class TransactionRegistry {
	public enum ActionType {
		BUY,
		SELL
	}
	
	public int accountId;
	public String stockCode;
	public String stockName;
	public Date dateTime;
	public ActionType actionType;
	public float price;
	
	public TransactionRegistry() {
		this.accountId = 0;
		this.stockCode = "";
		this.stockName = "";
		this.dateTime = new Date();
		this.actionType = ActionType.BUY;
		this.price = 0f;
	}
	
	public TransactionRegistry(int accountId, String stockCode, String stockName, Date dateTime, ActionType actionType, float price) {
		this.accountId = accountId;
		this.stockCode = stockCode;
		this.stockName = stockName;
		this.dateTime = dateTime;
		this.actionType = actionType;
		this.price = price;
	}
}
