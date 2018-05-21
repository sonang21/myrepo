package sonang.utils.date;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/** 
 * ���ڸ� �����ϴ� ���� �Լ���
 * 
 * @author sonan
 *
 */
public class DateUtil {
	// ��ȯ�� ���Ǵ� ��¥ ����
	private static final String DATE_PATTERN = "yyyy.MM.dd";
	
	/**
	 * ��¥ ��ȯ��
	 */
	private static final DateTimeFormatter DATE_FORMATTER = 
			DateTimeFormatter.ofPattern(DATE_PATTERN);
	
	/**
	 * 
	 * �־��� ��¥�� String Ÿ������ ��ȯ
	 * ������ ������ {@link DateUtil#DATE_PATTERN} ���
	 * 
	 * @param date the date to be returned as a string
	 * @return formatted string 
	 */
	public static String format(LocalDate date ) {
		if(date == null) {
			return null;
		}
		return DATE_FORMATTER.format(date);
	}
	
	/**
	 * String�� {@link DateUtil#DATE_PATTERN}�� ������ ��� {@link LocalDate} ��ü�� ��ȯ
	 * String�� ��ȯ���� ������ null�� ��ȯ
	 * 
	 * @param dateString the date as String
	 * @return the date object or null if it could not be converted
	 */
	public static LocalDate parse(String dateString) {
		try {
			return DATE_FORMATTER.parse(dateString, LocalDate::from);
		} catch (DateTimeParseException ex) {
			return null;
		}
	}
	
	/**
	 * ��ȿ�� ��¥ �˻�
	 * 
	 * @param dateString
	 * @return true if the String is a valid date
	 */
	public static boolean validDate(String dateString) {
		// Try to parse the String
		return DateUtil.parse(dateString) != null;
	}
	

}
