/**
 * 
 */
package bts.utils.fxext;

import bts.utils.fxext.TableRow;
//import javafx.beans.binding.Bindings;
import javafx.scene.Node;
//import javafx.scene.control.ContentDisplay;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

/**
 * @author sonan
 *
 */
public class StringTableCell extends TableCellExt<TableRow, String> {
	@Override
	protected String getInputValue() {
		return((TextField) getInputNode()).getText();
	}
	
	@Override
	protected void setInputValue(String value) {
		((TextField) getInputNode()).setText(value);
//		System.out.println("StringTableCell.setInputValue() --> " + value);
	}
	
	@Override
	protected String getDefaultValue() {
		return "";
	}
	
	@Override
	protected Node createInputNode() {
		return new TextField();
	}
	
	@Override
	protected String inputValueToText(String strValue) {
		return strValue;
	}
	
	public StringTableCell(String fieldName) {
		// TODO Auto-generated constructor stub
//		System.out.println("StringTableCell.StringTableCell() ... start");
		Node field = getInputNode();
		
		// 문자열 편집에서는 상/하 방향키로 셀 이동을 하도록 이벤트 추가
		if (field != null) {
			// a cell-editor won't be committed or canceled automatically by JavFX 
			field.addEventFilter(KeyEvent.KEY_PRESSED, event -> {
				if (event.getCode() == KeyCode.DOWN || event.getCode() == KeyCode.UP) {
					commitEdit(getInputValue());
					
					if(event.getCode() == KeyCode.UP) {
						getTableView().getSelectionModel().selectAboveCell();
					} 
					else {
						getTableView().getSelectionModel().selectBelowCell();
					}
					
					getTableView().requestFocus(); //test
				}
			});
			
//			contentDisplayProperty().bind(
//					Bindings.when(editingProperty())
//						.then(ContentDisplay.GRAPHIC_ONLY)
//						.otherwise(ContentDisplay.TEXT_ONLY)
//			);
		}
		//System.out.println("StringTableCell.StringTableCell() ... end");
	}
	
	@Override
	public void commitEdit(String item) {
        super.commitEdit(item);
        TableView<TableRow> table = getTableView();
        if (table != null) {
        	table.getSelectionModel().getSelectedItem().setValue(_cellName, item);
//        	System.out.println(table.getSelectionModel().getSelectedItem().getValue(_cellName));
        }
    	
//        if (! isEditing() && ! item.equals(getItem())) {
//            TableView<S> table = getTableView();
//            if (table != null) {
//            	((RowData) table.getSelectionModel().getSelectedItem()).setValue(_fieldName, (String)item);
//            	System.out.println(((RowData)table.getSelectionModel().getSelectedItem()).getValue(_fieldName));
//            }
//        }
	}

}
