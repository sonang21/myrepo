package bts.app.view;

import bts.app.DBObjectWork;
import bts.app.MainApp;
import bts.utils.fxext.RowData;
import bts.utils.fxext.TableViewManager;
//import javafx.beans.property.SimpleStringProperty;
//import javafx.beans.value.ObservableValue;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ContextMenu;
import javafx.scene.control.MenuItem;
//import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.Alert.AlertType;
//import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.input.KeyCode;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
//import javafx.util.Callback;

//import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import java.io.File;
//import java.io.IOException;
//import java.util.Iterator;
import java.util.ArrayList;

//@SuppressWarnings({"unchecked","rawtypes"})
public class ObjectList {
	private MainApp _mainApp;
	private ContextMenu _contextMenu;
	@FXML
	private TableView<RowData> _tvObjectList;
	
	private TableViewManager _viewManager;
	
	/**
     * 컨트롤러 클래스를 초기화한다.
     * fxml 파일이 로드되고 나서 자동으로 호출된다.
     */
	@FXML
	private void initialize() {
		_tvObjectList.setOnKeyPressed(event -> {
			if(event.getCode() == KeyCode.SPACE) {
				//_tvObjectList.getSelectionModel().getSelectedItem();
				chagneCheckStatus();
			}
			
			event.consume();
			
		});
	}
	
//	@SuppressWarnings("unused")
//	private static void printCellValue(Cell cell) {
//	    switch (cell.getCellTypeEnum()) {
//	        case BOOLEAN:
//	            System.out.print(cell.getBooleanCellValue());
//	            break;
//	        case STRING:
//	            System.out.print(cell.getRichStringCellValue().getString());
//	            break;
//	        case NUMERIC:
//	            if (DateUtil.isCellDateFormatted(cell)) {
//	                System.out.print(cell.getDateCellValue());
//	            } else {
//	                System.out.print(cell.getNumericCellValue());
//	            }
//	            break;
//	        case FORMULA:
//	            System.out.print(cell.getCellFormula());
//	            break;
//	        case BLANK:
//	            System.out.print("");
//	            break;
//	        default:
//	            System.out.print("");
//	    }
//
//	    System.out.print("\t");
//	}
	
	public void setMainApp(MainApp mainApp) { _mainApp = mainApp; }
	
