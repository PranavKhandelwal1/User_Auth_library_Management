import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:library_management/modals/user_model.dart';

class SessionManager {
  static const String _currentUserKey = 'current_user';

  // Save the current logged in user
  static Future<void> saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
  }

  // Get the current logged in user
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_currentUserKey);

    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // Clear the current logged in user (logout)
  static Future<void> clearCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }
}