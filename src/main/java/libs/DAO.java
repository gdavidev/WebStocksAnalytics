package libs;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
	private String driver = "org.mariadb.jdbc.Driver";
	private String url = "jdbc:mariadb://127.0.0.1:3306/vcriquinho?user=root&password=";
	private String user = "root";
	private String password = "";
	
	private Connection connect() {
		try {
			Class.forName(driver);
			return DriverManager.getConnection(url, user, password);			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
}
