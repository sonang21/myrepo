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
import javafx.scene.control.TablePosition;
//import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.input.Clipboard;
import javafx.scene.input.ClipboardContent;
//import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCodeCombination;
import javafx.scene.input.KeyCombination;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
//import javafx.util.Callback;

//import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
//import java.io.FileInputStream;
//import java.io.IOException;
//import java.util.Iterator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;

//@SuppressWarnings({"unchecked","rawtypes"})
public class ObjectList {
	enum enYN { Y, N};
	private MainApp _mainApp;
	private ContextMenu _contextMenu;
	@FXML
	private TableView<RowData> _tvObjectList;
	
	private TableViewManager _viewManager;
	private File _file;
	private String _sExcelPath = "C:\\Temp";
	private String _sExcelFile = "";
	private String _sWorkingDir = "C:\\Temp\\ddls\\";
	private String _sBackupDir;
	private String _sTempDir;
		
	/**
     * 컨트롤러 클래스를 초기화한다.
     * fxml 파일이 로드되고 나서 자동으로 호출된다.
     */
	@FXML
	private void initialize() {
		checkWorkingDir();
	}
	
	private void checkWorkingDir() {
		_sTempDir = _sWorkingDir + "tmp\\";
		_sBackupDir = _sWorkingDir + "backup\\";
		
		File file = new File(_sTempDir);  // ddl 저장 위치 와 하위에 임시 파일 생성 디렉토리를 구성한다.
		if(!file.exists()) {
			System.out.println(file.mkdirs());
			System.out.println("Directory Created : " + _sTempDir);
		}
		
		file = new File(_sBackupDir);  // ddl 저장 위치 와 하위에 임시 파일 생성 디렉토리를 구성한다.
		if(!file.exists()) {
			System.out.println(file.mkdirs());
			System.out.println("Directory Created : " + _sBackupDir);
		}
	}
	
//	@SuppressWarnings("unused")
//	private static void printCellValue(Cell cell) {
//	    switch (cell.getCellTypeEnum()) {
//	        case BOOLEAN:
//	            System.out.println(cell.getBooleanCellValue());
//	            break;
//	        case STRING:
//	            System.out.println(cell.getRichStringCellValue().getString());
//	            break;
//	        case NUMERIC:
//	            if (DateUtil.isCellDateFormatted(cell)) {
//	                System.out.println(cell.getDateCellValue());
//	            } else {
//	                System.out.println(cell.getNumericCellValue());
//	            }
//	            break;
//	        case FORMULA:
//	            System.out.println(cell.getCellFormula());
//	            break;
//	        case BLANK:
//	            System.out.println("");
//	            break;
//	        default:
//	            System.out.println("");
//	    }
//
//	    System.out.println("\t");
//	}
	
	public void setMainApp(MainApp mainApp) { _mainApp = mainApp; }
	
