package ck.makery.address.model;

import java.util.List;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlElement;



/**
 * 연락처 리스트를 감싸는 헬퍼 클래스이다.
 * XML로 저장하는 데 사용된다.
 */
@XmlRootElement(name = "persons")
public class PersonListWrapper {
	private List<Person> _persons;
	
	@XmlElement(name="person")
	public List<Person> getPersons() {
		return _persons;
	}
	
	public void setPersons(List<Person> persons) {
		this._persons = persons;
	}

	
}
