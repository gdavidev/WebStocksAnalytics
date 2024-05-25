package dataAccess;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public abstract class DAO {
	private String driver = "org.mariadb.jdbc.Driver";
	private String url = "jdbc:mariadb://127.0.0.1:3306/vcriquinho?user=root&password=";
	private String user = "root";
	private String password = "";
	
	protected Connection connect() {
		try {
			Class.forName(driver);
			return DriverManager.getConnection(url, user, password);			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	protected ResultSet executeQuery(String query) throws SQLException {
		Connection conn = this.connect();
		PreparedStatement pst = conn.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		return rs;
	}
}
