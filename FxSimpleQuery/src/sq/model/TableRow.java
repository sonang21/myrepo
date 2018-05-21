package sq.model;

import java.util.ArrayList;

import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
//import javafx.beans.property.StringProperty;

@SuppressWarnings({"rawtypes"})
public class TableRow {
	private ArrayList<TableColumn> _colums;
	
	public <T> void addColumn(TableColumn<T> col) {
		_colums.add(col);
	}
}


class TableColumn<T> {
	T _cellData;
	public TableColumn(T cellData) {
		_cellData = cellData;
	}
	
	@SuppressWarnings({"unchecked", "hiding"})
	public <T> T getProperty() {
		return (T)_cellData;
	}
	
	@SuppressWarnings({"unchecked", "hiding", "rawtypes"})
	public <T> T getValue() {
		if (_cellData.getClass() == SimpleStringProperty.class) {
			return (T)String.valueOf(((SimpleStringProperty) _cellData).get());
		} else if (_cellData.getClass() == SimpleIntegerProperty.class) {
			return (T) Integer.valueOf(((SimpleIntegerProperty) _cellData).get());
		} else if (_cellData.getClass() == SimpleBooleanProperty.class) {
			return (T) Boolean.valueOf(((SimpleBooleanProperty) _cellData).get());
		} else {
			return (T)(((SimpleObjectProperty) _cellData).get());
		}
	}
	
	@SuppressWarnings({"rawtypes","hiding","all"})
	public <T> void setValue(T t) {
		if (_cellData.getClass() == SimpleStringProperty.class) {
			((SimpleStringProperty) _cellData).set((String)t);
		} else if (_cellData.getClass() == SimpleIntegerProperty.class) {
			((SimpleIntegerProperty) _cellData).set((int)t);
		} else if (_cellData.getClass() == SimpleBooleanProperty.class) {
			((SimpleBooleanProperty) _cellData).set((boolean)t);
		} else {
			((SimpleObjectProperty) _cellData).set((Object) t);
		}
	}
}
