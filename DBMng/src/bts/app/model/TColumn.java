package bts.app.model;

import javafx.beans.property.BooleanProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

//extends StringProperty, IntegerProperty, BooleanProperty, ObjectProperty
public class TColumn<T> { 
	T _column;
	
	public TColumn(Integer iVal) {
		//this.setInt(iVal);
		_column = (T)iVal;
	}
	public TColumn(String sVal) {
		//this.setString(sVal);
		_column = (T)sVal;
	}

	public String 	getString() { 
		return (String)_column; 
	}
	public int    	getInt() { 
		return ((IntegerProperty)_column).get(); 
	}
	public Boolean 	getBoolean() { 
		return ((BooleanProperty)_column).get(); 
	}
	
	public void setString(String sValue) { 
		((StringProperty)_column).set(sValue); 
	}
	public void setInt(int iValue) {
		((IntegerProperty)_column).set(iValue);
	}
	public void setBoolean(Boolean bValue) {
		((BooleanProperty)_column).set(bValue);
	}
	
	public StringProperty getStringProperty() {
		return (StringProperty) _column;
	}
	public IntegerProperty getIntegerProperty() {
		return (IntegerProperty) _column;
	}
	public BooleanProperty getBooleanProerty() {
		return (BooleanProperty) _column;
	}
	
}