	@FXML
	public void onButtonOpen() {
        FileChooser fileChooser = new FileChooser();

        // 확장자 필터를 설정한다.
        FileChooser.ExtensionFilter extFilter = new FileChooser.ExtensionFilter(
                "Excel files (*.xls;*.xlsx)", "*.xls;*.xlsx");
        fileChooser.getExtensionFilters().add(extFilter);
        fileChooser.setInitialDirectory(new File("C:\\Temp\\"));
        
        // File Dialog를 보여준다.
        File file = fileChooser.showOpenDialog(_mainApp.getPrimaryStage());

        if (file != null) {
        	System.out.println("File choosed: " + file.getName());
        	
        	try {
        		Workbook workbook = WorkbookFactory.create(file);
        		System.out.println("Workbook has " + workbook.getNumberOfSheets() + " Sheets!");
        		
//        		Iterator<Sheet> sheetIterlator = workbook.sheetIterator();
//        		while(sheetIterlator.hasNext()) {
//        			Sheet sheet = sheetIterlator.next();
//        			System.out.println(sheet.getSheetName());
//        		}
        		
        		for(Sheet sheet : workbook) {
        			System.out.println(sheet.getSheetName());
        		}
        		
//        		workbook.forEach( sheet -> 
//        			{
//        					System.out.println(sheet.getSheetName());
//        			}
//        		);
//        		
//        		System.out.println("\n\nIterating over Rows and Columns using for-each loop\n");
        		// Getting the Sheet at index zero
        		Sheet sheet = workbook.getSheetAt(0);
        		// Create a DataFormatter to format and get each cell's value as String
                DataFormatter dataFormatter = new DataFormatter();
                
//                ObservableList<ObservableList> rowList = FXCollections.observableArrayList();
                
        		_viewManager = new TableViewManager(_tvObjectList, true);
                
                //선택 컬럼 추가
//        		TableViewExt ext = new TableViewExt(_tvObjectList);
        		
//        		ext.addColumnCheckBoxEx("선택");
                
            	
                int iR=0; 
                String colName;
                int iC=0;
                ArrayList<String> cols = new ArrayList<>();
        		for (Row row: sheet) {
        			//첫줄에 대해서 컬럼 헤더 설정
        			if (iR==0) {
        				_viewManager.addColumnInteger("번호", "번호", false);
        				_viewManager.addColumnCheckBox("선택", "선택", true); // 체크박스 컬럼에 대해 명칭으로 관리
        				
	        			for(Cell cell: row) {
	        				colName = dataFormatter.formatCellValue(cell);
		                	_viewManager.addColumnString(colName, colName, false);
		                	cols.add(colName);
	        			}
	        			_viewManager.addColumnString("검사", "검사", false); // 부가적인 컬럼 설정
        			}
        			else {
        				RowData rowData = new RowData();
        				rowData.setValueInteger("번호", iR);
        				rowData.setValueBoolean("선택", false); iC++;
        				iC = 0;
	        			for(Cell cell: row) {
	                        String cellValue = dataFormatter.formatCellValue(cell);
	        				rowData.setValueString(cols.get(iC++), cellValue);
	        			}
	        			rowData.setValueString("검사", "-"); // 부가적인 컬럼에 초기값 설정
        				_viewManager.addRowData(rowData);
        			}
        			iR++;
                }
        		//_tvObjectList.setItems(rowList);
        		_viewManager.setTableViewItems();
        		_viewManager.getTableView().getSelectionModel().setCellSelectionEnabled(true);
        		
        		workbook.close();
        		
        	} catch (Exception ex) {
//        		String sStack = ex.getStackTrace()[1].getMethodName();
                Alert alert = new Alert(AlertType.ERROR);
                alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
                alert.setHeaderText("");
                alert.setContentText(ex.getMessage());
                alert.showAndWait();

        		ex.printStackTrace();
        		
        	}
        	
        	
        }

	}
	
	
	
	
    @FXML
    public void onClickObjectList(MouseEvent event)
    {
//        if (event.getClickCount() == 2) //Checking double click
    	// Get the height of the header.
//    	System.out.println("Event Source : " + event.getSource());
//    	System.out.println("Event Target : " + event.getTarget());
    	if(event.getButton() == MouseButton.PRIMARY) {
//			System.out.println(event.getTarget().getClass().getSimpleName());
    		if(event.getTarget().getClass().getSimpleName().equalsIgnoreCase("CheckBoxTableCell") ) {
    			//event.getTarget().getClass().getSimpleName().equalsIgnoreCase("TableColumnHeader")
    			//System.out.println(event.getTarget().getClass().getSimpleName());
    			chagneCheckStatus();
        	} else if(event.getClickCount() == 2) {
        		showObjectText();
        	} else {
        		if (_contextMenu != null && _contextMenu.isShowing()) {
        			_contextMenu.hide();
        		}
        	}
        	
    	} else if(event.getButton() == MouseButton.SECONDARY) {
    		showContextMenu(event);
    	}
    	

//        double headerHeight = _objectList.lookup(".column-header-background").getBoundsInLocal().getHeight();
//
//        // Check if the clicked position's Y value is less than or equal to the height of the header.
//        if (headerHeight <= event.getY()) {
//        	//Clicked on the header!
//        	return;
//        }
        
    }

    private void showObjectText() {
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
		String sOwner;
		
		String sDB = rowData.getValueString("소분류");
		String sObjectName = rowData.getValueString("프로그램ID").toUpperCase();
		String sObjectType = rowData.getValueString("중분류").toUpperCase();

		if (sDB.equalsIgnoreCase("ORACLE")) {
			sOwner = "DBENURI";
			//DBObjectWork dbo = new DBObjectWork(DBMS_TYPE.ORACLE, "jdbc:oracle:thin:@//xxx.xxx.xxx.xxx:prot/dbname", "user","pass");
			DBObjectWork dbo = new DBObjectWork("ENURI_TEST");
			String strText = dbo.getOracleText(sOwner, sObjectName, sObjectType);
			dbo.closeAll();
			_mainApp.showViewSourceDialog(strText);
		}
		else if(sDB.equalsIgnoreCase("MS-SQL")) {
			sOwner = "ELOC2001";
			//DBObjectWork dbo = new DBObjectWork(DBMS_TYPE.MSSQL, "jdbc:sqlserver://x.x.x.x:port;instanceName=xx;databaseName=xx;", "user","pass");
			DBObjectWork dbo = new DBObjectWork("MPDB_TEST");
			String strText = dbo.getMSSQLText("ELOC2001", "dbo", sObjectName, sObjectType);
			dbo.closeAll();
			_mainApp.showViewSourceDialog(strText);
		}
    }

