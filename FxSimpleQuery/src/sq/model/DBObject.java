package sq.model;

//import javafx.beans.InvalidationListener;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
//import javafx.beans.value.ChangeListener;
//import javafx.beans.value.ObservableValue;

public class DBObject {
	
	private StringProperty _spOwner;
	private StringProperty _spName;
	private StringProperty _spType;
	private BooleanProperty _bpChecked;
	
	public DBObject(String sOwner, String sName, String sType, Boolean bChecked) {
		_spOwner = new SimpleStringProperty(sOwner);
		_spName = new SimpleStringProperty(sName);
		_spType = new SimpleStringProperty(sType);
		_bpChecked = new SimpleBooleanProperty(bChecked);
	}
	
	public String getOnwer() { return _spOwner.get(); }
	public void setOwner(String sOwner) { _spOwner.set(sOwner); }
	public StringProperty ownerProperty() { return _spOwner; }

	public String getName() { return _spName.get(); }
	public void setName(String sName) { _spName.set(sName); }
	public StringProperty nameProperty() { return _spName; }

	public String getType() { return _spType.get(); }
	public void setType(String sType) { _spType.set(sType); }
	public StringProperty typeProperty() { return _spType; }
	
	public Boolean getChecked() { return _bpChecked.get(); }
	public void setChecked(Boolean bChecked) { _bpChecked.set(bChecked); }
	public BooleanProperty checkedProperty() { return _bpChecked; }
	
}
