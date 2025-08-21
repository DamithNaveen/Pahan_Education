package com.res.model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String email;
    private String password;
    private UserRole role;
    private String name;
    private Timestamp createdAt;

    public User() {}
    
    public User(String email, String password, UserRole role, String name) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.name = name;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getRoleValue() {
        return role != null ? role.getValue() : null;
    }

    public void setRoleFromString(String roleValue) {
        if (roleValue != null && !roleValue.isEmpty()) {
            this.role = UserRole.fromString(roleValue);
        }
    }
}