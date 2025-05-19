
package controllers;

import models.User;
import services.UserService;

import java.util.HashMap;
import java.util.Map;

public class UserController {
    private final UserService userService;

    public UserController() {
        this.userService = new UserService();
    }

    public User getUserById(String id) {
        return userService.getUserById(id);
    }

    public Map<String, Object> login(Map<String, String> credentials) {
        String email = credentials.get("email");
        String password = credentials.get("password");
        
        User user = userService.login(email, password);
        
        Map<String, Object> response = new HashMap<>();
        if (user != null) {
            response.put("success", true);
            response.put("user", user);
        } else {
            response.put("success", false);
            response.put("message", "Invalid credentials");
        }
        
        return response;
    }

    public Map<String, Object> register(Map<String, String> userData) {
        String name = userData.get("name");
        String email = userData.get("email");
        String password = userData.get("password");
        
        User user = userService.registerUser(name, email, password);
        
        Map<String, Object> response = new HashMap<>();
        if (user != null) {
            response.put("success", true);
            response.put("user", user);
        } else {
            response.put("success", false);
            response.put("message", "Registration failed");
        }
        
        return response;
    }
}
