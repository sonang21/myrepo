package sq.view;

import sq.MainApp;
import sq.model.DBObject;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.MenuItem;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.cell.CheckBoxTableCell;
import javafx.scene.control.skin.TableColumnHeader;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import javafx.util.Callback;

//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

@SuppressWarnings({"unchecked","rawtypes", "unused"})
public class SimpleQuery {
	private MainApp _mainApp;
	
	@FXML
	private TextArea _textSql;
	@FXML
	private TableView<DBObject> _objectList;
	@FXML
	private TableColumn<DBObject, String> _ownerColumn;
	@FXML
	private TableColumn<DBObject, String> _nameColumn;
	@FXML
	private TableColumn<DBObject, String> _typeColumn;
	@FXML
	private TableColumn<DBObject, Boolean> _checkColumn;
	@FXML
	private TableView _queryResult;
	@FXML
	private SplitPane _splitPane1;
		
	private ObservableList<DBObject> _objData =  FXCollections.observableArrayList();
	private ObservableList<ObservableList> _dataQueryResult;
	private Connection _dbConn;
    
	/**
     * 컨트롤러 클래스를 초기화한다.
     * fxml 파일이 로드되고 나서 자동으로 호출된다.
     */
	@FXML
	private void initialize() {
		_ownerColumn.setCellValueFactory(cellData -> cellData.getValue().ownerProperty());
		_nameColumn.setCellValueFactory(cellData -> cellData.getValue().nameProperty());
		_typeColumn.setCellValueFactory(cellData -> cellData.getValue().typeProperty());
		_checkColumn.setCellValueFactory(cellData -> cellData.getValue().checkedProperty());
		_checkColumn.setCellFactory(cell -> new CheckBoxTableCell<>());
		
        dbConnection();
        getObjectList();

		// 선택을 감지하고 그 때마다 연락처의 자세한 정보를 보여줌
//		_objectList.getSelectionModel().selectedItemProperty().addListener(
//					(observable, oldValue, newValue) -> showObjectDDL(newValue));
		
		System.out.println("SimpleQuery initialize()....");
	}
	
	/**
     * 참조를 다시 유지하기 위해 메인 애플리케이션이 호출한다.
     *
     * @param mainApp
     */
    public void setMainApp(MainApp mainApp) {
        this._mainApp = mainApp;
		System.out.println("SimpleQuery setMainApp()....");
        
    }

    public void setSplitPosition(double pos) {
    	_splitPane1.setDividerPositions(pos);
    }
    
    @FXML
    public void onClickObjectList(MouseEvent event)
    {
//        if (event.getClickCount() == 2) //Checking double click
    	// Get the height of the header.
    	System.out.println("Event Source : " + event.getSource());
    	System.out.println("Event Target : " + event.getTarget());
    	if(event.getButton() == MouseButton.SECONDARY) {
    		ContextMenu contextMenu = new ContextMenu();
    		MenuItem menuItem1 = new MenuItem("Check All");
    		MenuItem menuItem2 = new MenuItem("UnCheck All");
    		menuItem1.setOnAction(
    			new EventHandler<ActionEvent>() {
    				@Override
    				public void handle(ActionEvent event) {
    					System.out.println("Right Click Evnet... Check All");
    					checkAllObjects();
    				}
    			}
    		);
    		menuItem2.setOnAction(
        			new EventHandler<ActionEvent>() {
        				@Override
        				public void handle(ActionEvent event) {
        					System.out.println("Right Click Evnet... UnCheck All");
        					unCheckAllObjects();
        				}
        			}
        		);
        	contextMenu.getItems().addAll(menuItem1, menuItem2);
    		contextMenu.show(_objectList, event.getScreenX(), event.getScreenY());
    	}
    	else if(! event.getTarget().getClass().getSimpleName().equalsIgnoreCase("TableColumnHeader")) {
        	DBObject dbobj = _objectList.getSelectionModel().getSelectedItem();
            System.out.println(dbobj.getName() + "... onClickObjectList()");
            dbobj.setChecked(!dbobj.getChecked());
            showObjectDDL(dbobj);
    	}

//        double headerHeight = _objectList.lookup(".column-header-background").getBoundsInLocal().getHeight();
//
//        // Check if the clicked position's Y value is less than or equal to the height of the header.
//        if (headerHeight <= event.getY()) {
//        	//Clicked on the header!
//        	return;
//        }
        
    }
    
    private void checkAllObjects() {
    	for(DBObject dbo : _objectList.getItems()) {
    		if(!dbo.getChecked()) dbo.setChecked(true);
    	}
    }
    private void unCheckAllObjects() {
    	for(DBObject dbo : _objectList.getItems()) {
    		if(dbo.getChecked()) dbo.setChecked(false);
    	}
    }
    
