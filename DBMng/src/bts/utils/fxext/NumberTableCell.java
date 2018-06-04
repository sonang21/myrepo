/**
 * 
 */
package bts.utils.fxext;

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
public class NumberTableCell<T extends Number> extends TableCellExt<RowData, Number> {
	@Override
	protected Number getInputValue() {
		return  Integer.valueOf(((TextField) getInputNode()).getText());
	}
	
	@Override
	protected void setInputValue(Number value) {
		((TextField) getInputNode()).setText(String.valueOf(value));
//		System.out.println("StringTableCell.setInputValue() --> " + value);
	}
	
	@Override
	protected Number getDefaultValue() {
		return 0;
	}
	
	@Override
	protected Node createInputNode() {
		return new TextField();
	}
	
	@Override
	protected String inputValueToText(Number value) {
		return String.valueOf(value);
	}
	
	public NumberTableCell(String fieldName) {
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
//		System.out.println("StringTableCell.StringTableCell() ... end");
	}
	
	@Override
	public void commitEdit(Number item) {
        super.commitEdit(item);
        TableView<RowData> table = getTableView();
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
