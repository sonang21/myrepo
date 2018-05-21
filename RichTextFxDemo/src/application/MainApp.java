package application;

import java.io.IOException;

import application.view.RootLayout;

import javafx.application.Application;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCodeCombination;
import javafx.scene.input.KeyCombination;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class MainApp extends Application {
	private Stage _stage;
	private BorderPane _rootLayout;
	private RootLayout _rootController;

	private void initRootLayout() {
        try {
            // fxml ���Ͽ��� ���� ���̾ƿ��� �����´�.
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainApp.class.getResource("view/RootLayout.fxml"));
            _rootLayout = (BorderPane) loader.load();
            
            _rootController = loader.getController();
         
            // ���� ���̾ƿ��� �����ϴ� scene�� �����ش�.
            Scene scene = new Scene(_rootLayout);
            _stage.setScene(scene);
            _stage.show();
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	@Override
	public void start(Stage primaryStage) {
		try {
			_stage = primaryStage;
			_stage.setTitle("test app");
			
			initRootLayout();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	public static void main(String[] args) {
		launch(args);
	}
}
