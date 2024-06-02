package libs.customExceptions;

public class UserInputException extends Exception {
	private static final long serialVersionUID = 1L;
	private String displayableMessage;
	
	public String getDisplayableMessage() {
		return this.displayableMessage;
	}

	public UserInputException(String displayableMessage, String debugMessage) {
		super(debugMessage);
		this.displayableMessage = displayableMessage;
	}
	
	public UserInputException(String displayableMessage) {
		super(displayableMessage);
		this.displayableMessage = displayableMessage;
	}
}
