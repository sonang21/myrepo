package ck.makery.address.view;

import javafx.fxml.FXML;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

import sonang.utils.date.DateUtil;
import ck.makery.address.MainApp;
import ck.makery.address.model.Person;



public class PersonOverviewController {
	@FXML
	private TableView<Person> _personTable;
	@FXML
	private TableColumn<Person, String> _firstNameColumn;
	@FXML
	private TableColumn<Person, String> _lastNameColumn;
	
	@FXML
	private Label _firstNameLabel;
	@FXML
	private Label _lastNameLabel;
	@FXML
	private Label _streetLabel;
	@FXML
	private Label _postalCodeLabel;
	@FXML
	private Label _cityLabel;
	@FXML
	private Label _birthdayLable;
	
	private MainApp mainApp;
	
	public PersonOverviewController() {
		
	}
	
	/**
     * ��Ʈ�ѷ� Ŭ������ �ʱ�ȭ�Ѵ�.
     * fxml ������ �ε�ǰ� ���� �ڵ����� ȣ��ȴ�.
     */
	@FXML
	private void initialize() {
		_firstNameColumn.setCellValueFactory(cellData -> cellData.getValue().firstNameProperty());
		_lastNameColumn.setCellValueFactory(cellData -> cellData.getValue().lastNameProperty());
	
		// ����ó ���� ����
		showPersonDetails(null);
		
		// ������ �����ϰ� �� ������ ����ó�� �ڼ��� ������ ������
		_personTable.getSelectionModel().selectedItemProperty().addListener(
					(observable, oldValue, newValue) -> showPersonDetails(newValue));
	}
	
	/**
     * ������ �ٽ� �����ϱ� ���� ���� ���ø����̼��� ȣ���Ѵ�.
     *
     * @param mainApp
     */
    public void setMainApp(MainApp mainApp) {
        this.mainApp = mainApp;

        // ���̺� observable ����Ʈ �����͸� �߰��Ѵ�.
        _personTable.setItems(mainApp.getPersonData());
    }
    
    /**
     * ����ó�� �ڼ��� ������ �����ֱ� ���� ��� �ؽ�Ʈ �ʵ带 ä���.
     * ���� person�� null�̸� ��� �ؽ�Ʈ �ʵ尡 ��������.
     * 
     * @param person
     * 
     */
    private void showPersonDetails(Person person) {
    	if(person != null) {
    		//person ��ü�� label�� ������ ä���.
    		_firstNameLabel.setText(person.getFirstName());
    		_lastNameLabel.setText(person.getLastName());
    		_streetLabel.setText(person.getStreet());
    		_postalCodeLabel.setText(Integer.toString(person.getPostalCode()));
    		_cityLabel.setText(person.getCity());
    		_birthdayLable.setText(DateUtil.format(person.getBirthday()));
    	} else {
    		//person�� null�̸� �ؽ�Ʈ�� �����.
    		_firstNameLabel.setText("");
    		_lastNameLabel.setText("");
    		_streetLabel.setText("");
    		_postalCodeLabel.setText("");
    		_cityLabel.setText("");
    		_birthdayLable.setText("");
    	}
    }
    
    /**
     * ������ư
     */
    @FXML
    private void handleDeletePerson() {
    	int selectedIndex = _personTable.getSelectionModel().getSelectedIndex();
    	if(selectedIndex >=0) {
    		_personTable.getItems().remove(selectedIndex);
    	} else {
    		Alert alert = new Alert(AlertType.WARNING);
    		alert.initOwner(mainApp.getPrimaryStage());
    		alert.setTitle("No Selection");
    		alert.setHeaderText("No Person Selected");
    		alert.setContentText("Please select a person in a table.");
    		alert.showAndWait();
    	}
    	
    }
    
    /**
     * ����ڰ� new ��ư�� Ŭ���� �� ȣ��ȴ�.
     * ���ο� ����ó ������ �ֱ� ���� ���̾�α׸� ����.
     */
    @FXML
    private void handleNewPerson() {
        Person tempPerson = new Person();
        boolean okClicked = mainApp.showPersonEditDialog(tempPerson);
        if (okClicked) {
            mainApp.getPersonData().add(tempPerson);
        }
    }

    /**
     * ����ڰ� edit ��ư�� Ŭ���� �� ȣ��ȴ�.
     * ������ ����ó ������ �����ϱ� ���� ���̾�α׸� ����.
     */
    @FXML
    private void handleEditPerson() {
        Person selectedPerson = _personTable.getSelectionModel().getSelectedItem();
        if (selectedPerson != null) {
            boolean okClicked = mainApp.showPersonEditDialog(selectedPerson);
            if (okClicked) {
                showPersonDetails(selectedPerson);
            }

        } else {
            // �ƹ��͵� �������� �ʾҴ�.
            Alert alert = new Alert(AlertType.WARNING);
            alert.initOwner(mainApp.getPrimaryStage());
            alert.setTitle("No Selection");
            alert.setHeaderText("No Person Selected");
            alert.setContentText("Please select a person in the table.");

            alert.showAndWait();
        }
    }
    
}
