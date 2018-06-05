package bts.utils.fxext;

public class RowMeta {
	public static enum DATATYPE { STRING, INTEGER, DOUBLE, BOOLEAN, OBJECT, NONE };
	public int columnIndex;
	public String columnName;
	public String headerText;
	public boolean isEditable;
	public DATATYPE dataType;
	
	public RowMeta(int index, String name, String header, DATATYPE type, boolean editable) {
		this.columnIndex = index;
		this.columnName =  name;
		this.headerText = header;
		this.dataType = type;
		this.isEditable = editable;
	}
	public RowMeta(int index, String name, String header, DATATYPE type, boolean editable, String control) {
		this.columnIndex = index;
		this.columnName =  name;
		this.headerText = header;
		this.dataType = type;
		this.isEditable = editable;
	}

}