	private void showObjectDDL(DBObject obj) {
//		_textSql.setText(obj.getName());
		System.out.println(obj.getName() + " ... showObjecteDDL()");
		try {
			CallableStatement cStmt = _dbConn.prepareCall(
			    "{call dbms_metadata.SET_REMAP_PARAM(dbms_metadata.SESSION_TRANSFORM, 'REMAP_SCHEMA', ?,?)}"
			);
			
//			stmt.execute("exec dbms_metadata.SET_REMAP_PARAM(dbms_metadata.SESSION_TRANSFORM, 'REMAP_SCHEMA', 'DBENURI','ASISTEST')");
			cStmt.setString(1, "DBENURI");
			cStmt.setString(2, "ASISTEST");
			cStmt.execute();
//			cStmt.execute("{call dbms_metadata.SET_TRANSFORM_PARAM(dbms_metadata.SESSION_TRANSFORM, 'PRETTY', false)}");
			cStmt.execute("BEGIN dbms_metadata.SET_TRANSFORM_PARAM(dbms_metadata.SESSION_TRANSFORM, 'PRETTY', false); END;");
//			cStmt.close();
			String SQL = String.format("SELECT dbms_metadata.get_ddl(object_type=>'%s',name=>'%s',schema=>'%s') from dual"
					                  , obj.getType(), obj.getName(), obj.getOnwer()
					                  );
			
//			ResultSet rs = _dbConn.createStatement().executeQuery(SQL);
			ResultSet rs = cStmt.executeQuery(SQL);
            /********************************
             * Data added to ObservableList *
             ********************************/
            while(rs.next()){
            	_textSql.setText(rs.getString(1));
            }
          
            rs.close();
//            stmt.close();
            cStmt.close();
        } catch(Exception e){
            e.printStackTrace();
            System.out.println("Error on showObjectDDL{}");             
        }
		
		
	}
    
    
	/**
     * Execute 버튼 클릭시 호출
     * 
     */
    @FXML
    public void onButtonExecute() {
    	//System.out.println(_textSql.getText());
    	
//        Alert alert = new Alert(AlertType.INFORMATION);
//        alert.initOwner(_mainApp.getPrimaryStage());
//        alert.setTitle("Info");
//        alert.setHeaderText("Header Text here");
//        alert.setContentText(String.format("%s\n%s", "button Clicked!!!", _textSql.getText()));
//        
//        alert.showAndWait();
        ///////////////////////////////////////////
        //dbTest();
    	getObjectList();
    }
    
    private void dbConnection() {
//      String sConn = "jdbc:oracle:thin:@10.10.110.19:1521:ORATEST";
        String sConn = "jdbc:oracle:thin:@100.100.100.194:1521:TENURI";
        try {
	    	Class.forName("oracle.jdbc.driver.OracleDriver");
	//    	_dbConn = DriverManager.getConnection(sConn, "da", "da");
	    	_dbConn = DriverManager.getConnection(sConn, "dbadm", "dba1020");
        }
        catch (Exception ex) {
        	System.out.println("Error on dbConnection()");
        	ex.printStackTrace();
        }
    }
    
    private void getObjectList() {
    	_objData.clear();
    	try {
			String SQL = "SELECT OWNER, OBJECT_NAME, OBJECT_TYPE  from DBA_OBJECTS WHERE OWNER = 'DBENURI' AND OBJECT_TYPE='PROCEDURE' ORDER BY 1,2";
			
			ResultSet rs = _dbConn.createStatement().executeQuery(SQL);
            /********************************
             * Data added to ObservableList *
             ********************************/
            while(rs.next()){
            	_objData.add(new DBObject(rs.getString(1), rs.getString(2), rs.getString(3), false));
            }
          
            rs.close();

            //FINALLY ADDED TO TableView
            //_objectList.getColumns().clear();
            _objectList.setItems(_objData);

        } catch(Exception e){
            e.printStackTrace();
            System.out.println("Error on Building Data");             
        }
    }

    @SuppressWarnings("all")
    private void dbTest() {
        _dataQueryResult = FXCollections.observableArrayList();
        try {
        	System.out.println("..........ok");
			
//			String SQL = "SELECT *  from user_tables";
			String SQL =  _textSql.getText();
			
			ResultSet rs = _dbConn.createStatement().executeQuery(SQL);

	        /**********************************
	         * TABLE COLUMN ADDED DYNAMICALLY *
	         **********************************/
			_queryResult.getColumns().clear();
			for(int i=0 ; i < rs.getMetaData().getColumnCount(); i++){
				//We are using non property style for making dynamic table
				final int j = i;                
				TableColumn col = new TableColumn(rs.getMetaData().getColumnName(i+1));
				col.setCellValueFactory(
						new Callback<CellDataFeatures<ObservableList,String>,ObservableValue<String>>(){                    
							public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {                                                                                              
								return new SimpleStringProperty(param.getValue().get(j).toString());                        
							}                    
						}
				);

				_queryResult.getColumns().addAll(col); 
				System.out.println("Column ["+i+"] ");
			}

			/********************************
			 * Data added to ObservableList *
			 ********************************/
			while(rs.next()){
				//Iterate Row
				ObservableList<String> row = FXCollections.observableArrayList();
				for(int i=1 ; i<=rs.getMetaData().getColumnCount(); i++){
					//Iterate Column
					if (rs.getString(i)==null) {
						row.add("");
					} else {
						row.add(rs.getString(i));
					}
				}
				System.out.println("Row [1] added "+row );
				_dataQueryResult.add(row);

			}
          
			rs.close();

			//FINALLY ADDED TO TableView
			_queryResult.setItems(_dataQueryResult);
        } catch(Exception e) {
            e.printStackTrace();
            System.out.println("Error on Building Data");             
        }
    }

}
