package libs;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import libs.customExceptions.UserInputException;

public class InputValidator {
	private InputValidator() {}
	
	public static boolean validateEmail(String email) throws UserInputException {		
		if (getCharRepetitionCount(email, '@') != 1)
			throw new UserInputException("Email inválido: Um email precisa ter um exatamente um \"@\".");
		if (email.length() > 256)
			throw new UserInputException("Email inválido: limite de 256 caracteres ultrapassado.");
		if (email.substring(email.indexOf('@')).length() >= 255)
			throw new UserInputException("Email inválido: limite de 255 caracteres após o \"@\" ultrapassado.");
		if (email.substring(0, email.indexOf('@')).length() >= 64)
			throw new UserInputException("Email inválido: limite de 64 caracteres antes o \"@\" ultrapassado.");
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
	
	public static boolean validatePassword(String password) throws UserInputException {
		if (isStringMatch(password, "[^a-z0-9@#$%&*]", Pattern.CASE_INSENSITIVE))
			throw new UserInputException("Senha inválida: uma pode conter caracteres especiais fora \"@#$%&*\".");
		return true;
	}
	
	private static boolean isStringMatch(String str, String regexPattern, int pattenFlag) throws UserInputException {
		Pattern compiledPattern = Pattern.compile(regexPattern, pattenFlag);
		Matcher matcher = compiledPattern.matcher(str);
		return matcher.find();
	}
	
	public static boolean validatePhone(String phone) throws UserInputException {
		if (isStringMatch(phone, "([0-9]{2})[0-9]{4,5}-[0-9]{4}", Pattern.CASE_INSENSITIVE))
			throw new UserInputException("Telefone inválido: Um telefone deve seguir o formato: (99)1234-1234 ou (99)92345-1234");
		return true;
	}
	
	public static boolean validateCPF(String cpf) throws UserInputException {
		if (isStringMatch(cpf, "[0-9]{3}.[0-9]{3}.[0-9]{3}-[0-9]{2}", Pattern.CASE_INSENSITIVE))
			throw new UserInputException("CPF inválido: Um CPF deve seguir o formato: 123.456.789-12");
		return true;
	}
	
	public static boolean validateCNPJ(String cnpj) throws UserInputException {
		if (isStringMatch(cnpj, "[0-9]{2}.[0-9]{3}.[0-9]{3}/0001-[0-9]{2}", Pattern.CASE_INSENSITIVE))
			throw new UserInputException("CNPJ inválido: Um CPNJ deve seguir o formato: 12.345.678/0001-12");
		return true;
	}
	
	public static boolean validateRequiredField(String value) throws UserInputException {
		 return validateRequiredField("Erro de validação:", value);
	}
	
	public static boolean validateRequiredField(String fieldName, String value) throws UserInputException {
		if (value == null || value.equals(""))
			throw new UserInputException(fieldName + ": Campo não pode estar vázio.");
		return true;
	}
}
