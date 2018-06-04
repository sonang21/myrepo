package bts.utils.fxext;

import java.util.ArrayList;

import javafx.beans.property.BooleanProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class RowData {
	public class Column {
		String name;
		Object value;
		
		public Column(String strName, Object objValue) {
			this.name = strName;
			this.value = objValue;
		}
	}
	
	private ArrayList<Column> _cols = new ArrayList<Column>();
//	private HashMap<String, Object> _cols = new HashMap<String, Object>();
	
	public RowData(Object...objs) {
		for(int i=0; i < objs.length; i++) {
			//_cols.put(String.valueOf(i),  objs[i]);
			setValue(String.valueOf(i), objs[i]);
		}
	}
	
	
	public int getIndex(String colName) {
		for (int i=0; i <_cols.size(); i++) {
			if (_cols.get(i).name.equalsIgnoreCase(colName)) {
				return i;
			}
		}
		return -1;
	}
	
	public boolean setName(int index, String colName) {
		if (index < _cols.size()) {
			_cols.get(index).name = colName;
			return true;
		} 
		else {
			return false;
		}
	}
	
	public int setValue(int colIndex, Object oValue) {
		if( colIndex < _cols.size()) {
			_cols.get(colIndex).value = oValue;
			return colIndex;
		}
		else {
			_cols.add(new Column(String.valueOf(_cols.size()),  oValue));
			return _cols.size() -1;
		}
	}

	public void setValue(String colName, Object oValue) {
		for (Column c : _cols) {
			if (c.name.equalsIgnoreCase(colName)) {
				c.value = oValue;
			}
		}
		_cols.add(new Column(colName,  oValue));
	}
	
	
	public void setValueInteger(int index, Integer iValue) {
		setValue(index, iValue);
	}	
	public void setValueInteger(String colName, Integer iValue) {
		setValue(colName, iValue);
	}
	
	public void setValueString(int index, String sValue) {
		setValue(index,  sValue);
	}
	public void setValueString(String colName, String sValue) {
		setValue(colName,  sValue);
	}
	
	
	public void setValueBoolean(int index, Boolean bValue) {
		setValue(index,  bValue);
	}	
	public void setValueBoolean(String colName, Boolean bValue) {
		setValue(colName,  bValue);
	}
	
	public void setBooleanReverse(int index) {
		setValue(index,  ! getValueBoolean(index));
	}	
	public void setBooleanReverse(String colName) {
		setValue(colName,  ! getValueBoolean(colName));
	}
	
	public Object getValue(int index) {
		if (index < _cols.size()) {
			return _cols.get(index).value;
		}
		else {
			return null;
		}
	}
	public Object getValue(String colName) {
		for(Column c : _cols) {
			if (c.name.equalsIgnoreCase(colName)) {
				return c.value;
			}
		}
		return null;
	}

	public Integer getValueInteger(int index) {
		return (Integer) getValue(index);
	}
	public Integer getValueInteger(String colName) {
		return (Integer) getValue(colName);
	}
	
	
	public String getValueString (int index) {
		return (String) getValue(index);
	}
	public String getValueString(String colName) {
		return (String) getValue(colName);
	}

	public Boolean getValueBoolean (int index) {
		Boolean bool = (Boolean)getValue(index);
		if (bool != null) {
			return bool;
		}
		else {
			return (Boolean) false;
		}
	}
	public Boolean getValueBoolean(String colName) {
		if(getValue(colName) != null) {
			return (Boolean) getValue(colName);
		}
		else {
			return (Boolean)false;
		}
	}
	
	public IntegerProperty getIntegerProperty(int index) {
		return new SimpleIntegerProperty(getValueInteger(index));
	}
	public IntegerProperty getIntegerProperty(String colName) {
		return new SimpleIntegerProperty(getValueInteger(colName));
	}

	public StringProperty getStringProperty(int index) {
		return new SimpleStringProperty(getValueString(index));
	}
	public StringProperty getStringProperty(String colName) {
		return new SimpleStringProperty(getValueString(colName));
	}

	public BooleanProperty getBooleanProperty(int index) {
		return new SimpleBooleanProperty(getValueBoolean(index));
	}
	public BooleanProperty getBooleanProperty(String colName) {
		return new SimpleBooleanProperty(getValueBoolean(colName));
	}

	public ObjectProperty<Object> getObjectProperty(int index) {
		return new SimpleObjectProperty<Object>(getValue(index));
	}
	public ObjectProperty<Object> getObjectProperty(String colName) {
		return new SimpleObjectProperty<Object>(getValue(colName));
	}

}
