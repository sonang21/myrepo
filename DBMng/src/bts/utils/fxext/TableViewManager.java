package bts.utils.fxext;

import java.util.ArrayList;


//import org.apache.poi.ss.formula.functions.T;

import bts.utils.fxext.RowMeta.DATATYPE;
//import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView.TableViewFocusModel;
import javafx.scene.control.cell.CheckBoxTableCell;
import javafx.scene.control.cell.ComboBoxTableCell;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;

public class TableViewManager {
	 
	private TableView<RowData> _tableView;
	private ArrayList<RowMeta> _rowMeta;

	private ObservableList<RowData> _rows;
	private RowData _rowData;
	
	public TableViewManager(TableView<RowData> tableView) {
		this(tableView, false);
	}

	public TableViewManager(TableView<RowData> tableView, boolean clearColumn) {
		setTableView(tableView, clearColumn);
		_rowData = new RowData();
		_rowMeta = new ArrayList<>();
	}
	
	public TableView<RowData> getTableView() {
		return _tableView;
	}
	
	public void setTableView(TableView<RowData> tableView, boolean clearColumn) {
		_tableView = tableView;
		if(clearColumn) {
			_tableView.getColumns().clear();
		}
	}
	
	public void setEditable(boolean editable) {
		_tableView.setEditable(editable);
	}
	
	/**
	 * ���� �÷� ��Ͽ� �ִ��� Ȯ���ϰ�, ���� ��� �߰���
	 * @param colName
	 * @param header
	 * @return boolean : �÷���Ͽ� ��� �߰��� ��� true, �÷���Ͽ� �����Ͽ� �߰����� ���� ��� false
	 */

	private boolean addColumnList(String colName, String header, DATATYPE type, boolean editable) {
		//if(_rowMeta.contains(colName))
		for(RowMeta m : _rowMeta)
		{
			if(m.columnName.equalsIgnoreCase(colName)) {
				//throw new Exception("addColumnString(): [" + colName + "] is already exists.");
				System.err.println("addColumnString(): [" + colName + "] is already exists.");
				return false;
			}
		}		
		_rowMeta.add(new RowMeta(_rowMeta.size(), colName, header, type, editable));
		return true;
	}

	public int getColumnIndex(String colName) {
		for(RowMeta m : _rowMeta) {
			if(m.columnName.equalsIgnoreCase(colName)) {
				return m.columnIndex;
			}
		}
		return -1;
	}
	
	private String getColumnName(int columnIndex) {
		if(columnIndex < _rowMeta.size()) {
			return _rowMeta.get(columnIndex).columnName;
		} else {
			return null;
		}
	}
	
	private DATATYPE getColumnDataType(String colName) {
		for(RowMeta m : _rowMeta) {
			if(m.columnName.equalsIgnoreCase(colName)) {
				return m.dataType;
			}
		}
		return DATATYPE.NONE;
	}
	
	@SuppressWarnings("unused")
	private boolean setColumnName(int columnIndex, String colName) {
		if(columnIndex < _rowMeta.size()) {
			_rowMeta.get(columnIndex).columnName = colName;
			return true;
		} else {
			return false;
		}
	}
	
	public ArrayList<RowMeta> getRowMeta() {
		return _rowMeta;
	}
	
