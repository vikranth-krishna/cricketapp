class User {
  final int? id; // Optional (used for database users only)
  final String email;
  final String password;

  User({this.id, required this.email, required this.password});

  // Convert a User object to a Map for SQLite operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}