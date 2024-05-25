package libs;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InputValidator {
	private InputValidator() {}
	
	public static boolean validateEmail(String email) throws Exception {		
		if (getCharRepetitionCount(email, '@') != 1)
			throw new Exception("Email inválido: Um email precisa ter um exatamente um \"@\".");
		if (email.length() > 256)
			throw new Exception("Email inválido: limite de 256 caracteres ultrapassado.");
		if (email.substring(email.indexOf('@')).length() >= 255)
			throw new Exception("Email inválido: limite de 255 caracteres após o \"@\" ultrapassado.");
		if (email.substring(0, email.indexOf('@')).length() >= 64)
			throw new Exception("Email inválido: limite de 64 caracteres antes o \"@\" ultrapassado.");
		return true;
	}
	
	private static int getCharRepetitionCount(String str, char c) {
		int count = 0;
		for (int i = 0; i < str.length(); i++) {
			if (str.charAt(i) == c)
				count++;
		}
		return count;
	}
	
	public static boolean validatePassword(String password) throws Exception {
		if (isStringMatch(password, "[^a-z0-9@#$%&*]", Pattern.CASE_INSENSITIVE))
			throw new Exception("Senha inválida: uma pode conter caracteres especiais fora \"@#$%&*\".");
		return true;
	}
	
	private static boolean isStringMatch(String str, String regexPattern, int pattenFlag) throws Exception {
		Pattern compiledPattern = Pattern.compile(regexPattern, pattenFlag);
		Matcher matcher = compiledPattern.matcher(str);
		return matcher.find();
	}
}
