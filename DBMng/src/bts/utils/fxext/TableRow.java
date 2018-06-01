package bts.utils.fxext;

import java.util.HashMap;

import javafx.beans.property.BooleanProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class TableRow {
	
	private HashMap<String, Object> _cols = new HashMap<String, Object>();
	
	public TableRow(Object...objs) {
		for(int i=0; i < objs.length; i++) {
			//_cols.put(String.valueOf(i),  objs[i]);
			setValue(String.valueOf(i), objs[i]);
		}
	}
	
	public void setValue(String colName, Object oValue) {
		_cols.put(colName,  oValue);
	}
	
	public void setValueString(String colName, String sValue) {
		_cols.put(colName,  sValue);
	}
	
	public void setValueBoolean(String colName, Boolean bValue) {
		_cols.put(colName,  bValue);
	}
	
	public void setBooleanReverse(String colName) {
		_cols.put(colName,  ! getValueBoolean(colName));
	}
	
	
	public Object getValue(String colName) {
		if (_cols.containsKey(colName)) {
			return _cols.get(colName);			
		}
		else {
			return null;
		}
	}
	
	public String getValueString(String colName) {
		return (String) getValue(colName);
	}
	
	public Boolean getValueBoolean(String colName) {
		if(getValue(colName) != null) {
			return (Boolean) getValue(colName);
		}
		else {
			return false;
		}
	}
	
	public StringProperty getStringProperty(String colName) {
		return new SimpleStringProperty(getValueString(colName));
	}

	public BooleanProperty getBooleanProperty(String colName) {
		return new SimpleBooleanProperty(getValueBoolean(colName));
	}

	public ObjectProperty<Object> getObjectProperty(String colName) {
		return new SimpleObjectProperty<Object>(getValue(colName));
	}

}
