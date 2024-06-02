package models.users;

public class UserInfo {
	public static enum personType {
		PRIVATE_PERSON,
		LEGAL_PERSON
	}
	
	public String completeName;
	public String phone;
	public personType personTypeId;
	public String document;
		
	public UserInfo(String completeName, String phone, personType personTypeId, String document) {
		this.completeName = completeName;
		this.phone = phone;
		this.personTypeId = personTypeId;
		this.document = document;
	}
	public UserInfo() {
		this.completeName = "";
		this.phone = "";
		this.personTypeId = personType.PRIVATE_PERSON;
		this.document = "";
	}
	
	public static int getPersonTypeValue(personType value) {
		return value.ordinal();
	}
	public static personType getPersonTypeFromValue(int value) {
		for (int i = 0; i < personType.values().length; i ++) {
			if (personType.values()[i].ordinal() == value) {
				return personType.values()[i];
			}
		}
		return null;
	}
}
