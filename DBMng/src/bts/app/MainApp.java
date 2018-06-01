package bts.app;
	
import java.io.IOException;

import bts.app.view.ObjectList;
import bts.app.view.SQLPlanView;
import bts.app.view.TestTableView;
import bts.app.view.ViewSource;
import bts.app.view.ViewSourceEx;
import javafx.application.Application;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCodeCombination;
import javafx.scene.input.KeyCombination;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;

@SuppressWarnings("unused")
public class MainApp extends Application {
	private Stage _stage;
	private BorderPane _rootLayout;
	private ObjectList _objectList;
	private SQLPlanView _sqlPlanView;
	private TestTableView _testTableView;
	
	@Override
	public void start(Stage primaryStage) {
		try {
			_stage = primaryStage;
			_stage.setTitle("DB Object Transfer");
			
			initRootLayout();
//			initObjectList();
//			initSQLPlanView();
			initTestTableView();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void initTestTableView() {
		try {
			FXMLLoader loader = new FXMLLoader();
			loader.setLocation(TestTableView.class.getResource("TestTableView.fxml"));
			BorderPane testTableView = (BorderPane)loader.load();
			_rootLayout.setCenter(testTableView);
			
			_testTableView = loader.getController();
			_testTableView.setMainApp(this);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	
	private void initSQLPlanView() {
		try {
			FXMLLoader loader = new FXMLLoader();
			loader.setLocation(SQLPlanView.class.getResource("SQLPlanView.fxml"));
			BorderPane sqlPlanView = (BorderPane)loader.load();
			_rootLayout.setCenter(sqlPlanView);
			
			_sqlPlanView = loader.getController();
			_sqlPlanView.setMainApp(this);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	private void initObjectList() {
		try {
			FXMLLoader loader = new FXMLLoader();
			loader.setLocation(ObjectList.class.getResource("ObjectList.fxml"));
			AnchorPane objectList = (AnchorPane)loader.load();
			_rootLayout.setCenter(objectList);
			
			_objectList = loader.getController();
			_objectList.setMainApp(this);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	private void initRootLayout() {
        try {
            // fxml 파일에서 상위 레이아웃을 가져온다.
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainApp.class.getResource("view/RootLayout.fxml"));
            _rootLayout = (BorderPane) loader.load();
            
            /**
             * 절대 경로 등 위치에 있는 것을 로드할 경우에는 FileInputStream 사용
             */  
            //FileInputStream fileInputStream = new FileInputStream(new File("C:\\2.MyDev\\workspace\\FxSimpleQuery\\src\\sq\\view\\RootLayout.fxml"));
            //System.out.println(Paths.get(".").toAbsolutePath().toString()); //to check current path
            //System.out.println(new File("").getAbsoluteFile());  //to check current path
            //FileInputStream fileInputStream = new FileInputStream(new File("src\\sq\\view\\RootLayout.fxml"));
            //_rootLayout = (BorderPane) loader.load(fileInputStream);
            /* *** */
            
            // 상위 레이아웃을 포함하는 scene을 보여준다.
            Scene scene = new Scene(_rootLayout);
            _stage.setScene(scene);
            _stage.show();
            
            _stage.widthProperty().addListener(
            		(obs, oldVal, newVal) -> {
            			// Do whatever you want
            			System.out.println("Resized....");
            			//_simpleQuery.setSplitPosition(0.25);
            		}
            );
            // shortcut key event handling
            scene.addEventFilter(KeyEvent.KEY_PRESSED, new EventHandler<KeyEvent>() {
                final KeyCombination keyComb = new KeyCodeCombination(KeyCode.R,
                                                                      KeyCombination.CONTROL_DOWN);
                public void handle(KeyEvent ke) {
                    if (keyComb.match(ke)) {
                        System.out.println("Key Pressed: " + keyComb);
//                        _simpleQuery.onButtonExecute();
                        ke.consume(); // <-- stops passing the event to next node
                    } else if (ke.getCode() == KeyCode.F5) {
                    	System.out.println("key Pressed: " + KeyCode.F5);
//                    	_simpleQuery.onButtonExecute();
                        ke.consume(); // <-- stops passing the event to next node
                    }
                }
            });
            
            
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	public void showViewSourceDialog(String strText) {
	    try {
	        // fxml 파일을 로드하고 나서 새로운 스테이지를 만든다.
	        FXMLLoader loader = new FXMLLoader();
	        loader.setLocation(MainApp.class.getResource("view/ViewSource.fxml"));
	        BorderPane page = (BorderPane) loader.load();

	        // 다이얼로그 스테이지를 만든다.
	        Stage dialogStage = new Stage();
	        dialogStage.setTitle("Source View");
	        dialogStage.initModality(Modality.WINDOW_MODAL);
	        dialogStage.initOwner(_stage);
	        Scene scene = new Scene(page);
	        dialogStage.setScene(scene);

	        ViewSource controller = loader.getController();
	        controller.setDialogStage(dialogStage);
	        controller.setText(strText);
	        
	        // 다이얼로그를 보여주고 사용자가 닫을 때까지 기다린다.
	        dialogStage.showAndWait();

	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	public void showViewSourceExDialog(String strText) {
	    try {
	        // fxml 파일을 로드하고 나서 새로운 스테이지를 만든다.
	        FXMLLoader loader = new FXMLLoader();
	        loader.setLocation(MainApp.class.getResource("view/ViewSourceEx.fxml"));
	        BorderPane page = (BorderPane) loader.load();

	        // 다이얼로그 스테이지를 만든다.
	        Stage dialogStage = new Stage();
	        dialogStage.setTitle("Source View");
	        dialogStage.initModality(Modality.WINDOW_MODAL);
	        dialogStage.initOwner(_stage);
	        Scene scene = new Scene(page);
	        dialogStage.setScene(scene);

	        // person을 컨트롤러에 설정한다.
	        ViewSourceEx controller = loader.getController();
	        controller.setDialogStage(dialogStage);
	        controller.setText(strText);
	        
	        // 다이얼로그를 보여주고 사용자가 닫을 때까지 기다린다.
	        dialogStage.showAndWait();
	        //dialogStage.show();

	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}

	public Stage getPrimaryStage() {
		return _stage;
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}
