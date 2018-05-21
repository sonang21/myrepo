package bts.utils.fxext;

import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleStringProperty;
//import javafx.beans.value.ObservableValue;
//import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.cell.CheckBoxTableCell;
//import javafx.util.Callback;

public class TableViewExt<S> extends TableView<S> {
	
	TableView<S> _tableView; // = FXCollections.observableArrayList();
	
	public TableViewExt(TableView<S> tv) {
		_tableView = tv;
	}
	
	public int columnCountEx() {
		return _tableView.getColumns().size();
	}
	
	public int lastColumnIndex() {
		return _tableView.getColumns().size() -1 ;
	}
	
	public int rowCountEx() {
		return _tableView.getItems().size();
	}
	
	@SuppressWarnings({"unchecked","rawtypes"})
	public void addColumnEx(String sColumnName) {
		TableColumn col = new TableColumn(sColumnName);
		final int nLastCol = this.columnCountEx();
//		col.setCellValueFactory(
//				new Callback<CellDataFeatures<ObservableList,String>,ObservableValue<String>>() {
//					public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {
//						return new SimpleStringProperty(param.getValue().get(nLastCol).toString());
//					}
//				}
//		);
		col.setCellValueFactory( 
				cellData -> new SimpleStringProperty(
				  ((CellDataFeatures<ObservableList, String>)cellData).getValue().get(nLastCol).toString()
				)
		);
		
		_tableView.getColumns().addAll(col);
		ObservableList<ObservableList> rows = (ObservableList<ObservableList>)_tableView.getItems();
		rows.forEach(row -> { row.add(""); });		
	}
	
	@SuppressWarnings({"unchecked","rawtypes"})
	public void addColumnCheckBoxEx(String sColumnName) {
		TableColumn col = new TableColumn(sColumnName);
		final int nLastCol = this.columnCountEx();
//		col.setCellValueFactory(
//				new Callback<CellDataFeatures<ObservableList,String>,ObservableValue<String>>() {
//					public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {
//						return new SimpleStringProperty(param.getValue().get(nLastCol).toString());
//					}
//				}
//		);
		col.setCellValueFactory( 
				cellData -> new SimpleBooleanProperty(
					Boolean.valueOf(((CellDataFeatures<ObservableList, Boolean>)cellData).getValue().get(nLastCol).toString())
				)
		);
		
		col.setCellFactory(cell -> new CheckBoxTableCell<>()
		);
		
		_tableView.getColumns().addAll(col);
		
		ObservableList<ObservableList> rows = (ObservableList<ObservableList>)_tableView.getItems();
		rows.forEach(row -> { row.add(""); });
	}

	@SuppressWarnings({"unchecked","rawtypes"})
	public void setCellEx(int nRow, int nCol, String sValue) {
		ObservableList<ObservableList> olist = (ObservableList<ObservableList>)_tableView.getItems();
		olist.get(nRow).set(nCol, sValue);
	}
	
	public void addListener() {
//		/**
//		 * select change event listener
//		 */
//		_tableView.getSelectionModel().selectedItemProperty().addListener(
//			(observable, oldValue, newValue) -> {
////				((ObservableList)newValue).forEach(System.out::println );
//				((ObservableList)newValue).stream().limit(3).forEach(s->System.out.print(s.toString() + ", "));
//				System.out.println();
//			}
//		);
	}
		
}
