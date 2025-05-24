import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_management/modals/user_model.dart';

class ApiService {
  // Update this with your IP address when testing on a real device
  // For emulator, use 10.0.2.2 instead of localhost
  static const String baseUrl = 'http://192.168.54.7/library_api';

  // Register a new user
  static Future<User> register(
    String fullName,
    String email,
    String phoneNumber,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Successfully created
      final data = jsonDecode(response.body);
      return User(
        fullName: data['full_name'],
        email: data['email'],
        phoneNumber: data['phone_number'],
        password: '', // We don't store password in the app
      );
    } else {
      // Error handling
      final error = jsonDecode(response.body);
      throw Exception(error['message']);
    }
  }

  // Login user
  static Future<User> login(String identifier, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Login successful
      final data = jsonDecode(response.body);
      return User(
        fullName: data['full_name'],
        email: data['email'],
        phoneNumber: data['phone_number'],
        password: '', // We don't store password in the app
      );
    } else {
      // Error handling
      final error = jsonDecode(response.body);
      throw Exception(error['message']);
    }
  }

  // Reset password
  static Future<void> resetPassword(String identifier) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/reset_password.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier}),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message']);
    }
  }
}
