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
	private TableView<TableRow> _tableView;
	private ArrayList<TableColumnMeta> _columnsMeta = new ArrayList<TableColumnMeta>();

	private ObservableList<TableRow> _rows;
	
	public TableViewManager(TableView<TableRow> tableView) {
		setTableView(tableView, false);
	}

	public TableViewManager(TableView<TableRow> tableView, boolean clearColumn) {
		setTableView(tableView, clearColumn);
	}
	
	public TableView<TableRow> getTableView() {
		return _tableView;
	}
	
	public void setTableView(TableView<TableRow> tableView, boolean clearColumn) {
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
		//if(_columnsMeta.contains(colName))
		for(TableColumnMeta m : _columnsMeta)
		{
			if(m.columnName.equalsIgnoreCase(colName)) {
				//throw new Exception("addColumnString(): [" + colName + "] is already exists.");
				System.err.println("addColumnString(): [" + colName + "] is already exists.");
				return false;
			}
		}		
		_columnsMeta.add(new TableColumnMeta(_columnsMeta.size(), colName, header, type, editable));
		return true;
	}

	private int getColumnIndex(String colName) {
		for(TableColumnMeta m : _columnsMeta) {
			if(m.columnName.equalsIgnoreCase(colName)) {
				return m.columnIndex;
			}
		}
		return -1;
	}
	
	private String getColumnName(int columnIndex) {
		if(columnIndex < _columnsMeta.size()) {
			return _columnsMeta.get(columnIndex).columnName;
		} else {
			return null;
		}
	}
	
	
	public ArrayList<TableColumnMeta> getColumnsMeta() {
		return _columnsMeta;
	}
	


	public void addColumnString(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, "String", isEditable)) {
			TableColumn<TableRow, String> col = new TableColumn<TableRow, String>(header);
			col.setCellValueFactory(cellData -> cellData.getValue().getStringProperty(colName));
			if (isEditable) {
				col.setCellFactory(cellDataFeatures -> new StringTableCell(colName));
				col.setOnEditCommit((CellEditEvent<TableRow, String> event) -> {
					event.getRowValue().setValue(colName, event.getNewValue());
				});
				
			}
			ObservableList<TableRow> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValueString(colName, ""); });
			
			_tableView.getColumns().add(col);		
		}
	}
	
	
	public void addColumnCheckBox(String colName, String header, boolean isEditable) {
		if(addColumnList(colName, header, "Boolean", isEditable)) {
			TableColumn<TableRow, Boolean> col = new TableColumn<TableRow, Boolean>(header);
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
					CheckBoxTableCell<TableRow, Boolean> cell = new CheckBoxTableCell<>();
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
			
			ObservableList<TableRow> rows = _tableView.getItems();
			rows.forEach(row -> { row.setValue(colName, false); });
		}
	}

	public void setCellValue(int nRow, String colName, Object oValue) {
		_tableView.getItems().get(nRow).setValue(colName, oValue);
	}
	
	public int columnCount() {
		if(_tableView != null) {
			return _tableView.getColumns().size();
		}
		else {
			return -1;
		}
	}
	
	public int rowCount() {
		if(_tableView != null) {
			return _tableView.getItems().size();
		}
		else {
			return -1;
		}
	}
	
	
	public void addRowStrings(String...sargs) {
		if (_rows == null) _rows = FXCollections.observableArrayList();
		
		TableRow row = new TableRow();
		for(int i=0; i < sargs.length; i++) {
			row.setValue(_columnsMeta.get(i).columnName, sargs[i]);
		}
		_rows.add(row);
	}

	public void addRowObjects(Object...oargs) {
		if (_rows == null) _rows = FXCollections.observableArrayList();

		TableRow row = new TableRow();
		for(int i=0; i < oargs.length; i++) {
			row.setValue(_columnsMeta.get(i).columnName, oargs[i]);
		}
		_rows.add(row);
	}
	
	public ObservableList<TableRow> getTableRows() {
		return _rows;
	}
	
	public void setTableViewItems(ObservableList<TableRow> rows) {
		_tableView.setItems(rows);
	}
	
	public void setCheckBoxColumnEvent(int columnIndex) {
		_tableView.addEventFilter(KeyEvent.KEY_PRESSED,  new EventHandler<KeyEvent>() {
			@Override
			public void handle(KeyEvent event) {
				// TODO Auto-generated method stub
				if(event.getCode() == KeyCode.SPACE) {
					TableViewFocusModel<TableRow> m = _tableView.getFocusModel();
					if (m != null && m.getFocusedCell().getColumn() == columnIndex) {
						_tableView.getItems().get(m.getFocusedIndex()).setBooleanReverse(getColumnName(columnIndex));
//						String colName = getColumnName(columnIndex);
//						boolean bChecked = _tableView.getItems().get(m.getFocusedIndex()).getValueBoolean(colName);
//						_tableView.getItems().get(m.getFocusedIndex()).setValueBoolean(colName, ! bChecked);
						

//						System.out.println("ix:" + columnIndex + ", " + m.getFocusedCell().getColumn());
//						System.out.print("text:" + m.getFocusedCell().getTableColumn().getText());
//						System.out.print(", cellvalue :" + m.getFocusedCell().getTableColumn().getCellData(m.getFocusedIndex()));
//						System.out.println(", itemValue:" + _tableView.getItems().get(m.getFocusedIndex()).getValueBoolean(getColumnName(columnIndex)));
//						System.out.println("factory value:" + m.getFocusedCell().getTableColumn().toString());
						m.getFocusedCell().getTableColumn().setVisible(false);
						m.getFocusedCell().getTableColumn().setVisible(true);
//						_tableView.refresh();
					}
				}
				
			}
		});
	}

}
