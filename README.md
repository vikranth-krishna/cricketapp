# Cricket Player Management App

## Description

The **Cricket Player Management App** is a Flutter-based application designed to help users manage cricket players and their statistics efficiently. It includes features like login, sign-up, searching players, and superadmin-level actions such as adding, editing, updating, and deleting player data. The app currently stores player data locally using SQLite, with provisions for future API integration.

### Key Features:

- **Login**:
  - Users can log in with predefined credentials, database users, or through future API integration (commented code included).
- **Sign Up**:
  - New users can register via an intuitive sign-up interface, with API integration support commented.
- **Player Search**:
  - Quickly search and filter cricket players by their names.
- **Superadmin Actions**:
  - Superadmins can add, edit, update, and delete player records. These actions are currently implemented locally but include commented-out API calls for future integration.
- **Local Database**:
  - Player data is stored locally using SQLite for offline functionality.
- **Player Details**:
  - View detailed information about each player, such as their performance stats, age, and team.

### Technologies Used:

- **Flutter**: Framework for building cross-platform apps.
- **SQLite**: For local database storage.
- **SharedPreferences**: For managing user login sessions.
- **HTTP (future use)**: For API communication (commented code provided for integration).

---

## Installation Instructions

### Prerequisites:

- Install [Flutter](https://flutter.dev/docs/get-started/install) on your machine.
- Use an IDE like **Visual Studio Code** or **Android Studio** with the Flutter plugin installed.

### Steps to Run the App:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/vikranth-krishna/cricketapp.git
   cd cricket-player-management
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the Application**:
   ```bash
   flutter run
   ```

4. **Log In**:
   - **Superadmin**:  
     - Email: `superadmin@super.com`  
     - Password: `super123`
   - **User**:  
     - Email: `user1@super.com`  
     - Password: `user123`
   - **Database Users**:  
     - Register new users via the **Sign Up** screen.

---

## API Integration (Commented Code)

The app includes commented-out code for API integration. These APIs are intended for authentication and player management actions:

### **1. Login API**
**File**: `auth_api.dart`  
**Purpose**: Replace hardcoded/database login with an API.

Example:
```dart
// API call for login
final response = await AuthAPI.login({'email': email, 'password': password});
if (response != null) {
    await prefs.setString('loggedInUser', response['email']);
    await prefs.setString('accessLevel', response['accessLevel']);
}
```

### **2. Sign Up API**
**File**: `auth_api.dart`  
**Purpose**: Replace local sign-up logic with an API.

Example:
```dart
// API call for sign-up
final success = await AuthAPI.signUp({'email': email, 'password': password});
if (success) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created successfully')));
    Navigator.pop(context);
}
```

### **3. Player Management API**
**File**: `player_api.dart`  
**Purpose**: Handle player add, update, and delete operations via API.

Examples:
- **Add Player**:
  ```dart
  final success = await PlayerAPI.addPlayer(player.toJson());
  if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Player added successfully')));
  }
  ```

- **Update Player**:
  ```dart
  final success = await PlayerAPI.updatePlayer(player.id.toString(), player.toJson());
  if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Player updated successfully')));
  }
  ```

- **Delete Player**:
  ```dart
  final success = await PlayerAPI.deletePlayer(player.id.toString());
  if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Player deleted successfully')));
  }
  ```

---

## Future Enhancements

- Replace local authentication and player management with fully API-based implementations.
- Implement secure token-based authentication for better security.
- Synchronize SQLite data with the remote server for offline-first capabilities.
- Enhance player statistics with additional API data, such as match records and performance history.
- Update the live score.
---