	@FXML
	public void onButtonOpen() {
		Properties prop = _mainApp.getProperties();
		try {
			if(prop.containsKey("last_path")) {
				_sExcelPath = prop.getProperty("last_path");
			}
			
			_sExcelFile = prop.getProperty("last_file");
		}
		catch (Exception ex) {
			//ex.printStackTrace();
			System.err.println(ex.getMessage());
		}

        System.out.println("onButtonOpen() : last path= " + _sExcelPath + ", file=" + _sExcelFile);

		FileChooser fileChooser = new FileChooser();

        // 확장자 필터를 설정한다.
        FileChooser.ExtensionFilter extFilter = new FileChooser.ExtensionFilter(
                "Excel files (*.xls;*.xlsx)", "*.xls;*.xlsx");
        fileChooser.getExtensionFilters().add(extFilter);
        //fileChooser.setInitialDirectory(new File("C:\\Temp\\"));
        File path = new File(_sExcelPath);
        if(path.exists()) {
        	fileChooser.setInitialDirectory(path);
            fileChooser.setInitialFileName(_sExcelFile);
        }
        
        // File Dialog를 보여준다.
        _file = fileChooser.showOpenDialog(_mainApp.getPrimaryStage());

        if (_file != null) {
        	System.out.println("File choosed: " + _file.getName());
        	_sExcelPath = _file.getParentFile().getAbsolutePath();
        	_sExcelFile = _file.getName();
//        	_mainApp.getProperties().put("default_dir", _defaultPath);
        	prop.put("last_path", _sExcelPath);
        	prop.put("last_file", _sExcelFile);
        	_mainApp.saveProperties(prop);
        	
        	int ir=0; 
            String colName;
            int ic=0;
            
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
                
                ArrayList<String> cols = new ArrayList<>();
        		for (Row row: sheet) {
        			//첫줄에 대해서 컬럼 헤더 설정
        			if (ir==0) {
        				ic=0;
	        			for(Cell cell: row) {
	        				colName = dataFormatter.formatCellValue(cell);
//	        				colName = cell.getStringCellValue();
			                cols.add(colName);
			                
			                switch (ic) {
			                case 0:  //번호
			                	_viewManager.addColumnInteger(colName,colName, false);
			                	break;
			                case 1:  //선택 
			                	_viewManager.addColumnCheckBox(colName,colName, true);
			                	break;
			                case 13:  // DBMS : 드롭다운
			                	_viewManager.addColumnComboBox(colName,colName, true, new String[]{"ORACLE","MS-SQL","N/A"});
			                   	break;
			                case 14:  //자동이관여부 : 드롭다운
//			                	_viewManager.addColumnComboBox(colName,colName, true, enYN.class);
			                	_viewManager.addColumnComboBox(colName,colName, true, new String[]{"Y","N","검토", "N/A"});
			                   	break;
			                default:
			                	if(ic >= 9 && ic <= 12) { //편집가능 셀 설정
			                		_viewManager.addColumnString(colName,colName, true);
			                	}
			                	else {
			                		_viewManager.addColumnString(colName,colName, false);
			                	}
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
			                case 0: // 번호
			                	rowData.setValueInteger(cols.get(ic), (int) cell.getNumericCellValue());
			                	break;
			                case 1: // 선택
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
                alert.setHeaderText(String.format("Cell[%d, %d] 에서 오류", ir+1, ic+1));
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
					if(value == null) value = "";
					try {
						if(value instanceof String) {
							if(sheet.getRow(r+1).getCell(c) == null)
								sheet.getRow(r+1).createCell(c);
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
						System.out.println(String.format("[%d,%d] %s", r, c, value.toString()));
						System.out.println(sheet.toString());
						System.out.println(sheet.getRow(r+1).toString());
						System.out.println(sheet.getRow(r+1).getCell(c).toString());
						ex.printStackTrace();
						
					}
				}
			}
			
			workbook.write(new FileOutputStream(fileWrite));
			workbook.close();
		}
		catch (Exception ex) {
    		Alert alert = new Alert(AlertType.ERROR);
    		alert.initOwner(_mainApp.getPrimaryStage());
    		alert.setTitle("Workbook Save");
    		alert.setHeaderText("Save Error");
    		alert.setContentText(ex.getMessage());
    		alert.showAndWait();
			ex.printStackTrace();
		}
		
		
	}
	
	@SuppressWarnings("rawtypes")
	@FXML
	public void onKeyPressed(KeyEvent event) {
		if(event.getCode() == KeyCode.SPACE) {
			//_tvObjectList.getSelectionModel().getSelectedItem();
			chagneCheckStatus();
			event.consume();
		}
		else if(event.getCode() == KeyCode.ENTER) {
			//_tvObjectList.getSelectionModel().getSelectedItem();
			//showObjectText(false);
			showDiffWindow(true);
			event.consume();
		}
		else {
			final KeyCombination keyComb = new KeyCodeCombination(KeyCode.C,  KeyCombination.CONTROL_DOWN);
			if (keyComb.match(event)) {
//				System.out.println("onKeyPress():.........");
				ObservableList<TablePosition> posList = _tvObjectList.getSelectionModel().getSelectedCells();
				StringBuilder sbClip = new StringBuilder();
				int iR = -1;
				for(TablePosition p : posList) {
					int r = p.getRow();
					int c = p.getColumn();
					Object cell = _tvObjectList.getColumns().get(c).getCellData(r);
					if (cell == null) { cell = "";}
					if (iR == r) { 
						sbClip.append("\t");					
					}
					else if(iR != -1) {
						sbClip.append("\n");
					}
					sbClip.append(cell);
					iR = r;
				}
				final ClipboardContent content = new ClipboardContent();
				content.putString(sbClip.toString());
				Clipboard.getSystemClipboard().setContent(content);
				event.consume();
			}
		}
		
	}
	
    @FXML
    public void onClickObjectList(MouseEvent event)
    {
//        if (event.getClickCount() == 2) //Checking double click
    	// Get the height of the header.
//    	System.out.println("onClickObjectList() : Event Source : " + event.getSource());
//    	System.out.println("Event Target : " + event.getTarget());
    	if(event.getButton() == MouseButton.PRIMARY) {
//			System.out.println(event.getTarget().getClass().getSimpleName());
    		if(event.getTarget().getClass().getSimpleName().equalsIgnoreCase("CheckBoxTableCell") ) {
    			//event.getTarget().getClass().getSimpleName().equalsIgnoreCase("TableColumnHeader")
    			//System.out.println(event.getTarget().getClass().getSimpleName());
    			event.consume();
    			chagneCheckStatus();
        	} 
    		else if(event.getClickCount() == 2) {
        		event.consume();
        		try {
        			//showObjectText(false);
        			showDiffWindow(true);
        		}
        		catch (Exception ex) {
                    Alert alert = new Alert(AlertType.ERROR);
                    alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
                    alert.setHeaderText("");
                    alert.setContentText(ex.getMessage());
                    alert.showAndWait();
        		}
        	} 
    		else {
        		if (_contextMenu != null && _contextMenu.isShowing()) {
        			_contextMenu.hide();
        		}
        	}
        	
    	} else if(event.getButton() == MouseButton.SECONDARY) {
    		event.consume();
    		showContextMenu(event);
    	}
    }

    private void showObjectText(boolean bBeautifulShow) {
    	String strText[] = new String[2];
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
	
		String sDBType = rowData.getValueString("DBMS");
		String sDBConn = rowData.getValueString("SOURCE");
		String sSchema = rowData.getValueString("SCHEMA");
		String sObjectType = rowData.getValueString("중분류").toUpperCase();
		String sObjectName = rowData.getValueString("오브젝트명").toUpperCase();
		String sObjectInfo = String.format("[%s(%s),%s.%s.%s]", sDBType, sDBConn, sSchema, sObjectType, sObjectName); 
		System.out.println(sObjectInfo);
		DBObjectWork dbWork = new DBObjectWork(sDBConn);
		System.out.println(dbWork.toString());

		if (sDBType.equalsIgnoreCase("ORACLE")) {
			strText = dbWork.getOracleText(sSchema, sObjectName, sObjectType, false);
		}
		else if(sDBType.equalsIgnoreCase("MS-SQL")) {
			strText = dbWork.getMSSQLText(sSchema, "dbo", sObjectName, sObjectType, false);
		}
		
		dbWork.closeAll();
		if(strText[0].equals("1")) {
			if(bBeautifulShow) {
				_mainApp.showViewSourceExDialog(strText[1]);
			} 
			else {
				_mainApp.showViewSourceDialog(strText[1]);
			}
		}
		else {
			sObjectInfo = String.format("\n오브젝트에 대한 DDL문이 없습니다.\n\nDB : %s(%s)\nType : %s\nSchema(Owner): [%s]\nObject = [%s]\n"
					, sDBType, sDBConn
					, sObjectType, sSchema, sObjectName);
            
			Alert alert = new Alert(AlertType.WARNING);
            alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
            alert.setHeaderText(sObjectName);
            alert.setContentText(sObjectInfo);
            alert.showAndWait();
		}
    }

    private void getObjectSourceAll() {
    	checkWorkingDir();
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
    	
    	HashMap<String, DBObjectWork> dbWorks = new HashMap<>();
    	
		rows.forEach(row -> {
	    	String sResult="";
			if(row.getValueBoolean(index)) {
				String sObjType  = row.getValueString("중분류");
				String sObjName  = row.getValueString("오브젝트명");
				String sDBMS     = row.getValueString("DBMS");
				String[][] sText      = {{"",""},{"",""}};
//				String[] sSuffix    = {"src", "tgt"};
				
				String[] sConnNames = new String[2];
				sConnNames[0] = row.getValueString("SOURCE");
				sConnNames[1] = row.getValueString("TARGET");

				String[] sSchemas   = new String[2];
				sSchemas[0]   = row.getValueString("SCHEMA");
				sSchemas[1]   = row.getValueString("TGT_OWN");
				
				System.out.println(String.format("getObjectSourceAll(): DB:%s(%s=>%s), OWN:%s=>%s, Type:%s, Name:%s"
						, sDBMS
						, sConnNames[0], sConnNames[1]
						, sSchemas[0], sSchemas[1]								
						, sObjType
						, sObjName
					));
				
				//Collection에 을 DB별로 DBObjectWork 인스턴스 생성하여 추가  
				for(int i=0; i < sConnNames.length; i++) {
					if(! dbWorks.containsKey(sConnNames[i])) {
						DBObjectWork dbWork = new DBObjectWork(sConnNames[i]);
						dbWorks.put(sConnNames[i], dbWork);
					}	
				}
				
				if(sDBMS.equalsIgnoreCase("ORACLE")) {
					for(int i=0; i < sConnNames.length; i++) { // Source, Target(백업위해)에 대해서 각각 수행
						sText[i] = dbWorks.get(sConnNames[i]).getOracleText(sSchemas[i], sObjName, sObjType, true);
						if(!sText[i][0].equals("1")) sResult = sResult + sConnNames[i] + "(X)";
					}
				}
				else if(sDBMS.equalsIgnoreCase("MS-SQL")) {
					for(int i=0; i < sConnNames.length; i++) { // Source, Target(백업위해)에 대해서 각각 수행
						sText[i] = dbWorks.get(sConnNames[i]).getMSSQLText(sSchemas[i], "dbo", sObjName, sObjType, true);
						if(! sText[i][0].equals("1")) sResult = sResult + sConnNames[i] + "(X)";
					}
				}
				
				// 스크립트 추출 결과를 파일로 저장
				for(int i=0; i < sConnNames.length; i++) {
					try {
						if(sText[i][0].equals("1")) {
							//파일명 획득, i==1인 경우 Target Script로 백업에 저장
							String sFileS = getFileName(sObjType, sObjName, sConnNames[i], (i==1));
							FileOutputStream outputS = new FileOutputStream(sFileS);
							BufferedWriter writerS  = new BufferedWriter(new OutputStreamWriter(outputS, "UTF-8"));
							writerS.write(sText[i][1]);
							writerS.close();
						}
					}
					catch (Exception ex) {
						ex.printStackTrace();
						sResult = ex.getMessage();
					}
				}
				row.setValueString("결과", (sResult==""?"완료":sResult));
			};
		});
		
		dbWorks.forEach((k,v) -> v.closeAll());
		
    	_tvObjectList.refresh();

    	Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
        alert.setHeaderText("완료");
        alert.setContentText("요청작업을 완료하였습니다.");
        alert.showAndWait();

    }

    private void getObjectSource() {
    	checkWorkingDir();
    	
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
	
		String sDBType = rowData.getValueString("DBMS");
		String sObjectType = rowData.getValueString("중분류").toUpperCase();
		String sObjectName = rowData.getValueString("오브젝트명").toUpperCase();
		
		String sDBConnS = rowData.getValueString("SOURCE");
		String sSchemaS = rowData.getValueString("SCHEMA");
		
		String sObjectInfo = String.format("[%s(%s),%s.%s.%s]", sDBType, sDBConnS, sSchemaS, sObjectType, sObjectName); 
		System.out.println(sObjectInfo);
		DBObjectWork dbWorkS = new DBObjectWork(sDBConnS);
		System.out.println(dbWorkS.toString());
		String strTextS[] = {"",""};

		if (sDBType.equalsIgnoreCase("ORACLE")) {
			strTextS = dbWorkS.getOracleText(sSchemaS, sObjectName, sObjectType, true);
		}
		else if(sDBType.equalsIgnoreCase("MS-SQL")) {
			strTextS = dbWorkS.getMSSQLText(sSchemaS, "dbo", sObjectName, sObjectType, true);
		}
		
		dbWorkS.closeAll();
		
		if (! strTextS[0].equals("1")) {
			rowData.setValueString("결과", "없음(오류)");
            _tvObjectList.refresh();
            return;
		}

		try {
			String sFileS = getFileName(sObjectType, sObjectName, sDBConnS, false);
			FileOutputStream outputS = new FileOutputStream(sFileS);
			BufferedWriter writerS  = new BufferedWriter(new OutputStreamWriter(outputS, "UTF-8"));
			writerS.write(strTextS[1]);
			writerS.close();
			rowData.setValueString("결과", "완료");
            _tvObjectList.refresh();
		}
		catch (Exception ex) {
			ex.printStackTrace();
			rowData.setValueString("결과", ex.getMessage());
            _tvObjectList.refresh();
		}
    }

    private String getFileName(String sObjType, String sObjName, String sConnName, boolean isBackup ) {
    	String filePath = isBackup ? _sBackupDir : _sWorkingDir;
    	return String.format("%s%s_%s_%s.sql", filePath, sObjType, sObjName, sConnName);
    }

    private String getTempFileName(String sObjType, String sObjName, String sConnName ) {
//    	String filePath = isTemp ? _sTempDir : _sWorkingDir;
    	return String.format("%s%s_%s_%s.sql", _sTempDir, sObjType, sObjName, sConnName);
    }

    
    private void genScriptForApply() {
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
    	
    	rows.forEach(row -> {
	    	String sResult="완료";
			if(row.getValueBoolean(index)) {
				String sObjType   = row.getValueString("중분류");
				String sObjName   = row.getValueString("오브젝트명");
				String sDBMS      = row.getValueString("DBMS");
				String sConnNameS = row.getValueString("SOURCE");
				String sConnNameT = row.getValueString("TARGET");
//				String sSchemaS   = row.getValueString("SCHEMA");
				String sSchemaT   = row.getValueString("TGT_OWN");
//				String sText      = "";
				
				System.out.println(String.format("genScriptForApply(): DB:%s(%s), OWN:%s, Type:%s, Name:%s"
						, sDBMS
						, sConnNameT
						, sSchemaT								
						, sObjType
						, sObjName
					));
				
				try {
					String sFileR = getFileName(sObjType, sObjName, sConnNameS, false); //ObjType_ObjName_sConnNameS
					String sFileW = getFileName("_" + sConnNameT, sObjType, "all", false);
					
					FileInputStream input = new FileInputStream(sFileR);
					BufferedReader reader = new BufferedReader(new InputStreamReader(input, "UTF-8"));
					
					FileOutputStream output = new FileOutputStream(sFileW, true); //append
//					BufferedWriter writer  = new BufferedWriter(new OutputStreamWriter(output, "UTF-8"));
//					writer.write(sText);

					PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, "UTF-8"));
					
					while(true) {
			            String line = reader.readLine();
			            if (line==null) break;
			            writer.println(line);
			        }
					reader.close();
					writer.close();
					sResult = "성공";

				}
				catch (Exception ex) {
					ex.printStackTrace();
					sResult = ex.getMessage();
				}
				row.setValueString("결과", sResult);
			};
		});
    	
    	Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
        alert.setHeaderText("완료");
        alert.setContentText("요청작업을 완료하였습니다.");
        alert.showAndWait();
    }
    
    
    
    private void showDiffWindow(boolean bForceView) {
    	checkWorkingDir();
    	
    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
	
		String sDBType = rowData.getValueString("DBMS");
		String sObjectType = rowData.getValueString("중분류").toUpperCase();
		String sObjectName = rowData.getValueString("오브젝트명").toUpperCase();
		
		String sDBConnS = rowData.getValueString("SOURCE");
		String sSchemaS = rowData.getValueString("SCHEMA");
		
		String sDBConnT = rowData.getValueString("TARGET");
		String sSchemaT = rowData.getValueString("TGT_OWN");
		
		String sObjectInfo = String.format("[%s(%s),%s.%s.%s]", sDBType, sDBConnS, sSchemaS, sObjectType, sObjectName); 
		System.out.println(sObjectInfo);
		DBObjectWork dbWorkS = new DBObjectWork(sDBConnS);
		DBObjectWork dbWorkT = new DBObjectWork(sDBConnT);
		System.out.println(dbWorkS.toString() + dbWorkT.toString());
		String strTextS[] = {"",""};
		String strTextT[] = {"",""};
		
		if (sDBType.equalsIgnoreCase("ORACLE")) {
			strTextS = dbWorkS.getOracleText(sSchemaS, sObjectName, sObjectType, false);
			strTextT = dbWorkT.getOracleText(sSchemaT, sObjectName, sObjectType, false);
			
		}
		else if(sDBType.equalsIgnoreCase("MS-SQL")) {
			strTextS = dbWorkS.getMSSQLText(sSchemaS, "dbo", sObjectName, sObjectType, false);
			strTextT = dbWorkT.getMSSQLText(sSchemaT, "dbo", sObjectName, sObjectType, false);
		}
		
		dbWorkS.closeAll();
		dbWorkT.closeAll();
		
		if (strTextS[0]=="" && strTextT[0] == "") {
			rowData.setValueString("결과", "없음(오류)");
            _tvObjectList.refresh();
            return;
		}

		try {
			String sFileS = getTempFileName(sObjectType, sObjectName, sDBConnS + "_src");
			String sFileT = getTempFileName(sObjectType, sObjectName, sDBConnT + "_tgt");
			FileOutputStream outputS = new FileOutputStream(sFileS);
			BufferedWriter writerS  = new BufferedWriter(new OutputStreamWriter(outputS, "UTF-8"));
			writerS.write(strTextS[1]);
			writerS.close();
			FileOutputStream outputT = new FileOutputStream(sFileT);
			BufferedWriter writerT  = new BufferedWriter(new OutputStreamWriter(outputT, "UTF-8"));
			writerT.write(strTextT[1]);
			writerT.close();
			
			
			Runtime rt = Runtime.getRuntime();
//			Process pr = rt.exec("C:\\Program Files\\Devart\\Code Compare\\codecompare.exe C:\\temp\\tmp1.sql C:\\Temp\\tmp2.sql");
			Process pr = rt.exec(String.format("FC /W  %s %s", sFileS, sFileT));  // FC 파일비교 일치시 0, 불일치시 0, W:탭,공백무시
			BufferedReader input = new BufferedReader(new InputStreamReader(pr.getInputStream()));
			String sline=null;
			 
            while((sline=input.readLine()) != null) {
                System.out.println(sline);
            }

            int exitVal = pr.waitFor();
            System.out.println("FC Exited with error code "+exitVal);
            if (exitVal != 0 || bForceView) {
            	if(exitVal == 0) 
            		rowData.setValueString("결과", "일치");
            	else 
            		rowData.setValueString("결과", "불일치");
            	
                _tvObjectList.refresh();
            	String cmd = String.format("C:\\Program Files\\Devart\\Code Compare\\codecompare.exe %s %s", sFileS, sFileT); //W:wait
            	System.out.println("showDiffWindow(): " + cmd);
            	pr = rt.exec(cmd);  // FC 파일비교 일치시 0, 불일치시 0
            	exitVal = pr.waitFor();
            	System.out.println("CodeCompare Exited with error code "+exitVal);
            }
            else {
            	rowData.setValueString("결과", "일치");
                _tvObjectList.refresh();
    			Alert alert = new Alert(AlertType.INFORMATION);
    			alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
    			alert.setHeaderText(sObjectName);
    			alert.setContentText(sObjectName + "의 소스가 서로 일치 합니다.");
    			alert.showAndWait();
            }
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
//		}
//		else {
//			sObjectInfo = String.format("\n오브젝트에 대한 DDL문이 없습니다.\n\nDB : %s(%s)\nType : %s\nSchema(Owner): [%s]\nObject = [%s]\n"
//					, sDBType, sDBConnS
//					, sObjectType, sSchemaS, sObjectName);
//            
//			Alert alert = new Alert(AlertType.WARNING);
//            alert.setTitle(new Object() {}.getClass().getEnclosingMethod().getName());
//            alert.setHeaderText(sObjectName);
//            alert.setContentText(sObjectInfo);
//            alert.showAndWait();
//		}
    }


    private void chagneCheckStatus() {
    	if (_viewManager != null ) {
	    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
	    	int index = _viewManager.getColumnIndex("선택");
	    	rows.forEach(row -> row.setBooleanReverse(index));
	    	_tvObjectList.refresh();
    	}
    }

//    private void chagneCheckStatusOld() {
//    	RowData rowData = _tvObjectList.getSelectionModel().getSelectedItem();
////    	System.out.println("begin..." + rowData.getValueBoolean(0));
//    	rowData.setBooleanReverse(_viewManager.getColumnIndex("선택"));
////    	System.out.println("end  ..." + rowData.getValueBoolean(0));
//    	//RowData.set(0, String.valueOf(!Boolean.valueOf(rowData.get(0))));
//     	_tvObjectList.refresh();
//    }
    private void clearResults() {
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("결과");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
		rows.forEach(row -> {row.setValueString(index, "-"); row.setValueBoolean(index-1, null);});
    	_tvObjectList.refresh();
    }
    
    private void checkListAll() {
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
		rows.forEach(row -> row.setValueBoolean(index, true));
    	_tvObjectList.refresh();
    }

    private void unCheckListAll() {
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
		rows.forEach(row -> row.setValueBoolean(index, false));
    	_tvObjectList.refresh();
    }
    
    private void verifyObjects() {
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
    	
    	HashMap<String, DBObjectWork> dbWorks = new HashMap<>();
    	
    	
		rows.forEach(row -> {
			if(row.getValueBoolean(index)) {
				String sConnName = row.getValueString("SOURCE");
				String sObjType  = row.getValueString("중분류");
				String sObjName  = row.getValueString("오브젝트명");
				String sSchema   = row.getValueString("SCHEMA");
				String sDBMS     = row.getValueString("DBMS");
				String sResult   = "No";
				
				System.out.println(String.format("Verify... %s, %s, %s"
						, sConnName
						, sObjType
						, sObjName
					));
				if(! dbWorks.containsKey(sConnName)) {
					DBObjectWork dbWork = new DBObjectWork(sConnName);
					dbWorks.put(sConnName, dbWork);
				}
				
				if(sDBMS.equalsIgnoreCase("ORACLE")) {
					if(dbWorks.get(sConnName).objectExistsORACLE(sSchema, sObjName, sObjType))
						sResult = "Yes";

				}
				else if(sDBMS.equalsIgnoreCase("MS-SQL")) {
					if(dbWorks.get(sConnName).objectExistsMSSQL(sSchema, "dbo", sObjName))
						sResult = "Yes";
					
				}
				else {
					sResult = "FAIL: DBMS=" + sDBMS;
				}
				
				row.setValueString("존재", sResult);
			};
		});
		
		dbWorks.forEach((k,v) -> v.closeAll());
		
    	_tvObjectList.refresh();
    }
    
    private void compareAllObjects() {
    	checkWorkingDir();
    	
    	ObservableList<RowData> rows = _tvObjectList.getSelectionModel().getSelectedItems();
    	int index = _viewManager.getColumnIndex("선택");
    	if(rows.size() <= 1) {
    		rows = (ObservableList<RowData>)_tvObjectList.getItems();
    	}
    	
    	HashMap<String, DBObjectWork> dbWorks = new HashMap<>();
    	
		rows.forEach(row -> {
			if(row.getValueBoolean(index)) {
				String sObjType  = row.getValueString("중분류");
				String sObjName  = row.getValueString("오브젝트명");
				String sDBMS     = row.getValueString("DBMS");
				String sResult   = "불일치";
				String[] sConnNames = new String[2];
				String[] sSchemas   = new String[2];
				String[][] sText      = {{"",""},{"",""}};
				sConnNames[0] = row.getValueString("SOURCE");
				sConnNames[1] = row.getValueString("TARGET");
				sSchemas[0]   = row.getValueString("SCHEMA");
				sSchemas[1]   = row.getValueString("TGT_OWN");
				
				System.out.println(String.format("Compare: DB:%s(%s=>%s), OWN:%s=>%s, Type:%s, Name:%s"
						, sDBMS
						, sConnNames[0], sConnNames[1]
						, sSchemas[0], sSchemas[1]								
						, sObjType
						, sObjName
					));
				
				for(int i=0; i < sConnNames.length; i++) {
					if(! dbWorks.containsKey(sConnNames[i])) {
						DBObjectWork dbWork = new DBObjectWork(sConnNames[i]);
						dbWorks.put(sConnNames[i], dbWork);
					}	
				}
				
				if(sDBMS.equalsIgnoreCase("ORACLE")) {
					for(int i=0; i < sConnNames.length; i++) {
						sText[i] = dbWorks.get(sConnNames[i]).getOracleText(sSchemas[i], sObjName, sObjType, true);
						sText[i][1] = sText[i][1].replaceAll(" ", "");
					}
				}
				else if(sDBMS.equalsIgnoreCase("MS-SQL")) {
					for(int i=0; i < sConnNames.length; i++) {
						sText[i] = dbWorks.get(sConnNames[i]).getMSSQLText(sSchemas[i], "dbo", sObjName, sObjType, true);
						sText[i][1] = sText[i][1].replaceAll(" ", "");
					}
				}
				else {
					sResult = "FAIL: DBMS=" + sDBMS;
				}
				
				if(!sText[0][0].equals("1") && sText[0][1].equalsIgnoreCase(sText[1][1])) {
					sResult = "일치";
				}
				System.out.println("source:" + sText[0][1]);
				
				System.out.println("target:" + sText[1][1]);

				row.setValueString("결과", sResult);
			};
		});
		
		dbWorks.forEach((k,v) -> v.closeAll());
		
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
			
			MenuItem[] menuItems = new MenuItem[10];
			
			menuItems[0] = new MenuItem("소스 비교 보기");
			menuItems[1] = new MenuItem("전체 소스 비교");
			menuItems[2] = new MenuItem("전체 선택");
			menuItems[3] = new MenuItem("전체 선택 해제");
			menuItems[4] = new MenuItem("존재 여부 확인");
			menuItems[5] = new MenuItem("소스 보기");
			menuItems[6] = new MenuItem("소스 내려받기(전체)");
			menuItems[7] = new MenuItem("소스 내려받기");
			menuItems[8] = new MenuItem("결과삭제");
			menuItems[9] = new MenuItem("스크립트생성");
			
			//소스 비교 보기
			menuItems[0].setOnAction(
					new EventHandler<ActionEvent>() {
						@Override
						public void handle(ActionEvent event ) {
							showDiffWindow(true);
						}
					}
				);
			//전체 소스 비교
			menuItems[1].setOnAction(
					new EventHandler<ActionEvent>() {
						@Override
						public void handle(ActionEvent event ) {
							compareAllObjects();
						}
					}
				);

			//전체 선택
			menuItems[2].setOnAction(
				new EventHandler<ActionEvent>() {
					@Override
					public void handle(ActionEvent event) {
//						System.out.println("Right Click Evnet... Check All");
						checkListAll();
					}
				}
			);
			//전체 선택 해제
			menuItems[3].setOnAction(
	    			new EventHandler<ActionEvent>() {
	    				@Override
	    				public void handle(ActionEvent event) {
//	    					System.out.println("Right Click Evnet... UnCheck All");
	    					unCheckListAll();
	    				}
	    			}
	    		);
			// 존재 여부 확인
			menuItems[4].setOnAction(
					new EventHandler<ActionEvent>() {
						@Override
						public void handle(ActionEvent event ) {
							verifyObjects();
						}
					}
				);
				
			//소스보기
			menuItems[5].setOnAction(
				new EventHandler<ActionEvent>() {
					@Override
					public void handle(ActionEvent event ) {
						showObjectText(true);
					}
				}
			);
			
			//소스내려받기(전체)
			menuItems[6].setOnAction(
				new EventHandler<ActionEvent>() {
					@Override
					public void handle(ActionEvent event ) {
						getObjectSourceAll();
					}
				}
			);
			
			//소스내려받기
			menuItems[7].setOnAction(
				new EventHandler<ActionEvent>() {
					@Override
					public void handle(ActionEvent event ) {
						getObjectSource();
					}
				}
			);

			//결과 삭제
			menuItems[8].setOnAction(
					new EventHandler<ActionEvent>() {
						@Override
						public void handle(ActionEvent event ) {
							clearResults();
						}
					}
				);
			
			//스크립트 파일 생성
			menuItems[9].setOnAction(
					new EventHandler<ActionEvent>() {
						@Override
						public void handle(ActionEvent event ) {
							genScriptForApply();
						}
					}
				);

			_contextMenu.getItems().addAll(menuItems);
	    	_contextMenu.setConsumeAutoHidingEvents(true);
		} 
		_contextMenu.show(_tvObjectList, event.getScreenX(), event.getScreenY());
		
	}
	
}
