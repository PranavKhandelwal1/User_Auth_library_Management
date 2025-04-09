import 'package:flutter/material.dart';
import 'package:library_management/screens/login_screen.dart';
import 'package:library_management/screens/home_sceen.dart';
import 'package:library_management/constants/app_theme.dart';
import 'package:library_management/services/session_manager.dart';

import 'modals/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library Management',
      theme: AppTheme.getTheme(),
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final user = await SessionManager.getCurrentUser();
    setState(() {
      _isLoggedIn = user != null;
      if (user != null) {
        _userData = user.toJson();
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_isLoggedIn && _userData != null) {
      return HomeScreen(user: User.fromJson(_userData!));
    }

    return const LoginScreen();
  }
}
