import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_helper.dart';
import '../models/user.dart';
import './home_screen.dart';
import './sign_up_screen.dart';
// Import AuthAPI
import '../services/api/auth_api.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Uncomment to enable API-based login
    // try {
    //   final response = await AuthAPI.login(email, password);
    //   if (response['status'] == 'success') {
    //     final userType = response['userType'];
    //     await prefs.setString('loggedInUser', email);
    //     await prefs.setString('accessLevel', userType);

    //     Navigator.pushReplacement(context, MaterialPageRoute(
    //       builder: (_) => HomeScreen(userType: userType),
    //     ));
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid email or password')));
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error logging in: $e')));
    // }

    // Current logic without API
    if ((email == "superadmin@super.com" && password == "super123") ||
        (email == "user1@super.com" && password == "user123")) {
      await prefs.setString('loggedInUser', email);
      await prefs.setString('accessLevel', email == "superadmin@super.com" ? "superadmin" : "user");

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => HomeScreen(userType: email == "superadmin@super.com" ? "Super Admin" : "User"),
      ));
    } else {
      final user = await _dbHelper.getUser(email, password);
      if (user != null) {
        await prefs.setString('loggedInUser', email);
        await prefs.setString('accessLevel', "user");

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => HomeScreen(userType: "Database User"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid email or password')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
              },
              child: Text('Create an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
