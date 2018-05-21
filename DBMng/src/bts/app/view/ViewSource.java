package bts.app.view;

import javafx.fxml.FXML;
import javafx.scene.control.TextArea;
import javafx.stage.Stage;

import java.time.Duration;
import java.util.Collection;
import java.util.Collections;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//import org.fxmisc.flowless.VirtualizedScrollPane;
import org.fxmisc.richtext.CodeArea;
import org.fxmisc.richtext.LineNumberFactory;
import org.fxmisc.richtext.model.StyleSpans;
import org.fxmisc.richtext.model.StyleSpansBuilder;
import org.reactfx.Subscription;

import bts.app.Main;

public class ViewSource {
	
	private Stage _stage;
	@FXML
	private TextArea _textArea; 
	
    public void setText(String strText) {
    	_textArea.setText(strText);		
    }

	/**
	 * controller class 초기화
	 * fxml 파일이 로드된 후 자동으로 호출됨
	 */
	@FXML
	private void initialize() {
	}
	
	/**
	 * 다이어로그의 스테이지 설정
	 * @param dialogStage
	 */
	public void setDialogStage(Stage dialogStage) {
		this._stage = dialogStage;
	}
	
	@FXML
	public void handleClose() {
		_stage.close();
	}
	

	
}
