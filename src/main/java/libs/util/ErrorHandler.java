package libs.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ErrorHandler {
	public static void printToConsole(String message) {
		String currentTimeStamp = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss").format(LocalDateTime.now());
		System.out.println(currentTimeStamp + " | " + message);
	}
}
