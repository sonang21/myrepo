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
import javafx.scene.control.SelectionMode;
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
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileOutputStream;
//import java.io.FileInputStream;
//import java.io.IOException;
//import java.util.Iterator;
import java.util.ArrayList;

//@SuppressWarnings({"unchecked","rawtypes"})
public class ObjectList {
	enum enYN { Y, N};
	private MainApp _mainApp;
	private ContextMenu _contextMenu;
	@FXML
	private TableView<RowData> _tvObjectList;
	
	private TableViewManager _viewManager;
	private File _file;
	
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
				event.consume();
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
        _file = fileChooser.showOpenDialog(_mainApp.getPrimaryStage());

        if (_file != null) {
        	System.out.println("File choosed: " + _file.getName());
        	
        	try {
        		//Workbook workbook = WorkbookFactory.create(_file);
        		Workbook workbook = WorkbookFactory.create(_file, null, true);  // _file, passwd, readonly
        		System.out.println("Workbook has " + workbook.getNumberOfSheets() + " Sheets!");
        		
        		for(Sheet sheet : workbook) {
        			System.out.println(sheet.getSheetName());
        		}
//        		workbook.forEach( sheet -> {System.out.println(sheet.getSheetName());} );
//        		System.out.println("\n\nIterating over Rows and Columns using for-each loop\n");
        		// Getting the Sheet at index zero
        		Sheet sheet = workbook.getSheetAt(0);
        		// Create a DataFormatter to format and get each cell's value as String
                DataFormatter dataFormatter = new DataFormatter();
                
        		_viewManager = new TableViewManager(_tvObjectList, true);
                
                int ir=0; 
                String colName;
                int ic=0;
                ArrayList<String> cols = new ArrayList<>();
        		for (Row row: sheet) {
        			//첫줄에 대해서 컬럼 헤더 설정
        			if (ir==0) {
//        				_viewManager.addColumnInteger("번호", "번호", false);
//        				_viewManager.addColumnCheckBox("선택", "선택", true); // 체크박스 컬럼에 대해 명칭으로 관리
//	        			_viewManager.addColumnString("검사", "검사", false); // 부가적인 컬럼 설정
        				ic=0;
	        			for(Cell cell: row) {
	        				colName = dataFormatter.formatCellValue(cell);
//	        				colName = cell.getStringCellValue();
			                cols.add(colName);
			                
			                switch (ic) {
			                case 0:
			                	_viewManager.addColumnInteger(colName,colName, false);
			                	break;
			                case 1:
			                	_viewManager.addColumnCheckBox(colName,colName, true);
			                	break;
			                case 2:
//			                	_viewManager.addColumnComboBox(colName,colName, true, enYN.class);
			                	_viewManager.addColumnComboBox(colName,colName, true, new String[]{"Y","N"});
			                   	break;
			                default:
			                	_viewManager.addColumnString(colName,colName, false);
			                }
			                ic++;
	        			}
        			}
        			else {
        				//_viewManager.newRowData();
        				RowData rowData = new RowData();
        				ic=0;
        				for(Cell cell : row) {
//	                        String cellValue = dataFormatter.formatCellValue(cell); //수식을 그대로 읽음
//	                        rowData.setValue(cols.get(iC++), cellValue);
	                        
			                switch (ic) {
			                case 0:
			                	rowData.setValueInteger(cols.get(ic), (int) cell.getNumericCellValue());
			                	break;
			                case 1:
			                	rowData.setValueBoolean(cols.get(ic), cell.getBooleanCellValue());
			                	break;
			                default:
			                	rowData.setValueString(cols.get(ic), cell.getStringCellValue());
			                }
			                ic++;
			                
			                //cell.setCellValue("xxx");
	        			}
        				_viewManager.addRowData(rowData);
        			}
        			ir++;
                }
        		//_tvObjectList.setItems(rowList);
        		_viewManager.setTableViewItems();
        		_viewManager.setEditable(true);
        		_viewManager.getTableView().getSelectionModel().setCellSelectionEnabled(true);
        		_viewManager.getTableView().getSelectionModel().setSelectionMode(SelectionMode.MULTIPLE);
        		//workbook.write(new FileOutputStream(_file));
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
	
	public void workbookSave() {
		ObservableList<RowData> rows = _tvObjectList.getItems();
		int iColumnCount = _tvObjectList.getColumns().size();
		if (rows == null) {
    		Alert alert = new Alert(AlertType.WARNING);
    		alert.initOwner(_mainApp.getPrimaryStage());
    		alert.setTitle("Workbook Save");
    		alert.setHeaderText("Save Error");
    		alert.setContentText("저장할 데이터가 없습니다.");
    		alert.showAndWait();
		}
		try {
	        FileChooser fileChooser = new FileChooser();

	        // 확장자 필터를 설정한다.
	        FileChooser.ExtensionFilter extFilter = new FileChooser.ExtensionFilter(
	                "Excel files (*.xls)", "*.xls");
	        fileChooser.getExtensionFilters().add(extFilter);
	        fileChooser.setInitialDirectory(_file.getParentFile());
	        fileChooser.setInitialFileName(_file.getName());
	        
	        System.out.println(_file.getAbsolutePath());
	        
	        // File Dialog를 보여준다.
	        File fileWrite = fileChooser.showSaveDialog(_mainApp.getPrimaryStage());
	        if(fileWrite == null) return;
	        
			Workbook workbook = WorkbookFactory.create(_file, null, true);
			Sheet sheet = workbook.getSheetAt(0);
			
			for(int r=0; r < rows.size(); r++) {
				for(int c=0; c < iColumnCount; c++) {
					Object value = rows.get(r).getValue(c);
					try {
						if(value instanceof String) {
							sheet.getRow(r+1).getCell(c).setCellValue((String)value);
						}
						else if(value instanceof Boolean) {
							sheet.getRow(r+1).getCell(c).setCellValue((Boolean)value);
						}
						else if (value instanceof Integer) {
							sheet.getRow(r+1).getCell(c).setCellValue((Integer)value);
						}
						else {
							sheet.getRow(r+1).getCell(c).setCellValue((String)value);
						}
					}
					catch (Exception ex){
						System.out.print(String.format("[%d,%d] %s", r, c, value.toString()));
						ex.printStackTrace();
					}
				}
			}
			
			workbook.write(new FileOutputStream(fileWrite));
			workbook.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
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
        	} 
//    		else if(event.getClickCount() == 2) {
//        		showObjectText(false);
//        	} 
    		else {
        		if (_contextMenu != null && _contextMenu.isShowing()) {
        			_contextMenu.hide();
        		}
        	}
        	
    	} else if(event.getButton() == MouseButton.SECONDARY) {
    		showContextMenu(event);
    	}
    }

    private void showObjectText(boolean bBeautifulShow) {
    	String strText="";
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
	
		String sDBType = rowData.getValueString("DBMS");
		String sDBConn = rowData.getValueString("SOURCE");
		String sSchema = rowData.getValueString("SCHEMA");
		String sObjectType = rowData.getValueString("중분류").toUpperCase();
		String sObjectName = rowData.getValueString("프로그램ID").toUpperCase();
		
		System.out.println(String.format("%s,%s,%s,%s,%s", sDBType, sDBConn, sSchema, sObjectType, sObjectName));
		DBObjectWork dbo = new DBObjectWork(sDBConn);
		System.out.println(dbo.toString());

		if (sDBType.equalsIgnoreCase("ORACLE")) {
			strText = dbo.getOracleText(sSchema, sObjectName, sObjectType);
		}
		else if(sDBType.equalsIgnoreCase("MS-SQL")) {
			strText = dbo.getMSSQLText(sSchema, "dbo", sObjectName, sObjectType);
		}
		
		dbo.closeAll();
		if(bBeautifulShow) {
			_mainApp.showViewSourceExDialog(strText);
		} 
		else {
			_mainApp.showViewSourceDialog(strText);
		}
    }

    private void chagneCheckStatus() {
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	rows.forEach(row -> row.setBooleanReverse(index));
    	_tvObjectList.refresh();
    }

//    private void chagneCheckStatusOld() {
//    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
////    	System.out.println("begin..." + rowData.getValueBoolean(0));
//    	rowData.setBooleanReverse(_viewManager.getColumnIndex("선택"));
////    	System.out.println("end  ..." + rowData.getValueBoolean(0));
//    	//RowData.set(0, String.valueOf(!Boolean.valueOf(rowData.get(0))));
//     	_tvObjectList.refresh();
//    }
    
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
		workbookSave();
		_mainApp.getPrimaryStage().close();
		System.exit(0);
	}

	@FXML
	public void onButtonSave() {
		workbookSave();
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
						showObjectText(true);
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
