package org.example.hotelmanagement;

public class User {
    public String username;
    public String fullname;
    public String password;

    public User() {}
    public User(String username, String fullname, String password) {
        this.username = username;
        this.fullname = fullname;
        this.password = password;
    }
}