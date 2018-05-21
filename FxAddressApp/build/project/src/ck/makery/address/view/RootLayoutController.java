package ck.makery.address.view;

import java.io.File;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.FileChooser;
import ck.makery.address.MainApp;

/**
 * ���� ���̾ƿ��� ���� ��Ʈ�ѷ��̴�. ���� ���̾ƿ��� �޴��ٿ� JavaFX ������Ʈ�� �� ������ ������ �⺻���� ���̾ƿ��� �����Ѵ�.
 *
 * @author Marco Jakob
 */

public class RootLayoutController {
    // ���� ���ø����̼� ����
    private MainApp _mainApp;

    /**
     * ������ �ٽ� �����ϱ� ���� ���� ���ø����̼��� ȣ���Ѵ�.
     *
     * @param mainApp
     */
    public void setMainApp(MainApp mainApp) {
        this._mainApp = mainApp;
    }

    /**
     * ��� �ִ� �ּҷ��� �����.
     */
    @FXML
    private void handleNew() {
    	_mainApp.getPersonData().clear();
    	_mainApp.setPersonFilePath(null);
    }

    /**
     * FileChooser�� ��� ����ڰ� ������ �ּҷ��� �����ϰ� �Ѵ�.
     */
    @FXML
    private void handleOpen() {
        FileChooser fileChooser = new FileChooser();

        // Ȯ���� ���͸� �����Ѵ�.
        FileChooser.ExtensionFilter extFilter = new FileChooser.ExtensionFilter(
                "XML files (*.xml)", "*.xml");
        fileChooser.getExtensionFilters().add(extFilter);

        // Save File Dialog�� �����ش�.
        System.out.println("## 0 ########################################################");
        System.out.println(_mainApp.getPrimaryStage().toString());
        System.out.println("## 1 ########################################################");
        
        File file = fileChooser.showOpenDialog(_mainApp.getPrimaryStage());

        System.out.println("## 2 ########################################################");
        if (file != null) {
        	_mainApp.loadPersonDataFromFile(file);
        }
    }

    /**
     * ���� ���� �ִ� ���Ͽ� �����Ѵ�.
     * ���� ���� �ִ� ������ ������ "save as" ���̾�α׸� �����ش�.
     *
     */
    @FXML
    private void handleSave() {
        File personFile = _mainApp.getPersonFilePath();
        if (personFile != null) {
        	_mainApp.savePersonDataToFile(personFile);
        } else {
            handleSaveAs();
        }
    }

    /**
     * FileChooser�� ��� ����ڰ� ������ ������ �����ϰ� �Ѵ�.
     */
    @FXML
    private void handleSaveAs() {
        FileChooser fileChooser = new FileChooser();

        // Ȯ���� ���͸� �����Ѵ�.
        FileChooser.ExtensionFilter extFilter = new FileChooser.ExtensionFilter(
                "XML files (*.xml)", "*.xml");
        fileChooser.getExtensionFilters().add(extFilter);

        // Save File Dialog�� �����ش�.
        File file = fileChooser.showSaveDialog(_mainApp.getPrimaryStage());

        if (file != null) {
            // ��Ȯ�� Ȯ���ڸ� ������ �Ѵ�.
            if (!file.getPath().endsWith(".xml")) {
                file = new File(file.getPath() + ".xml");
            }
            _mainApp.savePersonDataToFile(file);
        }
    }

    /**
     * About ���̾�α׸� �����ش�.
     */
    @FXML
    private void handleAbout() {
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle("AddressApp");
        alert.setHeaderText("About");
        alert.setContentText("Author: Marco Jakob\nWebsite: http://code.makery.ch");

        alert.showAndWait();
    }
    
    /**
     * ���� ��Ʈ�� ����.
     */
    @FXML
    private void handleShowBirthdayStatistics() {
      _mainApp.showBirthdayStatistics();
    }
    

    /**
     * ���ø����̼��� �ݴ´�.
     */
    @FXML
    private void handleExit() {
        System.exit(0);
    }
}
