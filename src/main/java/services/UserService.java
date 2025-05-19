
package services;

import models.User;
import java.util.HashMap;
import java.util.Map;

public class UserService {
    private Map<String, User> users;

    public UserService() {
        users = new HashMap<>();
        // Initialize with a default user
        User defaultUser = new User(
            "user-1", 
            "John Smith", 
            "john@example.com", 
            "https://i.pravatar.cc/150?img=68"
        );
        users.put(defaultUser.getId(), defaultUser);
    }

    public User getUserById(String id) {
        return users.get(id);
    }

    public User login(String email, String password) {
        // Simple authentication - in a real application, check credentials properly
        for (User user : users.values()) {
            if (user.getEmail().equals(email)) {
                return user;
            }
        }
        return null;
    }

    public User registerUser(String name, String email, String password) {
        // In a real app, check if email exists and hash the password
        String id = "user-" + (users.size() + 1);
        User newUser = new User(
            id,
            name,
            email,
            "https://i.pravatar.cc/150?img=" + (Math.random() * 70)
        );
        users.put(id, newUser);
        return newUser;
    }
}
