import 'package:library_management/modals/user_model.dart';
import 'package:library_management/services/session_manager.dart';
import 'package:library_management/services/api_service.dart';

class AuthService {
  static Future<User?> login(String identifier, String password) async {
    try {
      // Use API service for MySQL database
      final user = await ApiService.login(identifier, password);

      // Save user session
      await SessionManager.saveCurrentUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> register(String fullName, String email, String phoneNumber, String password) async {
    try {
      // Use API service for MySQL database
      final user = await ApiService.register(fullName, email, phoneNumber, password);

      // Save user session
      await SessionManager.saveCurrentUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword(String identifier) async {
    try {
      await ApiService.resetPassword(identifier);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await SessionManager.clearCurrentUser();
  }
}