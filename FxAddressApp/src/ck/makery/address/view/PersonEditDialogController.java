package ck.makery.address.view;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import ck.makery.address.model.Person;
import sonang.utils.date.DateUtil;

public class PersonEditDialogController {
	@FXML
	private TextField _firstNameField;
	@FXML
	private TextField _lastNameField;
	@FXML
	private TextField _streetField;
	@FXML
	private TextField _postalCodeField;
	@FXML
	private TextField _cityField;
	@FXML
	private TextField _birthdayField;
	
	private Stage _dialogStage;
	private Person _person;
	private boolean _okClicked = false;
	
	/**
	 * controller class �ʱ�ȭ
	 * fxml ������ �ε�� �� �ڵ����� ȣ���
	 */
	@FXML
	private void initialize() {
		
	}
	
	/**
	 * ���̾�α��� �������� ����
	 * @param dialogStage
	 */
	public void setDialogStage(Stage dialogStage) {
		this._dialogStage = dialogStage;
	}
	
	public void setPerson(Person person) {
		this._person = person;
		_firstNameField.setText(_person.getFirstName());
		_lastNameField.setText(_person.getLastName());
		_streetField.setText(_person.getStreet());
		_postalCodeField.setText(Integer.toString(_person.getPostalCode()));
		_cityField.setText(_person.getCity());
		_birthdayField.setText(DateUtil.format(_person.getBirthday()));
		_birthdayField.setPromptText("yyyy.MM.dd");
	}
	
	/**
     * ����ڰ� OK�� Ŭ���ϸ� true��, �� �ܿ��� false�� ��ȯ�Ѵ�.
     *
     * @return
     */
    public boolean isOkClicked() {
        return _okClicked;
    }
    
    /**
     * ����ڰ� OK�� Ŭ���ϸ� ȣ��ȴ�.
     */
    @FXML
    private void handleOk() {
    	if(isInputValid()) {
    		_person.setFirstName(_firstNameField.getText());
    		_person.setLastName(_lastNameField.getText());
    		_person.setStreet(_streetField.getText());
    		_person.setPostalCode(Integer.parseInt(_postalCodeField.getText()));
    		_person.setCity(_cityField.getText());
    		_person.setBirthday(DateUtil.parse(_birthdayField.getText()));
    		
    		_okClicked = true;
    		_dialogStage.close();
    	}
    }
    
    @FXML
    private void handleCancel() {
    	_dialogStage.close();
    }
    
    private boolean isInputValid() {
    	String errorMessage = "";
    	if(_firstNameField.getText() == null || _firstNameField.getText().length() == 0 ) {
    		errorMessage += "No valid first name \n";
    	}
    	if(_lastNameField.getText() == null || _lastNameField.getText().length() == 0 ) {
    		errorMessage += "No valid last name\n";
    	}
    	if (_streetField.getText() == null || _streetField.getText().length() == 0) {
            errorMessage += "No valid street!\n";
        }

        if (_postalCodeField.getText() == null || _postalCodeField.getText().length() == 0) {
            errorMessage += "No valid postal code!\n";
        } else {
            // ���� ��ȣ�� int Ÿ������ ��ȯ�Ѵ�.
            try {
                Integer.parseInt(_postalCodeField.getText());
            } catch (NumberFormatException e) {
                errorMessage += "No valid postal code (must be an integer)!\n";
            }
        }

        if (_cityField.getText() == null || _cityField.getText().length() == 0) {
            errorMessage += "No valid city!\n";
        }

        if (_birthdayField.getText() == null || _birthdayField.getText().length() == 0) {
            errorMessage += "No valid birthday!\n";
        } else {
            if (!DateUtil.validDate(_birthdayField.getText())) {
                errorMessage += "No valid birthday. Use the format dd.mm.yyyy!\n";
            }
        }

        if (errorMessage.length() == 0) {
            return true;
        } else {
            // ���� �޽����� �����ش�.
            Alert alert = new Alert(AlertType.ERROR);
            alert.initOwner(_dialogStage);
            alert.setTitle("Invalid Fields");
            alert.setHeaderText("Please correct invalid fields");
            alert.setContentText(errorMessage);

            alert.showAndWait();

            return false;
        }
    }
}
