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
     * 컨트롤러 클래스를 초기화한다.
     * fxml 파일이 로드되고 나서 자동으로 호출된다.
     */
	@FXML
	private void initialize() {
		_firstNameColumn.setCellValueFactory(cellData -> cellData.getValue().firstNameProperty());
		_lastNameColumn.setCellValueFactory(cellData -> cellData.getValue().lastNameProperty());
	
		// 연락처 정보 삭제
		showPersonDetails(null);
		
		// 선택을 감지하고 그 때마다 연락처의 자세한 정보를 보여줌
		_personTable.getSelectionModel().selectedItemProperty().addListener(
					(observable, oldValue, newValue) -> showPersonDetails(newValue));
	}
	
	/**
     * 참조를 다시 유지하기 위해 메인 애플리케이션이 호출한다.
     *
     * @param mainApp
     */
    public void setMainApp(MainApp mainApp) {
        this.mainApp = mainApp;

        // 테이블에 observable 리스트 데이터를 추가한다.
        _personTable.setItems(mainApp.getPersonData());
    }
    
    /**
     * 연락처의 자세한 정보를 보여주기 위해 모든 텍스트 필드를 채운다.
     * 만일 person이 null이면 모든 텍스트 필드가 지워진다.
     * 
     * @param person
     * 
     */
    private void showPersonDetails(Person person) {
    	if(person != null) {
    		//person 객체로 label에 정보를 채운다.
    		_firstNameLabel.setText(person.getFirstName());
    		_lastNameLabel.setText(person.getLastName());
    		_streetLabel.setText(person.getStreet());
    		_postalCodeLabel.setText(Integer.toString(person.getPostalCode()));
    		_cityLabel.setText(person.getCity());
    		_birthdayLable.setText(DateUtil.format(person.getBirthday()));
    	} else {
    		//person이 null이면 텍스트를 지운다.
    		_firstNameLabel.setText("");
    		_lastNameLabel.setText("");
    		_streetLabel.setText("");
    		_postalCodeLabel.setText("");
    		_cityLabel.setText("");
    		_birthdayLable.setText("");
    	}
    }
    
    /**
     * 삭제버튼
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
     * 사용자가 new 버튼을 클릭할 때 호출된다.
     * 새로운 연락처 정보를 넣기 위해 다이얼로그를 연다.
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
     * 사용자가 edit 버튼을 클릭할 때 호출된다.
     * 선택한 연락처 정보를 변경하기 위해 다이얼로그를 연다.
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
            // 아무것도 선택하지 않았다.
            Alert alert = new Alert(AlertType.WARNING);
            alert.initOwner(mainApp.getPrimaryStage());
            alert.setTitle("No Selection");
            alert.setHeaderText("No Person Selected");
            alert.setContentText("Please select a person in the table.");

            alert.showAndWait();
        }
    }
    
}
