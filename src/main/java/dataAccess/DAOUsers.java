package dataAccess;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;

import libs.util.ErrorHandler;
import models.users.User;
import models.users.UserInfo;

public final class DAOUsers extends DAO {
	public int getUserLoginId(String email, String password) {
		String query = " SELECT id " + " FROM users " + " WHERE email = '" + email + "' " + "	  AND loginPassword = '"
				+ password + "' " + " LIMIT 1;";
		try {
			ResultSet rs = this.executeQuery(query);
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			ErrorHandler.printToConsole("getUserLoginId: " + e.toString());
		}
		return 0;
	}

	public User getUser(int id) {
		String query = " SELECT " + " 	users.id, " + "		users.userName, " + " 	users.email, "
				+ " 	userInfo.completeName, " + " 	users.loginPassword, " + " 	userInfo.phone, "
				+ " 	userInfo.personTypeId, " + "		userInfo.document, " + " 	users.isAdmin " + " FROM users "
				+ " INNER JOIN userInfo ON userInfo.userId = users.id " + " WHERE users.id = " + id + " LIMIT 1;";
		try {
			ResultSet rs = this.executeQuery(query);
			rs.next();
			return new User(rs.getInt("users.id"), rs.getString("users.userName"), rs.getString("users.email"),
					rs.getString("users.loginPassword"),
					new UserInfo(rs.getString("userInfo.completeName"), rs.getString("userInfo.phone"),
							UserInfo.getPersonTypeFromValue(rs.getInt("userInfo.personTypeId")),
							rs.getString("userInfo.document")),
					rs.getBoolean("users.isAdmin"));
		} catch (Exception e) {
			ErrorHandler.printToConsole("getUser: " + e.toString());
		}
		return null;
	}

	public boolean isUserEmailAvailable(String email) {
		String query = " SELECT COUNT(*) = 0 " + " FROM users " + " WHERE email = '" + email + "' ";
		try {
			ResultSet rs = this.executeQuery(query);
			if (rs.getFetchSize() == 1) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			ErrorHandler.printToConsole("isUserEmailAvailable: " + e.toString());
			return false;
		}
		return false;
	}

	public void storeUser(User user) throws Exception {
		String query = "{ call sp_store_user(?,?,?,?,?,?,?,?) }";		

		try (
			Connection conn = this.connect();
			CallableStatement pst = conn.prepareCall(query);
		) {
			pst.setString(1, user.name);
			pst.setString(2, user.email);
			pst.setString(3, user.password);
			pst.setString(4, user.userInfo.completeName);
			pst.setString(5, user.userInfo.phone);
			pst.setInt(6, UserInfo.getPersonTypeValue(user.userInfo.personTypeId));
			pst.setString(7, user.userInfo.document);
			pst.registerOutParameter(8, Types.INTEGER);
			
			pst.execute();
			user.id = pst.getInt(8);
			
			pst.close();
		} catch (Exception e) {
			ErrorHandler.printToConsole("storeUser: " + e.toString());
		}
	}
}