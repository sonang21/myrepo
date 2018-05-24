package bts.app.view;

import javafx.fxml.FXML;
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

import bts.app.MainApp;

public class ViewSourceEx {
	
	private Stage _stage;
	private String _sText;
	@FXML
	private CodeArea _codeArea;
//	private TextArea _textArea; 
	
    private static final String[] KEYWORDS = new String[] {
           "select", "distinct", "with" 
         , "from", "where", "join", "on", "outer", "left", "right", "full", "cross"
         , "and", "or", "option", "in", "exists", "not"
         , "order", "group", "by"
         , "update", "delete", "insert", "into", "values"
         , "union", "all", "extract", "minus", "intersect"
         , "create", "alter", "drop", "modify", "replace"
         , "table", "view", "column", "function", "procedure", "package", "body", "index"
         , "set", "declare", "begin", "end", "while", "for", "if"
         , "exec", "execute", "immediate", "call"
         , "case", "when", "then", "else", "as", "is", "return"
         , "open", "loop", "fetch", "next", "exit", "exception", "others", "close", "commit", "rollback", "cursor"
         , "null", "nvl", "isnull", "decode", "sysdate"
    };

    private static final String KEYWORD_PATTERN = "(?i)\\b(" + String.join("|", KEYWORDS) + ")\\b"; // (?i) ignorecase
    private static final String PAREN_PATTERN = "\\(|\\)";
    private static final String BRACE_PATTERN = "\\{|\\}";
    private static final String BRACKET_PATTERN = "\\[|\\]";
    private static final String SEMICOLON_PATTERN = "\\;";
//    private static final String STRING_PATTERN = "\"([^\"\\\\]|\\\\.)*\"";
    private static final String STRING_PATTERN = "\"([^\"\\\\]|\\\\.)*\"" + "|" + "\'([^\'\\\\]|\\\\.)*\'";
//    private static final String COMMENT_PATTERN = "//[^\n]*" + "|" + "/\\*(.|\\R)*?\\*/";
    private static final String COMMENT_PATTERN = "--[^\n]*" + "|" + "/\\*(.|\\R)*?\\*/";

    private static final Pattern PATTERN = Pattern.compile(
            "(?<KEYWORD>" + KEYWORD_PATTERN + ")"
            + "|(?<PAREN>" + PAREN_PATTERN + ")"
            + "|(?<BRACE>" + BRACE_PATTERN + ")"
            + "|(?<BRACKET>" + BRACKET_PATTERN + ")"
            + "|(?<SEMICOLON>" + SEMICOLON_PATTERN + ")"
            + "|(?<STRING>" + STRING_PATTERN + ")"
            + "|(?<COMMENT>" + COMMENT_PATTERN + ")"
    );

    public void setText(String strText) {
    	_sText = strText;
		prepareCodeArea();		
    }
	public void prepareCodeArea() {
//		_codeArea.setText(strText);
        // add line numbers to the left of area
        _codeArea.setParagraphGraphicFactory(LineNumberFactory.get(_codeArea));

        @SuppressWarnings("unused")
        // recompute the syntax highlighting 500 ms after user stops editing area
        Subscription cleanupWhenNoLongerNeedIt = _codeArea

                // plain changes = ignore style changes that are emitted when syntax highlighting is reapplied
                // multi plain changes = save computation by not rerunning the code multiple times
                //   when making multiple changes (e.g. renaming a method at multiple parts in file)
                .multiPlainChanges()

                // do not emit an event until 500 ms have passed since the last emission of previous stream
                .successionEnds(Duration.ofMillis(500))

                // run the following code block when previous stream emits an event
                .subscribe(ignore -> _codeArea.setStyleSpans(0, computeHighlighting(_codeArea.getText())));

        // when no longer need syntax highlighting and wish to clean up memory leaks
        // run: `cleanupWhenNoLongerNeedIt.unsubscribe();`
        _codeArea.replaceText(0, 0, _sText);
        _codeArea.getStylesheets().add(MainApp.class.getResource("sql-keywords.css").toExternalForm());
        

	}
	
    private static StyleSpans<Collection<String>> computeHighlighting(String text) {
        Matcher matcher = PATTERN.matcher(text);
        int lastKwEnd = 0;
        StyleSpansBuilder<Collection<String>> spansBuilder
                = new StyleSpansBuilder<>();
        while(matcher.find()) {
            String styleClass =
                    matcher.group("KEYWORD") != null ? "keyword" :
                    matcher.group("PAREN") != null ? "paren" :
                    matcher.group("BRACE") != null ? "brace" :
                    matcher.group("BRACKET") != null ? "bracket" :
                    matcher.group("SEMICOLON") != null ? "semicolon" :
                    matcher.group("STRING") != null ? "string" :
                    matcher.group("COMMENT") != null ? "comment" :
                    null; /* never happens */ assert styleClass != null;
            spansBuilder.add(Collections.emptyList(), matcher.start() - lastKwEnd);
            spansBuilder.add(Collections.singleton(styleClass), matcher.end() - matcher.start());
            lastKwEnd = matcher.end();
        }
        spansBuilder.add(Collections.emptyList(), text.length() - lastKwEnd);
        return spansBuilder.create();
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
