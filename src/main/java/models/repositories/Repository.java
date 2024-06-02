package models.repositories;

import java.util.HashMap;
import java.util.List;

public abstract class Repository extends HashMap<String, Object> {
	private static final long serialVersionUID = 1L;
	protected List<HashMap<String, Object>> content;
	protected HashMap<String, String> columnNames;
	
	public final String getDisplayableColumnName(String columnName) {
		return columnNames.get(columnName);
	}
	
	public void load() {}
}
