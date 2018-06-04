package bts.utils.fxext;

//import com.sun.javafx.scene.control.InputField;
import javafx.beans.binding.Bindings;
import javafx.scene.Node;
import javafx.scene.control.ContentDisplay;
import javafx.scene.control.TableCell;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

public abstract class TableCellExt<S,T> extends TableCell<S, T> {
	private Node _node;       //TextField... 
	private boolean _isEditing;
	private T _defaultValue;
	protected String _cellName;

	/** @return a newly created input field **/
	protected abstract Node createInputNode();
	
	/** Sets given value to the input field **/
	protected abstract void setInputValue(T value);
	
	/** @return the current value of the input field. */
	protected abstract T getInputValue();
	
	/** @return the default in case item is null, must be never null, else cell will not be editable **/
	protected abstract T getDefaultValue();
	
	/** @return converts the given value to a string, being the cell-renderer representation. **/
	protected abstract String inputValueToText(T value);

	@Override
	public void startEdit() {
//		System.out.println("TableCellEx.startEdit()... start");
//		System.out.println("TableCellEx.startEdit() 1 --> " + getItem().toString());
		try {
			_isEditing = true;
			setInputValue(getItem());
			super.setItem(getItem());
			super.startEdit();  //updateItem() will be called
//			System.out.println("TableCellEx.startEdit() 2 --> " + getItem().toString());
			// 텍스트 필드일 경우 편집 대상 텍스르를 전체 선택한 상태에서 편집모드로
			if(_node.getClass().getSimpleName().equalsIgnoreCase("TextField")) {
				((TextField) _node).selectAll();
				((TextField) _node).requestFocus();
			}
			
		}
		finally {
			_isEditing = false;
		}
//		System.out.println("TableCellEx.startEdit()... end");
		
	}
	
	/** Redirect to commitEdit(). Leaving the cell should commit, just ESCAPE should cancel **/
	@Override
	public void cancelEdit() {
		//avoid JavaFX NullPointerException when calling commitEdit()
//		System.out.println("TableCellEx.cancelEdit()... start");
		
		getTableView().edit(getIndex(),  getTableColumn());
		commitEdit(getInputValue());
//		System.out.println("TableCellEx.cancelEdit()... end");
	}
	
	private void cancelOnEscape() {
//		System.out.println("TableCellEx.cancelOnEscape()... start");
		if (_defaultValue != null) {  // canceling default means writing null
			setItem(_defaultValue = null);
			setText(null);
			setInputValue(null);
		}
		super.cancelEdit();
//		System.out.println("TableCellEx.cancelOnEscape()... end");
	}
	
	@Override
	protected void updateItem(T newValue, boolean empty) {

//		System.out.println("TableCellEx.updateItem()... start");
//		if(newValue != null) System.out.println("TableCellEx.updateItem() 1--> " + newValue.toString());
		
		if (_isEditing && newValue == null) {
			newValue = (_defaultValue = getDefaultValue());
//			if(newValue != null) System.out.println("TableCellEx.updateItem() default--> " + newValue.toString());
		}
		
		super.updateItem(newValue, empty);
		
		if(empty || newValue == null) {
			setText(null);
			setGraphic(null);
		}
		else {
			setText(inputValueToText(newValue));
			setGraphic(_isEditing || isEditing() ? getInputNode() : null);
		}
//		if(newValue != null) System.out.println("TableCellEx.updateItem() 2 --> " + newValue.toString());
//		System.out.println("TableCellEx.updateItem()... end");
	}
	
	protected final Node getInputNode() {
//		System.out.println("TableCellEx.getInputFiled() ... start");
		if (_node == null) {
			_node = createInputNode();
			
			// a cell-editor won't be committed or canceled automatically by JavFX 
			_node.addEventFilter(KeyEvent.KEY_PRESSED, event -> {
				if (event.getCode() == KeyCode.ENTER || event.getCode() == KeyCode.TAB) {
					commitEdit(getInputValue());
					
					getTableView().getSelectionModel().selectBelowCell();
					getTableView().requestFocus(); 
				}
				else if (event.getCode() == KeyCode.ESCAPE) {
					cancelOnEscape();
				}
				

			});
			
			contentDisplayProperty().bind(
					Bindings.when(editingProperty())
						.then(ContentDisplay.GRAPHIC_ONLY)
						.otherwise(ContentDisplay.TEXT_ONLY)
			);
		}
//		System.out.println("TableCellEx.getInputFiled() ... end");
		return _node;
	}
	
	public void setCellName(String cellName) {
		_cellName = cellName;
	}
	public String getCellName() {
		return _cellName;
	}

}