	public void addColumnInteger(int index, String header, boolean isEditable) {
		addColumnDouble(String.valueOf(index), header, isEditable);
	}
	public void addColumnInteger(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, DATATYPE.INTEGER, isEditable)) {
			TableColumn<RowData, Number> col = new TableColumn<>(header);
			col.setCellValueFactory(cellData -> cellData.getValue().getIntegerProperty(colName));
			if (isEditable) {
				col.setCellFactory(cellDataFeatures -> new NumberTableCell<Integer>(colName));
				col.setOnEditCommit((CellEditEvent<RowData, Number> event) -> {
					event.getRowValue().setValue(colName, event.getNewValue());
				});
				
			}
			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValueString(colName, ""); });
			
			_tableView.getColumns().add(col);		
		}
	}

	public void addColumnDouble(int index, String header, boolean isEditable) {
		addColumnDouble(String.valueOf(index), header, isEditable);
	}
	public void addColumnDouble(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, DATATYPE.DOUBLE, isEditable)) {
			TableColumn<RowData, Number> col = new TableColumn<>(header);
			col.setCellValueFactory(cellData -> cellData.getValue().getDoubleProperty(colName));
			if (isEditable) {
				col.setCellFactory(cellDataFeatures -> new NumberTableCell<Double>(colName));
				col.setOnEditCommit((CellEditEvent<RowData, Number> event) -> {
					event.getRowValue().setValue(colName, event.getNewValue());
				});
				
			}
			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValueString(colName, ""); });
			
			_tableView.getColumns().add(col);		
		}
	}
	

	public void addColumnString(int index, String header, boolean isEditable) {
		addColumnString(String.valueOf(index), header, isEditable);
	}
	public void addColumnString(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, DATATYPE.STRING, isEditable)) {
			TableColumn<RowData, String> col = new TableColumn<RowData, String>(header);
			col.setCellValueFactory(cellData -> cellData.getValue().getStringProperty(colName));
			if (isEditable) {
				col.setCellFactory(cellDataFeatures -> new StringTableCell(colName));
				col.setOnEditCommit((CellEditEvent<RowData, String> event) -> {
					event.getRowValue().setValue(colName, event.getNewValue());
				});
				
			}
			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValueString(colName, ""); });
			
			_tableView.getColumns().add(col);		
		}
	}
	
	public void addColumnCheckBox(int index, String header, boolean isEditable) {
		addColumnCheckBox(String.valueOf(index), header, isEditable);
	}
	/**
	 * checkBox�� ��� Cell�� �ƴ� checkBox ��ü Ŭ���� Cell�� ���޵��� �ʰ� ���θ� ó���Ǿ� �̺�Ʈ ���� ���� 
	 * @param colName
	 * @param header
	 * @param isEditable
	 */
	public void addColumnCheckBox(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, DATATYPE.BOOLEAN, isEditable)) {
			TableColumn<RowData, Boolean> col = new TableColumn<RowData, Boolean>(header);
			col.setEditable(isEditable);
			col.setCellValueFactory(cellData -> cellData.getValue().getBooleanProperty(colName));
			if (isEditable) {
				setCheckBoxColumnEvent(getColumnIndex(colName));
				col.setCellFactory( cellDataFeatures -> {
					CheckBoxTableCell<RowData, Boolean> cell = new CheckBoxTableCell<RowData, Boolean>() {
						@Override
						public void updateItem(Boolean item, boolean empty) {
							super.updateItem(item, empty);
							CheckBox cb = (CheckBox)getGraphic();
							if(cb != null) {
								cb.setOnAction(event -> {
									getTableView().getSelectionModel().clearAndSelect(getIndex(), col);
									//clearAndSelect()�� ���� setCheckBoxColumnEvent�� Mouse�̺�Ʈ�� ���޵Ǿ� ó���ǹǷ� ���� �̺�Ʈ ó�� ����
									//���⼭ �̺�Ʈ ó���� ��� �������� event.consume() �߰� �ʿ�
//									getTableView().getSelectionModel().getSelectedItem().setBooleanReverse(colName);
									
//									System.out.println(String.format("setOnAction(): %d, %s"
//											, getIndex()
//											, getTableView().getFocusModel().getFocusedCell()
//											));
								});
							}
							
						}
						
					};
					return cell;
				});
				
				col.setOnEditCommit(event -> {
					int ir = event.getTablePosition().getRow();
					int ic = event.getTablePosition().getColumn();
					_tableView.getItems().get(ir).setValueBoolean(ic, event.getNewValue());
					System.out.println(String.format("addColumnCheckBox(): EditCommit [%d, %d] %s", ir, ic, event.getNewValue()
							));
				});
//				col.setCellFactory(cellDataFeatures -> {
//					CheckBoxTableCell<RowData, Boolean> cell = new CheckBoxTableCell<>();
//					
//					cell.addEventFilter(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent> () {
//						@Override
//						public void handle(MouseEvent event) {
//							CheckBoxTableCell<RowData, Boolean> cb = (CheckBoxTableCell<RowData,Boolean>)event.getSource();
//						}
//					});
//					return cell;
//				});
			}
			else {
				//������ �ȵǵ��� ���콺, Ű �̺�Ʈ�� ��� ������
				col.setCellFactory(cellDataFeatures -> {
					CheckBoxTableCell<RowData, Boolean> cell = new CheckBoxTableCell<>();
					cell.addEventFilter(KeyEvent.ANY, new EventHandler<KeyEvent> () {
						@Override
						public void handle(KeyEvent event) {
							event.consume();
						}
					});
					cell.addEventFilter(MouseEvent.ANY, new EventHandler<MouseEvent> () {
						@Override
						public void handle(MouseEvent event) {
							event.consume();
						}
					});
					cell.setEditable(false);
					return cell;
				});
			}
			
			_tableView.getColumns().add(col);
			
			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValue(colName, false); });
		}
	}

	public void addColumnCheckBoxOrigin(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, DATATYPE.BOOLEAN, isEditable)) {
			TableColumn<RowData, Boolean> col = new TableColumn<RowData, Boolean>(header);
			col.setEditable(isEditable);
			col.setCellValueFactory(cellData -> cellData.getValue().getBooleanProperty(colName));
			if (isEditable) {
				setCheckBoxColumnEvent(getColumnIndex(colName));
				col.setCellFactory(CheckBoxTableCell.forTableColumn(col));
//				col.setCellFactory(param -> {
//						CheckBoxTableCell<RowData, Boolean> cell = new CheckBoxTableCell<>();
//						cell.setOnMouseClicked(event -> {
//							System.out.println("click");
//							
//						});
//					return cell;
//				});

				
				col.setOnEditCommit(event -> {
					int ir = event.getTablePosition().getRow();
					int ic = event.getTablePosition().getColumn();
					_tableView.getItems().get(ir).setValueBoolean(ic, event.getNewValue());
					System.out.println(String.format("[%d, %d] %s", ir, ic, event.getNewValue()
							));
				});
//				col.setCellFactory(cellDataFeatures -> {
//					CheckBoxTableCell<RowData, Boolean> cell = new CheckBoxTableCell<>();
//					
//					cell.addEventFilter(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent> () {
//						@Override
//						public void handle(MouseEvent event) {
//							CheckBoxTableCell<RowData, Boolean> cb = (CheckBoxTableCell<RowData,Boolean>)event.getSource();
//						}
//					});
//					return cell;
//				});
			}
			else {
				//������ �ȵǵ��� ���콺, Ű �̺�Ʈ�� ��� ������
				col.setCellFactory(cellDataFeatures -> {
					CheckBoxTableCell<RowData, Boolean> cell = new CheckBoxTableCell<>();
					cell.addEventFilter(KeyEvent.ANY, new EventHandler<KeyEvent> () {
						@Override
						public void handle(KeyEvent event) {
							event.consume();
						}
					});
					cell.addEventFilter(MouseEvent.ANY, new EventHandler<MouseEvent> () {
						@Override
						public void handle(MouseEvent event) {
							event.consume();
						}
					});
					cell.setEditable(false);
					return cell;
				});
			}
			
			_tableView.getColumns().add(col);
			
			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValue(colName, false); });
		}
	}

	public void addColumnComboBox(String colName, String header, boolean isEditable, String[] list) {
		if(addColumnList(colName, header, DATATYPE.STRING, isEditable)) {
			TableColumn<RowData, String> col = new TableColumn<RowData, String>(header);
			col.setEditable(isEditable);
			col.setCellValueFactory(row -> row.getValue().getStringProperty(colName));

			if (isEditable) {
				ObservableList<String> olist = FXCollections.observableArrayList(list);
				col.setCellFactory(ComboBoxTableCell.forTableColumn(olist));
				col.setOnEditCommit(event -> {
					int ir = event.getTablePosition().getRow();
					int ic = event.getTablePosition().getColumn();
					
					_tableView.getItems().get(ir).setValueString(ic, event.getNewValue());
				});
			}
			else {
				//������ �ȵǵ��� ���콺, Ű �̺�Ʈ�� ��� ������
				col.setCellFactory(cellDataFeatures -> {
					ComboBoxTableCell<RowData, String> cell = new ComboBoxTableCell<>();
					cell.addEventFilter(KeyEvent.ANY, new EventHandler<KeyEvent> () {
						@Override
						public void handle(KeyEvent event) {
							event.consume();
						}
					});
					cell.addEventFilter(MouseEvent.ANY, new EventHandler<MouseEvent> () {
						@Override
						public void handle(MouseEvent event) {
							event.consume();
						}
					});
					cell.setEditable(false);
					return cell;
				});
			}

			_tableView.getColumns().add(col);

			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValue(colName, ""); });
		}
	}
	
	public void setTableCellValue(int rowIndex, int columnIndex, Object oValue) {
		_tableView.getItems().get(rowIndex).setValue(columnIndex, oValue);
	}
	
	public void setTableCellValue(int rowIndex, String colName, Object oValue) {
		_tableView.getItems().get(rowIndex).setValue(colName, oValue);
	}
	
	public int getTableColumnCount() {
		if(_tableView != null) {
			return _tableView.getColumns().size();
		}
		else {
			return -1;
		}
	}
	
	public int getTableRowCount() {
		if(_tableView != null) {
			return _tableView.getItems().size();
		}
		else {
			return -1;
		}
	}
	
	
	public void addRowStrings(String...sargs) {
		if (_rows == null) _rows = FXCollections.observableArrayList();
		
		RowData row = new RowData();
		for(int i=0; i < sargs.length; i++) {
			row.setValue(_rowMeta.get(i).columnName, sargs[i]);
		}
		_rows.add(row);
	}

	public void addRowObjects(Object...oargs) {
		if (_rows == null) _rows = FXCollections.observableArrayList();

		RowData row = new RowData();
		for(int i=0; i < oargs.length; i++) {
			row.setValue(_rowMeta.get(i).columnName, oargs[i]);
		}
		_rows.add(row);
	}
	
	public void addRowData(RowData row) {
		if (_rows == null) _rows = FXCollections.observableArrayList();
		_rows.add(row);
	}
	public ObservableList<RowData> getRowDatas() {
		if (_rows == null) _rows = FXCollections.observableArrayList();
		return _rows;
	}
	
	public void setTableViewItems() {
		_tableView.setItems(_rows);
	}
	
	public void setTableViewItems(ObservableList<RowData> rows) {
		_rows.clear();
		_rows = rows;
		_tableView.setItems(rows);
	}
	
	public void setCheckBoxColumnEvent(int columnIndex) {
		_tableView.addEventFilter(KeyEvent.KEY_PRESSED,  new EventHandler<KeyEvent>() {
			@Override
			public void handle(KeyEvent event) {
				// TODO Auto-generated method stub
				if(event.getCode() == KeyCode.SPACE) {
					TableViewFocusModel<RowData> m = _tableView.getFocusModel();
					if (m != null && m.getFocusedCell().getColumn() == columnIndex) {
						// ������ ���� ������
						//_tableView.getItems().get(m.getFocusedIndex()).setBooleanReverse(columnIndex);
						//���õ� ���� ������
						_tableView.getSelectionModel().getSelectedItems().forEach(row -> row.setBooleanReverse(columnIndex));
						_tableView.getSelectionModel().getSelectedCells().forEach(cell -> cell.getTableColumn().setVisible(true));
						
						System.out.println(String.format("setCheckBoxColumnEvent(): index:%d, eventColumn:%s, colName:%s, value:%s"
								, columnIndex, m.getFocusedCell().getColumn()
								, getColumnName(columnIndex)
								, _tableView.getItems().get(m.getFocusedIndex()).getValueBoolean(columnIndex)
								));

						// ���ü��� �ٲ��� ���� ���¿��� �����̽� ���� �� �������� ���� ���ϳ�, ���÷��̰� �ٲ��� �ʴ� ����  visiable ���� �Ǵ� refresh ȣ���� �ʿ��� 
						m.getFocusedCell().getTableColumn().setVisible(false);
						m.getFocusedCell().getTableColumn().setVisible(true);
//						_tableView.refresh();
						event.consume();
					}
				}
				
			}
		});

		_tableView.addEventFilter(MouseEvent.MOUSE_CLICKED,  new EventHandler<MouseEvent>() {
			@Override
			public void handle(MouseEvent event) {
				// TODO Auto-generated method stub
				if(event.getButton() == MouseButton.PRIMARY && event.getClickCount()==1) {
					TableViewFocusModel<RowData> m = _tableView.getFocusModel();
					if (m != null && m.getFocusedCell().getColumn() == columnIndex) {
						// ������ ���� ������
						//_tableView.getItems().get(m.getFocusedIndex()).setBooleanReverse(columnIndex);
						//���õ� ���� ������
						_tableView.getSelectionModel().getSelectedItems().forEach(row -> row.setBooleanReverse(columnIndex));
						_tableView.getSelectionModel().getSelectedCells().forEach(cell -> cell.getTableColumn().setVisible(true));
						
						System.out.println(String.format("setCheckBoxColumnEvent(): index:%d, eventColumn:%s, colName:%s, value:%s"
								, columnIndex, m.getFocusedCell().getColumn()
								, getColumnName(columnIndex)
								, _tableView.getItems().get(m.getFocusedIndex()).getValueBoolean(columnIndex)
								));

						// ���ü��� �ٲ��� ���� ���¿��� �����̽� ���� �� �������� ���� ���ϳ�, ���÷��̰� �ٲ��� �ʴ� ����  visiable ���� �Ǵ� refresh ȣ���� �ʿ��� 
						m.getFocusedCell().getTableColumn().setVisible(false);
						m.getFocusedCell().getTableColumn().setVisible(true);
//						_tableView.refresh();
						event.consume();
					}
				}
				
			}
		});

	
	}
	
	public RowData newRowData() {
		if(_rowData == null) {
			_rowData = new RowData();
		}
		return _rowData;
	}
	
	public void setValue(String colName, String value) {
		try {
		switch (getColumnDataType(colName)) {
			case STRING :
				_rowData.setValueString(colName, value); 
				break;
			case DOUBLE :
				_rowData.setValueDouble(colName, Double.valueOf(value));
				break;
			case BOOLEAN :
				_rowData.setValueBoolean(colName, Boolean.valueOf(value));
				break;
			default :
				_rowData.setValue(colName, value);
		}
		} 
		catch (Exception ex) {
			System.err.println("TableViewManager.setValue() : colName=" + colName + ", value=" + value);
			ex.printStackTrace();
		}
	}
	public void addRowData() {
		addRowData(_rowData);
	}

}