    private void showObjectTextEx() {
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
    	if(rowData == null) return;
		String sOwner;
		
		String sDB = rowData.getValueString("소분류");
		String sObjectName = rowData.getValueString("프로그램ID").toUpperCase();
		String sObjectType = rowData.getValueString("중분류").toUpperCase();
		
		if (sDB.equalsIgnoreCase("ORACLE")) {
			sOwner = "DBENURI";
			//DBObjectWork dbo = new DBObjectWork(DBMS_TYPE.ORACLE, "jdbc:oracle:thin:@//xxx.xxx.xxx.xxx:prot/dbname", "user","pass");
			DBObjectWork dbo = new DBObjectWork("ENURI_TEST");
			String strText = dbo.getOracleText(sOwner, sObjectName, sObjectType);
			dbo.closeAll();
			_mainApp.showViewSourceExDialog(strText);
		}
		else if(sDB.equalsIgnoreCase("MS-SQL")) {
			sOwner = "ELOC2001";
			//DBObjectWork dbo = new DBObjectWork(DBMS_TYPE.MSSQL, "jdbc:sqlserver://x.x.x.x:port;instanceName=xx;databaseName=xx;", "user","pass");
			DBObjectWork dbo = new DBObjectWork("MPDB_TEST");
			String strText = dbo.getMSSQLText("ELOC2001", "dbo", sObjectName, sObjectType);
			dbo.closeAll();
			_mainApp.showViewSourceExDialog(strText);
		}
    }
    private void chagneCheckStatus() {
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
//    	System.out.println("begin..." + rowData.getValueBoolean(0));
    	rowData.setBooleanReverse(_viewManager.getColumnIndex("선택"));
//    	System.out.println("end  ..." + rowData.getValueBoolean(0));
    	//RowData.set(0, String.valueOf(!Boolean.valueOf(rowData.get(0))));
     	_tvObjectList.refresh();
     	
     	
    }
    
    private void checkListAll() {
    	ObservableList<RowData> olist = (ObservableList<RowData>)_tvObjectList.getItems();
    	int index = _viewManager.getColumnIndex("선택");
    	olist.forEach(row -> row.setValueBoolean(index, true));
    	_tvObjectList.refresh();
    	
    }

    private void unCheckListAll() {
    	ObservableList<RowData> olist = (ObservableList<RowData>)_tvObjectList.getItems();
    	int index = _viewManager.getColumnIndex("선택");
    	olist.forEach(row -> row.setValueBoolean(index, false));
    	_tvObjectList.refresh();
    }
	
	@FXML
	public void onButtonClose() {
		_mainApp.getPrimaryStage().close();
		System.exit(0);
	}
	
	private void showContextMenu(MouseEvent event) {
		if (_contextMenu == null) {
			_contextMenu = new ContextMenu();
			MenuItem menuItem1 = new MenuItem("View Source");
			MenuItem menuItem2 = new MenuItem("Check All");
			MenuItem menuItem3 = new MenuItem("UnCheck All");
			menuItem1.setOnAction(
				new EventHandler<ActionEvent>() {
					@Override
					public void handle(ActionEvent event ) {
						showObjectTextEx();
					}
				}
			);
			
			menuItem2.setOnAction(
				new EventHandler<ActionEvent>() {
					@Override
					public void handle(ActionEvent event) {
//						System.out.println("Right Click Evnet... Check All");
						checkListAll();
					}
				}
			);
			menuItem3.setOnAction(
	    			new EventHandler<ActionEvent>() {
	    				@Override
	    				public void handle(ActionEvent event) {
//	    					System.out.println("Right Click Evnet... UnCheck All");
	    					unCheckListAll();
	    				}
	    			}
	    		);
	    	_contextMenu.getItems().addAll(menuItem1, menuItem2, menuItem3);
	    	_contextMenu.setConsumeAutoHidingEvents(true);
		} 
		_contextMenu.show(_tvObjectList, event.getScreenX(), event.getScreenY());
		
	}
}
