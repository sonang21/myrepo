package bts.utils.fxext;

import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Objects;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView.TableViewFocusModel;
import javafx.scene.control.cell.CheckBoxTableCell;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;

public class TableViewManager {
	private TableView<RowData> _tableView;
	private ArrayList<RowMeta> _rowMeta = new ArrayList<>();

	private ObservableList<RowData> _rows;
	
	public TableViewManager(TableView<RowData> tableView) {
		setTableView(tableView, false);
	}

	public TableViewManager(TableView<RowData> tableView, boolean clearColumn) {
		setTableView(tableView, clearColumn);
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
	 * 기존 컬럼 목록에 있는지 확인하고, 없을 경우 추가함
	 * @param colName
	 * @param header
	 * @return boolean : 컬럼목록에 없어서 추가한 경우 true, 컬럼목록에 존재하여 추가하지 않은 경우 false
	 */

	private boolean addColumnList(String colName, String header, String type, boolean editable) {
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
		addColumnInteger(String.valueOf(index), header, isEditable);
	}
	public void addColumnInteger(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, "Integer", isEditable)) {
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
	

	public void addColumnString(int index, String header, boolean isEditable) {
		addColumnString(String.valueOf(index), header, isEditable);
	}
	public void addColumnString(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, "String", isEditable)) {
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
	public void addColumnCheckBox(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, "Boolean", isEditable)) {
			TableColumn<RowData, Boolean> col = new TableColumn<RowData, Boolean>(header);
			col.setEditable(true);
			col.setCellValueFactory(cellData -> cellData.getValue().getBooleanProperty(colName));
			if (isEditable) {
				col.setCellFactory(CheckBoxTableCell.forTableColumn(col));

//				col.setCellFactory(cellDataFeatures -> {
//					CheckBoxTableCell<TableRow, Boolean> cell = new CheckBoxTableCell<>();
//					
//					cell.selectedProperty().addListener((observable, oldValue, newValue) -> {
//						System.out.println("listener: " + oldValue + ", " + newValue);
//						//cell.commitEdit(newValue == null ? false : newValue);
//					});
//					return cell;
//				});
				setCheckBoxColumnEvent(getColumnIndex(colName));
			}
			else {
				//변경이 안되도록 마우스, 키 이벤트를 모두 차단함
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
				

			//			col.setCellFactory(cellFeatures -> new CheckBoxTableCell<TableRow, Boolean>());

//			col.addEventHandler(KeyEvent.KEY_PRESSED, new EventHandler<KeyEvent>() {
//				@Override
//				public void handle(final KeyEvent event) {
//					System.out.println(".......... keyevent.");
//				}
//			});
			
//			col.addEventHandler(KeyEvent.KEY_PRESSED, event -> {
//				System.err.println("............... key pressed. " + event.getCode().toString());
//				if(event.getCode() == KeyCode.SPACE) {
//					_tableView.getSelectionModel().getSelectedItem().setValue(
//							colName
//							, ! _tableView.getSelectionModel().getSelectedItem().getValueBoolean(colName));
//				}
//			});
			

			_tableView.getColumns().add(col);
			
			ObservableList<RowData> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValue(colName, false); });
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
						_tableView.getItems().get(m.getFocusedIndex()).setBooleanReverse(columnIndex);

//						String colName = getColumnName(columnIndex);
//						boolean bChecked = _tableView.getItems().get(m.getFocusedIndex()).getValueBoolean(colName);
//						_tableView.getItems().get(m.getFocusedIndex()).setValueBoolean(colName, ! bChecked);

						System.out.println("columnIndex:" + columnIndex + ",  event column:" + m.getFocusedCell().getColumn() 
								+ ", columnName:" + getColumnName(columnIndex) 
								+ ", value:" + _tableView.getItems().get(m.getFocusedIndex()).getValueBoolean(columnIndex));

						// 선택셀이 바뀌지 않은 상태에서 스페이스 누를 때 내부적인 값이 변하나, 디스플레이가 바뀌지 않는 문제  visiable 변경 또는 refresh 호출이 필요함 
						m.getFocusedCell().getTableColumn().setVisible(false);
						m.getFocusedCell().getTableColumn().setVisible(true);
						_tableView.refresh();
						event.consume();
					}
				}
				
			}
		});
	}

}
