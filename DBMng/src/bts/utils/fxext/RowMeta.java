package bts.utils.fxext;

public class RowMeta {
	public int columnIndex;
	public String columnName;
	public String headerText;
	public String dataType;
	public boolean isEditable;
	public String controlType;
	
	public RowMeta(int index, String name, String header, String type, boolean editable) {
		this.columnIndex = index;
		this.columnName =  name;
		this.headerText = header;
		this.dataType = type;
		this.isEditable = editable;
		this.controlType = "";
	}
	public RowMeta(int index, String name, String header, String type, boolean editable, String control) {
		this.columnIndex = index;
		this.columnName =  name;
		this.headerText = header;
		this.dataType = type;
		this.isEditable = editable;
		this.controlType = control;
	}

}