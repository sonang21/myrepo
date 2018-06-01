package bts.app.model;

import java.util.HashMap;

//import javafx.beans.property.BooleanProperty;
//import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleStringProperty;
//import javafx.beans.property.ObjectProperty;
import javafx.beans.property.StringProperty;


//@SuppressWarnings("rawtypes")
public class RowData {
	private HashMap<String, Object> _cols = new HashMap<String, Object>();
	
	public RowData() {
		
	}
	public RowData(String...strings) {
		int i=0;
		for(String s:strings) {
			_cols.put(String.valueOf(i), s);
			i++;
		}
	}
	
	public void setValue(String sColName, String sValue) {
		_cols.put(sColName,  sValue);
	}

	public String getValue(String sColName) {
		if(_cols.containsKey(sColName)) {
			return (String) _cols.get(sColName);
		} 
		else {
			return "";
		}
	}

	public StringProperty getProperty(String sColName) {
		if(_cols.containsKey(sColName)) {
			return new SimpleStringProperty(_cols.get(sColName).toString());
//			if (_cols.get(sColName).getClass().getSimpleName().equalsIgnoreCase("String")) {
//				return new SimpleStringProperty((String)_cols.get(sName));
//			}
		} else {
			return null;
		}
	}

}

