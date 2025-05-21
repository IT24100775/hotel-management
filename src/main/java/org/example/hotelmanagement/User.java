package org.example.hotelmanagement;

public class User {
    public String username;
    public String fullname;
    public String password;
    public String email;
    public String phone;

    public User() {}

    public User(String username, String fullname, String password) {
        this.username = username;
        this.fullname = fullname;
        this.password = password;
    }

    public User(String username, String fullname, String password, String email, String phone) {
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.phone = phone;
    }
}
