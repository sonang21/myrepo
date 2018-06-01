package bts.app.model;

import java.util.HashMap;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class TestData {
	
	public String getName() { return "Name xx"; }
	public void setName(String sName) {};
	public String getValue() { return "Value xxx"; }
	
	private HashMap<String, Object> _cols = new HashMap<String, Object>();
	
	public TestData(String...strings) {
		int i=0;
		for(String s:strings) {
			_cols.put(String.valueOf(i), s);
			i++;
		}
	}
	
	public void setValue(String sName, String sValue) {
		_cols.put(sName,  sValue);
	}

	public StringProperty getProperty(String sName) {
		if(_cols.containsKey(sName)) {
			if (_cols.get(sName).getClass().getSimpleName().equalsIgnoreCase("String")) {
				return new SimpleStringProperty((String)_cols.get(sName));
			} else if(_cols.get(sName).getClass().getSimpleName().equalsIgnoreCase("Integer")) {
				return new SimpleStringProperty(_cols.get(sName).toString());
			} else {
				return new SimpleStringProperty(_cols.get(sName).toString());
			}
		} else {
			return null;
		}
	}
	
	
}
