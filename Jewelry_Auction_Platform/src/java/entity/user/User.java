/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.user;

import java.sql.Date;

/**
 *
 * @author T14
 */
public class User {
    private String userID;
    private String username;
    private String email;
    private String password;
    private String roleID;
    private Date joined_at;
    private int active_status;

    public User() {
        
    }

    public User(String userID, String username, String email, String password, String roleID, Date joined_at, int active_status) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.password = password;
        this.roleID = roleID;
        this.joined_at = joined_at;
        this.active_status = active_status;
    }
    
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public Date getJoined_at() {
        return joined_at;
    }

    public void setJoined_at(Date joined_at) {
        this.joined_at = joined_at;
    }
    
    public int getActive_status() {
        return active_status;
    }

    public void setActive_status(int active_status) {
        this.active_status = active_status;
    }
}
