import 'package:flutter/material.dart';
// Import AuthAPI
import '../services/api/auth_api.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // Uncomment this block when enabling the API
    // try {
    //   final success = await AuthAPI.signUp({'email': email, 'password': password});
    //   if (success) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created successfully')));
    //     Navigator.pop(context); // Return to login screen
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create account')));
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error signing up: $e')));
    // }

    // Current logic without API
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created successfully')));
    Navigator.pop(context); // Return to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
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
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
