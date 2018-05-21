package sonang.utils.date;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/** 
 * 날자를 제어하는 핼퍼 함수들
 * 
 * @author sonan
 *
 */
public class DateUtil {
	// 변환에 사용되는 날짜 패턴
	private static final String DATE_PATTERN = "yyyy.MM.dd";
	
	/**
	 * 날짜 변환기
	 */
	private static final DateTimeFormatter DATE_FORMATTER = 
			DateTimeFormatter.ofPattern(DATE_PATTERN);
	
	/**
	 * 
	 * 주어진 날짜를 String 타입으로 변환
	 * 위에서 정의한 {@link DateUtil#DATE_PATTERN} 사용
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
	 * String을 {@link DateUtil#DATE_PATTERN}에 정의한 대로 {@link LocalDate} 객체로 변환
	 * String이 변환되지 않으면 null을 반환
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
	 * 유효한 날짜 검사
	 * 
	 * @param dateString
	 * @return true if the String is a valid date
	 */
	public static boolean validDate(String dateString) {
		// Try to parse the String
		return DateUtil.parse(dateString) != null;
	}
	

}
