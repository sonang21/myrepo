package ck.makery.address.model;

import java.time.LocalDate;

import javafx.beans.property.IntegerProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import sonang.utils.date.LocalDateAdapter;

import javax.xml.bind.annotation.adapters.XmlAdapter;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

/**
 * 연락서 모델 클래스
 * @author sonan
 *
 */
public class Person {
	
//	private final StringProperty _sFirstName;
//	private final StringProperty _sLastName;
//	private final StringProperty _sStreet;
//	private final IntegerProperty _nPostalCode;
//	private final StringProperty _sCity;
//	private final ObjectProperty<LocalDate> _oBirthDay;
	
	private  StringProperty _sFirstName;
	private  StringProperty _sLastName;
	private  StringProperty _sStreet;
	private  IntegerProperty _nPostalCode;
	private  StringProperty _sCity;
	private  ObjectProperty<LocalDate> _oBirthDay;
	
	public Person() {
		_sFirstName = new SimpleStringProperty("first name");
		_sLastName = new SimpleStringProperty("last name");
		_sStreet = new SimpleStringProperty("some street");
		_nPostalCode = new SimpleIntegerProperty(1234);
		_sCity = new SimpleStringProperty("some city");
		_oBirthDay = new SimpleObjectProperty<LocalDate> (LocalDate.of(1999, 2, 21));
	}
	public Person(String sFirstName, String sLastName) {
		this();
		_sFirstName = new SimpleStringProperty(sFirstName);
		_sLastName = new SimpleStringProperty(sLastName);
	}
	
	public String getFirstName() { return _sFirstName.get(); }
	public void setFirstName(String sFirstName) { _sFirstName.set(sFirstName); }
	public StringProperty firstNameProperty() { return _sFirstName; }
	
	public String getLastName() { return _sLastName.get(); }
	public void setLastName(String sLastName) { _sLastName.set(sLastName);}
	public StringProperty lastNameProperty() { return _sLastName; }

	public String getStreet() { return _sStreet.get(); }
	public void setStreet(String sStreet) { _sStreet.set(sStreet); }
	public StringProperty streetProperty() { return _sStreet; }
	
	public int getPostalCode() { return _nPostalCode.get(); }
	public void setPostalCode(int nPostalCode) { _nPostalCode.set(nPostalCode); }
	public IntegerProperty postalCodeProperty() { return _nPostalCode; }
	
	public String getCity() { return _sCity.get(); }
	public void setCity(String sCity) { _sCity.set(sCity); }
	public StringProperty cityProperty() { return _sCity; }
	
	@XmlJavaTypeAdapter(LocalDateAdapter.class)
	public LocalDate getBirthday() { return _oBirthDay.get(); }
	public void setBirthday(LocalDate oBirthday) { _oBirthDay.set(oBirthday); }
	public ObjectProperty<LocalDate> birthdayProperty() { return _oBirthDay; }
	
}
