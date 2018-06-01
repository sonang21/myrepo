/**
 * 
 */
package bts.utils.fxext;

import bts.app.model.RowData;
import javafx.scene.Node;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

/**
 * @author sonan
 *
 */
public class TextCell extends TableCellExt<RowData, String> {
	@Override
	protected String getInputValue() {
		return((TextField) getInputNode()).getText();
	}
	
	@Override
	protected void setInputValue(String value) {
		((TextField) getInputNode()).setText(value);
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
	
	public TextCell(String fieldName) {
		// TODO Auto-generated constructor stub
		//System.out.println("StringTableCell.StringTableCell() ... start");
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

}
