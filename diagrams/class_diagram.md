# Hotel Reservation System Admin Module - Class Diagram (Simplified)

This class diagram represents the simplified structure of the Hotel Reservation System Admin Module, showing the key classes and their relationships after removing role-based admin types.

## Diagram Overview

The system is built with these main components:

1. **Model Layer**
   - `User` (Abstract): Base class for all user types
   - `AdminUser`: Core admin user class with full permissions

2. **Data Access Layer**
   - `AdminDAO`: Handles all data operations with text files

3. **Controller Layer**
   - `AdminServlet`: Main controller for handling all admin-related HTTP requests

4. **Utility Layer**
   - `AdminInitializer`: Sets up initial data on application startup
   - `AdminSetup`: Handles system setup operations

## Key Relationships

- `AdminUser` inherits from the abstract `User` class
- `AdminServlet` uses `AdminDAO` to perform data operations
- `AdminServlet` manages `AdminUser` objects
- `AdminDAO` creates, reads, updates, and deletes `AdminUser` objects
- Utility classes use `AdminDAO` for system setup and initialization

## PlantUML Code

To visualize this diagram, copy the following PlantUML code to a PlantUML editor:

```plantuml
@startuml
' Class Diagram for Hotel Reservation System Admin Module

' MODELS
abstract class User {
  - username: String
  - password: String
  - email: String
  - lastLoggedIn: LocalDateTime
  + getUsername(): String
  + setUsername(username: String): void
  + getPassword(): String
  + setPassword(password: String): void
  + getEmail(): String
  + setEmail(email: String): void
  + getLastLoggedIn(): LocalDateTime
  + setLastLoggedIn(time: LocalDateTime): void
  + {abstract} getUserType(): String
  + {abstract} hasPermission(feature: String): boolean
}

class AdminUser extends User {
  - id: int
  - contactNumber: String
  - lastActionTime: LocalDateTime
  - createdBy: String
  - createdAt: LocalDateTime
  - updatedBy: String
  - updatedAt: LocalDateTime
  
  + AdminUser()
  + AdminUser(username, password, email)
  + getContactNumber(): String
  + setContactNumber(contactNumber: String): void
  + getLastActionTime(): LocalDateTime
  + updateLastActionTime(): void
  + getUserType(): String
  + hasPermission(feature: String): boolean
  + logAction(action: String): String
  + toString(): String
  + toCsvString(): String
  + static fromCsvString(csv: String): AdminUser
}

' DATA ACCESS OBJECTS
class AdminDAO {
  - ADMIN_FILE: String
  - ADMIN_LOG_FILE: String
  
  + AdminDAO()
  - createFileIfNotExists(filename: String): void
  + getAllAdmins(): List<AdminUser>
  + getAdminByUsername(username: String): AdminUser
  + validateCredentials(username: String, password: String): AdminUser
  + createAdmin(admin: AdminUser): boolean
  + updateAdmin(admin: AdminUser): boolean
  + deleteAdmin(username: String): boolean
  - writeAllAdmins(admins: List<AdminUser>): boolean
  + logAdminActivity(admin: AdminUser, action: String): void
  + getAdminLogs(): List<String>
}

' SERVLETS/CONTROLLERS
class AdminServlet {
  - adminDAO: AdminDAO
  
  + doGet(request: HttpServletRequest, response: HttpServletResponse): void
  + doPost(request: HttpServletRequest, response: HttpServletResponse): void
  - handleLogin(request: HttpServletRequest, response: HttpServletResponse): void
  - handleDashboard(request: HttpServletRequest, response: HttpServletResponse): void
  - handleLogout(request: HttpServletRequest, response: HttpServletResponse): void
  - handleAdminRequests(request: HttpServletRequest, response: HttpServletResponse): void
  - handleCreateAdmin(request: HttpServletRequest, response: HttpServletResponse, currentAdmin: AdminUser): void
  - handleUpdateAdmin(request: HttpServletRequest, response: HttpServletResponse, currentAdmin: AdminUser): void
  - handleDeleteAdmin(request: HttpServletRequest, response: HttpServletResponse, currentAdmin: AdminUser): void
  - isLoggedIn(request: HttpServletRequest): boolean
  - getCurrentAdmin(request: HttpServletRequest): AdminUser
}

' UTILITIES
class AdminInitializer {
  - adminDAO: AdminDAO
  
  + contextInitialized(event: ServletContextEvent): void
  + contextDestroyed(event: ServletContextEvent): void
  - initializeDefaultAdmin(): void
}

class AdminSetup {
  - adminDAO: AdminDAO
  
  + initialize(): void
  + createDefaultAdmin(): void
  + setupDirectories(): void
  + cleanupData(): void
}

' RELATIONSHIPS
AdminServlet --> AdminDAO : uses
AdminServlet --> AdminUser : manages
AdminDAO ..> AdminUser : creates/reads/updates/deletes
AdminInitializer --> AdminDAO : uses
AdminSetup --> AdminDAO : uses

@enduml
```

## Design Patterns Used

1. **MVC Pattern**: Separation of Models, Views (JSP files), and Controllers (Servlets)
2. **DAO Pattern**: Data Access Object for separating data access logic
3. **Singleton Pattern**: For the AdminDAO class instance
4. **Template Method**: Abstract methods in the User class implemented by subclasses

## System Responsibilities

- **User Authentication**: Login, logout, session management
- **Admin Management**: CRUD operations for admin users
- **Activity Logging**: Tracking admin actions
- **System Configuration**: Setup and initialization 