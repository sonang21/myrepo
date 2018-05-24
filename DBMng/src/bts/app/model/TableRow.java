package bts.app.model;

//import java.util.ArrayList;
import java.util.Hashtable;


import javafx.beans.property.BooleanProperty;
import javafx.beans.property.IntegerProperty;
//import javafx.beans.property.ObjectProperty;
import javafx.beans.property.StringProperty;


@SuppressWarnings("rawtypes")
public class TableRow {
//	private ArrayList<TColumn> _columns;
	private Hashtable _columns;
	
	public TableRow() {
		_columns = new Hashtable();
	}
	
	@SuppressWarnings("unchecked")
	public void addColumn(String sColumnName, TColumn column) {
		_columns.put(sColumnName, column);
	}
	
	public TColumn getColumn(String sColumnName) {
		return (TColumn)_columns.get(sColumnName);
	}
	

}

