package models.users;

public class User {
	public int id;
	public String email;
	public String password;
	public String name;
	public UserInfo userInfo;
	private boolean isAdmin;
	
	public boolean getIsAdmin() {
		return this.isAdmin;
	}
		
	public User(int id, String name, String email, String password, UserInfo userInfo, boolean isAdmin) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.userInfo = userInfo;
		this.isAdmin = isAdmin;
	}
	public User() {
		this.id = 0;
		this.name = "";
		this.email = "";
		this.password = "";
		this.userInfo = new UserInfo();
		this.isAdmin = false;
	}
}
