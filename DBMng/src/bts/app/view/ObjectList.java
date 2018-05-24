package bts.app.view;

import bts.app.DBObjectWork;
import bts.app.MainApp;
import bts.utils.db.DBConnection.DBMS_TYPE;
import bts.utils.fxext.TableViewExt;
//import javafx.beans.property.SimpleStringProperty;
//import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
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

@SuppressWarnings({"unchecked","rawtypes"})
public class ObjectList {
	private MainApp _mainApp;
	@FXML
	private TableView<ObservableList> _tvObjectList;
	
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
                
                ObservableList<ObservableList> rowList = FXCollections.observableArrayList();
                
                _tvObjectList.getColumns().clear();
                
                //선택 컬럼 추가
        		TableViewExt ext = new TableViewExt(_tvObjectList);
        		ext.addColumnCheckBoxEx("선택");
                
            	
                int iR=0; 
//                int iC=1;
        		for (Row row: sheet) {
        			//첫줄에 대해서 컬럼 헤더 설정
        			if (iR==0) {
	        			for(Cell cell: row) {
		                	ext.addColumnEx(dataFormatter.formatCellValue(cell));
//		                	final int j = iC;
//		                	System.out.println(String.valueOf(j));
//		                	iC++;
//		                	TableColumn col = new TableColumn(dataFormatter.formatCellValue(cell));
//		                	col.setCellValueFactory(
//		                			new Callback<CellDataFeatures<ObservableList,String>,ObservableValue<String>>() {                    
//		    							public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {                                                                                              
//		    								return new SimpleStringProperty(param.getValue().get(j).toString());                        
//		    							}                    
//		    						}
//		                	);
//		                	_tvObjectList.getColumns().addAll(col);
	        			}
	        			ext.addColumnEx("검사"); // 부가적인 컬럼 설정
        			}
        			else {
        				ObservableList<String> rowData = FXCollections.observableArrayList();
        				rowData.add("false"); // 첫 컬럼값은 선택 false로 설정
	        			for(Cell cell: row) {
	                        String cellValue = dataFormatter.formatCellValue(cell);
	        				rowData.add(cellValue);
	        			}
	        			rowData.add("-"); // 부가적인 컬럼에 초기값 설정
        				rowList.add(rowData);
        			}
        			iR++;
                }
        		_tvObjectList.setItems(rowList);
        		workbook.close();
//        		ext.addListener();
//        		ext.setCellEx(1, ext.columnCountEx()-1, "XXX");

        		//        		ext.addColumnEx("점검1");
//        		ext.setCellEx(1, ext.columnCountEx()-1, "XXX");
        		
//        		//데이터 셋 추가후 추가적인 컬럼 구성 테스트
//        		TableColumn col = new TableColumn("테스트");
//        		final int j = _tvObjectList.getColumns().size();
//            	col.setCellValueFactory(
//            			new Callback<CellDataFeatures<ObservableList,String>,ObservableValue<String>>() {                    
//							public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {                                                                                              
//								return new SimpleStringProperty(param.getValue().get(j).toString());                        
//							}                    
//						}
//            	);
//    			_tvObjectList.getColumns().addAll(col);
        		
//        		ObservableList<ObservableList> listAll = (ObservableList<ObservableList>)_tvObjectList.getItems();
////        		System.out.println(String.format("Size of listStr : %d",  listStr.size()));
////        		((ObservableList<String>)_tvObjectList.getItems().get(0)).set(11, "OK");
////        		listStr.set(listStr.size() -1, "OK");
//        		listAll.forEach(row -> {
//        			row.set(row.size()-1, "OKKK");
//        			row.add(new String(""));
//        			row.set(j, "XX");
//        		});
//        		
//        		//ObservableList<String> listStr = listAll.get(1);
//        		listAll.get(2).set(j, "Yahoo");
//        		TableViewExt ext = new TableViewExt(_tvObjectList);
//        		ext.addColumnEx("이런");
//        		ext.setCellEx(1, 1, "저런");
        		
        		
        		
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
    		if(event.getTarget().getClass().getSimpleName().equalsIgnoreCase("CheckBoxTableCell") ) {
    			//event.getTarget().getClass().getSimpleName().equalsIgnoreCase("TableColumnHeader")
    			//System.out.println(event.getTarget().getClass().getSimpleName());
    			chagneCheckStatus();
        	} else if(event.getClickCount() == 2) {
        		showObjectText();
        	}
        	
    	} else if(event.getButton() == MouseButton.SECONDARY) {
    		ContextMenu contextMenu = new ContextMenu();
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
//    					System.out.println("Right Click Evnet... Check All");
    					checkListAll();
    				}
    			}
    		);
    		menuItem3.setOnAction(
        			new EventHandler<ActionEvent>() {
        				@Override
        				public void handle(ActionEvent event) {
//        					System.out.println("Right Click Evnet... UnCheck All");
        					unCheckListAll();
        				}
        			}
        		);
        	contextMenu.getItems().addAll(menuItem1, menuItem2, menuItem3);
    		contextMenu.show(_tvObjectList, event.getScreenX(), event.getScreenY());
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
    	ObservableList<String> rowData = _tvObjectList.getSelectionModel().getSelectedItem();
		String sOwner;
		String sDB = rowData.get(2);
		String sObjectName = rowData.get(3).toUpperCase();
		String sObjectType = rowData.get(1).toUpperCase();
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
    	ObservableList<String> rowData = _tvObjectList.getSelectionModel().getSelectedItem();
		String sOwner;
		String sDB = rowData.get(2);
		String sObjectName = rowData.get(3).toUpperCase();
		String sObjectType = rowData.get(1).toUpperCase();
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
    	ObservableList<String> rowData = _tvObjectList.getSelectionModel().getSelectedItem();
        rowData.set(0, String.valueOf(!Boolean.valueOf(rowData.get(0))));
     	_tvObjectList.refresh();
    }
    
    private void checkListAll() {
    	ObservableList<ObservableList> olist = (ObservableList<ObservableList>)_tvObjectList.getItems();
    	olist.forEach(row -> row.set(0, "true"));
    	_tvObjectList.refresh();
    	
    }

    private void unCheckListAll() {
    	ObservableList<ObservableList> olist = (ObservableList<ObservableList>)_tvObjectList.getItems();
    	olist.forEach(row -> row.set(0, "false"));
    	_tvObjectList.refresh();
    }

	
	
	
	
	@FXML
	public void onButtonClose() {
		_mainApp.getPrimaryStage().close();
		System.exit(0);
	}
}
