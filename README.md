# Hotel Reservation System - Admin Module

This module handles administrative user management for the Hotel Reservation System (HRS).

## Directory Structure

The application follows a structured organization for better maintainability:

```
src/main/java/org/example/
│
├── model/            # Data models
│   └── Admin.java
│
├── dao/              # Data Access Objects
│   └── AdminDAO.java
│
└── servlet/          # Servlets handling HTTP requests
    └── AdminServlet.java
```

## Admin Management Features

The Admin module provides the following functionality:

### CRUD Operations:
- **Create**: Register a new admin account, stored in admins.txt
- **Read**: View a list of all admins and their activity logs
- **Update**: Modify existing admin accounts and their privilege levels
- **Delete**: Remove admin accounts from the system

### Privilege Levels:
- **Super Admin**: Has full access to all system features
- **Regular Admin**: Has access to most system features
- **Read-Only Admin**: Can view information but cannot make changes

### Admin Activity Logging:
- All admin actions are logged to admin_logs.txt with timestamp, username, and action details
- Logs can be viewed from the Admin Logs page

## Data Storage

Admin data is stored in text files:
- `admins.txt`: Stores admin accounts (username, password, privilege level, last login time)
- `admin_logs.txt`: Stores admin activity logs (timestamp, username, action)

## UI Structure

The Admin module includes the following pages:
- Admin Dashboard: Overview of the system
- Admin Management: List of all admins with options to create, edit, and delete
- Admin Logs: Activity log showing all admin actions in the system
- Admin Form: Form for creating and editing admin accounts 
