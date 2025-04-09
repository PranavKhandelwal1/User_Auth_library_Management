import 'dart:convert';
import 'package:library_management/modals/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const String _usersKey = 'users';

  static Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    return usersJson
        .map((userJson) => User.fromJson(jsonDecode(userJson)))
        .toList();
  }

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();

    // Check if email or phone number already exists
    final emailExists = users.any((u) => u.email == user.email);
    if (emailExists) {
      throw Exception('Email already exists');
    }

    final phoneExists = users.any((u) => u.phoneNumber == user.phoneNumber);
    if (phoneExists) {
      throw Exception('Phone number already exists');
    }

    users.add(user);
    await prefs.setStringList(
      _usersKey,
      users.map((user) => jsonEncode(user.toJson())).toList(),
    );
  }

  static Future<User?> findUserByEmailOrPhone(
      String identifier,
      String password,
      ) async {
    final users = await getUsers();
    try {
      return users.firstWhere(
            (user) =>
        (user.email == identifier || user.phoneNumber == identifier) &&
            user.password == password,
      );
    } catch (e) {
      throw Exception('Invalid credentials or user not exist!');
    }
  }

  static Future<User?> findUserByEmail(String email) async {
    final users = await getUsers();
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  static Future<User?> findUserByPhone(String phone) async {
    final users = await getUsers();
    try {
      return users.firstWhere((user) => user.phoneNumber == phone);
    } catch (e) {
      return null;
    }
  }
}