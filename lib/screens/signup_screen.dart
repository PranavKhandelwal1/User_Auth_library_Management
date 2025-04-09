import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_management/components/custom_button.dart';
import 'package:library_management/components/custom_input_field.dart';
import 'package:library_management/constants/app_colors.dart';
import 'package:library_management/screens/home_sceen.dart';
import 'package:library_management/services/auth_service.dart';
import 'package:library_management/utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // In _SignUpScreenState class inside signup_screen.dart
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await AuthService.register(
          _fullNameController.text.trim(),
          _emailController.text.trim(),
          _phoneController.text.trim(),
          _passwordController.text,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          // Navigate to home screen instead of going back to login
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                (route) => false, // This removes all previous routes
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create\naccount to\nconnect with\nus!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        CustomInputField(
                          controller: _fullNameController,
                          hintText: 'Full Name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) => Validators.validateName(value),
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: _emailController,
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => Validators.validateEmail(value),
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: _phoneController,
                          hintText: 'Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator:
                              (value) => Validators.validatePhoneNumber(value),
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: _passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator:
                              (value) => Validators.validatePassword(value),
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: 'REGISTER',
                          onPressed: _register,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _DividerWithText(
                    text: 'Use other methods',
                    textColor: Colors.white,
                    dividerColor: Colors.white60,
                  ),
                  const SizedBox(height: 24),
                  CustomOutlinedButton(
                    text: 'Continue with Google',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Google Sign-In would be implemented here',
                          ),
                        ),
                      );
                    },
                    icon: Image.network(
                      'https://www.google.com/favicon.ico',
                      height: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: _navigateToLogin,
                      child: const Text(
                        'Already have account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerWithText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color dividerColor;

  const _DividerWithText({
    required this.text,
    this.textColor = Colors.black54,
    this.dividerColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text, style: TextStyle(color: textColor)),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}
