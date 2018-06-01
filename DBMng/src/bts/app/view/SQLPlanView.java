package bts.app.view;

import bts.app.MainApp;
import bts.app.model.SqlPlan;
//import javafx.collections.FXCollections;
//import javafx.collections.ObservableList;
import javafx.fxml.FXML;
//import javafx.scene.control.TableView;
import javafx.scene.control.TreeItem;
import javafx.scene.control.TreeTableColumn;
import javafx.scene.control.TreeTableView;
import javafx.scene.control.cell.TreeItemPropertyValueFactory;
//import javafx.scene.input.KeyCode;

public class SQLPlanView {
	private MainApp _mainApp;
	@FXML
	private TreeTableView<SqlPlan> _ttvPlan;
	
	
	@FXML
	public void handleOpen() {
		_mainApp.getPrimaryStage().close();
		System.exit(0);	
	}
	
	public void setMainApp(MainApp mainApp) {
		_mainApp = mainApp;
	}
	
	@SuppressWarnings("unchecked")
	public void setTreeView() {
		_ttvPlan.getColumns().clear();
		TreeTableColumn<SqlPlan, String>  cOperation = new TreeTableColumn<SqlPlan, String>("OperationX");
		TreeTableColumn<SqlPlan, Integer> cId = new TreeTableColumn<SqlPlan, Integer>("IDx");

		cOperation.setCellValueFactory(new TreeItemPropertyValueFactory<SqlPlan, String>("Operation"));
		cId.setCellValueFactory(new TreeItemPropertyValueFactory<SqlPlan, Integer>("Id"));

		_ttvPlan.getColumns().addAll(cOperation, cId);

		
		SqlPlan plan1 = new SqlPlan(1,0, "(0)_ - root");
		SqlPlan plan2 = new SqlPlan(2,1, "(2)- sub1");
		SqlPlan plan3 = new SqlPlan(3,1, "(3)- sub2");
		SqlPlan plan21 = new SqlPlan(21,2, "(21) - sub21");
		SqlPlan plan31 = new SqlPlan(31,3, "(31) - sub31");
		
		
		TreeItem<SqlPlan> itemRoot = new TreeItem<SqlPlan>(plan1);
		TreeItem<SqlPlan> itemSub1 = new TreeItem<SqlPlan>(plan2);
		TreeItem<SqlPlan> itemSub2 = new TreeItem<SqlPlan>(plan3);
		TreeItem<SqlPlan> itemSub21 = new TreeItem<SqlPlan>(plan21);
		TreeItem<SqlPlan> itemSub31 = new TreeItem<SqlPlan>(plan31);
		itemSub1.getChildren().addAll(itemSub21);
		itemSub2.getChildren().addAll(itemSub31);
		itemRoot.getChildren().addAll(itemSub1, itemSub2);
		
		_ttvPlan.setRoot(itemRoot);
//		_ttvPlan.setShowRoot(false);
		

	}
	/**
     * 컨트롤러 클래스를 초기화한다.
     * fxml 파일이 로드되고 나서 자동으로 호출된다.
     */
	@FXML
	private void initialize() {
		setTreeView();
	}
}
