package sq;

import javafx.application.Application;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCodeCombination;
import javafx.scene.input.KeyCombination;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import sq.view.SimpleQuery;

//import java.io.File;
//import java.io.FileInputStream;
import java.io.IOException;
//import java.nio.file.Paths;



public class MainApp extends Application {
	
	private Stage _primaryStage;
	private BorderPane _rootLayout;
	private SimpleQuery _simpleQuery;
	
	@Override
	public void start(Stage primaryStage) {
		this._primaryStage = primaryStage;
		this._primaryStage.setTitle("Simple Query Test");
		
		initRootLayout();
		showSimpleQuery();
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
            _primaryStage.setScene(scene);
            _primaryStage.show();
            
            _primaryStage.widthProperty().addListener(
            		(obs, oldVal, newVal) -> {
            			// Do whatever you want
            			System.out.println("Resized....");
            			_simpleQuery.setSplitPosition(0.25);
            		}
            );
            // shortcut key event handling
            scene.addEventFilter(KeyEvent.KEY_PRESSED, new EventHandler<KeyEvent>() {
                final KeyCombination keyComb = new KeyCodeCombination(KeyCode.R,
                                                                      KeyCombination.CONTROL_DOWN);
                public void handle(KeyEvent ke) {
                    if (keyComb.match(ke)) {
                        System.out.println("Key Pressed: " + keyComb);
                        _simpleQuery.onButtonExecute();
                        ke.consume(); // <-- stops passing the event to next node
                    } else if (ke.getCode() == KeyCode.F5) {
                    	System.out.println("key Pressed: " + KeyCode.F5);
                    	_simpleQuery.onButtonExecute();
                        ke.consume(); // <-- stops passing the event to next node
                    }
                }
            });
            
            
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	private void showSimpleQuery() {
        try {
            // 
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainApp.class.getResource("view/SimpleQuery.fxml"));
            AnchorPane simpleQuery = (AnchorPane) loader.load();
            // 상위 레이아웃 가운데로 설정한다.
            _rootLayout.setCenter(simpleQuery);
            
			// 메인 애플리케이션이 컨트롤러를 이용할 수 있게 한다.
			//SimpleQuery controller = loader.getController();
//            controller.setMainApp(this);
            _simpleQuery = loader.getController();
			_simpleQuery.setMainApp(this);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	public Stage getPrimaryStage() {
		return this._primaryStage;
	}

	public static void main(String[] args) {
		launch(args);
	}
}
