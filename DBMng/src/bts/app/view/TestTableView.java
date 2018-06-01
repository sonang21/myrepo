package bts.app.view;

import java.util.ArrayList;

import bts.app.MainApp;

import bts.utils.fxext.StringTableCell;
import bts.utils.fxext.TableRow;
import bts.utils.fxext.TableViewManager;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
//import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView;
//import javafx.scene.control.cell.PropertyValueFactory;
//import javafx.scene.control.cell.TextFieldTableCell;
//import javafx.stage.Stage;

public class TestTableView {
//	private Stage _stage;
	private MainApp _mainApp;
	
	@FXML
	private TableView<TableRow> _tableView;
	
	public void showTable() {
		TableViewManager tvMgr = new TableViewManager(_tableView, true);
		tvMgr.addColumnString("name", "Name", true);
		tvMgr.addColumnString("value", "Value", false);
		tvMgr.addColumnString("test", "Test", false);
		tvMgr.addColumnCheckBox("chk", "Select", true);
		
		
		tvMgr.addRowStrings("abc", "val a", "test A");
		tvMgr.addRowStrings("bde", "val b", "test B");
		tvMgr.addRowStrings("cfg", "val c", "test C");
		tvMgr.addRowObjects("obk", "val o", "test O", true);

		tvMgr.setTableViewItems(tvMgr.getTableRows());
		_tableView.setEditable(true);
		_tableView.getSelectionModel().selectFirst();
		_tableView.getSelectionModel().setCellSelectionEnabled(true);
	}

	public void showTable3() {
		TableColumn<TableRow, String> colName = new TableColumn<TableRow, String>("Name");
		TableColumn<TableRow, String> colValue = new TableColumn<TableRow, String>("Value");
		TableColumn<TableRow, String> colTest = new TableColumn<TableRow, String>("Test");
		
		colName = new TableColumn<TableRow, String>("Name");
		colValue = new TableColumn<TableRow, String>("Value");
		colTest = new TableColumn<TableRow, String>("Test");
		
		colName.setCellValueFactory(cellData -> cellData.getValue().getStringProperty("0"));
		colName.setCellFactory(cellDataFeatures -> new StringTableCell("0"));
		
//		colName.setOnEditCommit((EventHandler<CellEditEvent<TableRow, String>>) t -> {
//			((TableRow)(t.getTableView().getItems().get(t.getTablePosition().getRow()))).setValue("0", t.getNewValue());
//		}
//		);
		
		colValue.setCellValueFactory(cellData -> cellData.getValue().getStringProperty("1"));
		colTest.setCellValueFactory(cellData -> cellData.getValue().getStringProperty("2"));
		
		
		ObservableList<TableRow> list = FXCollections.observableArrayList();
		TableRow d1 = new TableRow("a", "val a", "test A");
		TableRow d2 = new TableRow("b", "val b", "test B");
		TableRow d3 = new TableRow("c", "val c", "test C");
		
		list.addAll(d1, d2, d3);
		_tableView.getColumns().clear();
		_tableView.setEditable(true);
		_tableView.getColumns().addAll(colName, colValue, colTest);
		_tableView.setItems(list);
		_tableView.getSelectionModel().selectFirst();
		_tableView.getSelectionModel().setCellSelectionEnabled(true);
	}

	public void showTable2() {
		ArrayList<TableColumn<TableRow, String>> cols = new ArrayList<TableColumn<TableRow, String>>();
		
		cols.add(new TableColumn<TableRow, String>("Name"));
		cols.add(new TableColumn<TableRow, String>("Value"));
		cols.add(new TableColumn<TableRow, String>("Test"));
		
		cols.get(0).setCellValueFactory(cellData -> cellData.getValue().getStringProperty("0"));
		cols.get(0).setCellFactory(cellDataFeatures -> new StringTableCell("0"));
		cols.get(0).setOnEditCommit( (CellEditEvent<TableRow, String> event) -> {
			event.getRowValue().setValue("0", event.getNewValue());
		});
		
		cols.get(1).setCellValueFactory(cellData -> cellData.getValue().getStringProperty("1"));
		cols.get(2).setCellValueFactory(cellData -> cellData.getValue().getStringProperty("2"));
		
		
		ObservableList<TableRow> list = FXCollections.observableArrayList();
		TableRow d1 = new TableRow("a", "val a", "test A");
		TableRow d2 = new TableRow("b", "val b", "test B");
		TableRow d3 = new TableRow("c", "val c", "test C");
		
		list.addAll(d1, d2, d3);
		_tableView.getColumns().clear();
		_tableView.setEditable(true);
		_tableView.getColumns().addAll(cols);
		_tableView.setItems(list);
		_tableView.getSelectionModel().selectFirst();
		_tableView.getSelectionModel().setCellSelectionEnabled(true);
	}

	public void setMainApp(MainApp mainApp) {
		_mainApp = mainApp;
	}
	
	/**
	 * controller class �ʱ�ȭ
	 * fxml ������ �ε�� �� �ڵ����� ȣ���
	 */
	@FXML
	private void initialize() {
		showTable();
	}
	
	@FXML
	public void handleClose() {
		_mainApp.getPrimaryStage().close();
	}

}
