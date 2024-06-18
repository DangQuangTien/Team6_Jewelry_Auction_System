/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author T14
 */
public class RegisterError {

    private String firstNameError;
    private String emailError;
    private String lastNameError;
    private String usernameError;
    private String passwordError;
    private String error;

    public RegisterError() {
        this.firstNameError = "";
        this.emailError = "";
        this.lastNameError = "";
        this.usernameError = "";
        this.passwordError = "";
        this.error="";
    }
    
    public RegisterError(String firstNameError, String emailError, String lastNameError, String usernameError, String passwordError, String error) {
        this.firstNameError = firstNameError;
        this.emailError = emailError;
        this.lastNameError = lastNameError;
        this.usernameError = usernameError;
        this.passwordError = passwordError;
        this.error = error;
    }
    

    public String getFirstNameError() {
        return firstNameError;
    }

    public void setFirstNameError(String firstNameError) {
        this.firstNameError = firstNameError;
    }

    public String getEmailError() {
        return emailError;
    }

    public void setEmailError(String emailError) {
        this.emailError = emailError;
    }

    public String getLastNameError() {
        return lastNameError;
    }

    public void setLastNameError(String lastNameError) {
        this.lastNameError = lastNameError;
    }

    public String getUsernameError() {
        return usernameError;
    }

    public void setUsernameError(String usernameError) {
        this.usernameError = usernameError;
    }

    public String getPasswordError() {
        return passwordError;
    }

    public void setPasswordError(String passwordError) {
        this.passwordError = passwordError;
    }
    
    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}