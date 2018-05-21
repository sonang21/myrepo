package ck.makery.address.model;

import java.util.List;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlElement;



/**
 * ����ó ����Ʈ�� ���δ� ���� Ŭ�����̴�.
 * XML�� �����ϴ� �� ���ȴ�.
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
