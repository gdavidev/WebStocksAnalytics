package dataAccess;

import java.sql.ResultSet;

import models.users.User;
import models.users.UserInfo;

public final class DAOUsers extends DAO {
	public int getUserLoginId(String email, String password) {
		String query =
			  " SELECT id "
			+ " FROM users "
			+ " WHERE email = '" + email + "' "
			+ "	  AND loginPassword = '" + password + "' "
			+ " LIMIT 1;";	
		try {
			ResultSet rs = this.executeQuery(query);
			if (rs.getFetchSize() == 1) {			
				return rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e);
			return 0;
		}
		return 0;
	}
	
	public User getUser(int id) {
		String query =
			  " SELECT " 
		    + " 	users.id, " 
		    + "		users.userName, "
			+ " 	users.email, "
		    + " 	userInfo.completeName, "
			+ " 	users.loginPassword, "
			+ " 	userInfo.phone, "  
		    + " 	userInfo.personTypeId, "
			+ "		userInfo.document, " 
		    + " 	users.isAdmin "
			+ " FROM users "
			+ " INNER JOIN userInfo ON userInfo.userId = users.id "
			+ " WHERE users.id = " + id
			+ " LIMIT 1;";
		try {
			ResultSet rs = this.executeQuery(query);
			if (rs.getFetchSize() == 1) {	
				return new User(
					rs.getInt("users.id"), 
					rs.getString("users.userName"),
					rs.getString("users.email"),
					rs.getString("users.loginPassword"),
					new UserInfo(
						rs.getString("userInfo.completeName"),
						rs.getString("userInfo.phone"),
						UserInfo.getPersonTypeByValue(rs.getInt("userInfo.personTypeId")),
						rs.getString("userInfo.document")
					),
					rs.getBoolean("users.isAdmin")
				);
			}
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		return null;
	}
	
	public boolean isUserEmailAvailable(String email) {
		String query =
			  " SELECT COUNT(*) = 0 "
			+ " FROM users "
			+ " WHERE email = '" + email + "' ";
		try {
			ResultSet rs = this.executeQuery(query);
			if (rs.getFetchSize() == 1) {	
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
		return false;
	}
	
	public void storeUser(User user) throws Exception {
		UserInfo userInfo = user.userInfo;
		String query =
				  " BEGIN TRANSACTION "
				+ "     INSERT INTO "
				+ "     	users(userName, email, loginPassword) "
				+ "     VALUES "
				+ "     	(" + user.name +","+ user.email +","+ user.password + ");"
				+ "     SELECT LAST_INSERT_ID();"
				+ "     INSERT INTO "
				+ "	    	userInfo(userId, completeName, personTypeId, document)"
				+ "	    VALUES "
				+ "     	(LAST_INSERT_ID(), "+ userInfo.completeName +","+ userInfo.phone +","+ UserInfo.getPersonTypeValue(userInfo.personTypeId) +","+ userInfo.document +");"
				+ " COMMIT;";
			try {
				ResultSet rs = this.executeQuery(query);
				user.id = rs.getInt("lastUserId");
			} catch (Exception e) {
				System.out.println(e);
			}
	}
}
