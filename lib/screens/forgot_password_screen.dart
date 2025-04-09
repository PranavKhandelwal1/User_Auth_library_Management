import 'package:flutter/material.dart';
import 'package:library_management/components/custom_button.dart';
import 'package:library_management/components/custom_input_field.dart';
import 'package:library_management/constants/app_colors.dart';
import 'package:library_management/services/auth_service.dart';
import 'package:library_management/utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  bool _isLoading = false;
  bool _isEmailSelected = true;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }
  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await AuthService.resetPassword(_emailOrPhoneController.text.trim());

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Reset link sent to your ${_isEmailSelected ? 'email' : 'phone number'}',
              ),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: AppColors.error,
            ),
          );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Forgot your password?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'No worries! Enter your email address or phone number below, and we\'ll send you a link to reset your password.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  _buildTabSelector(),
                  const SizedBox(height: 24),
                  CustomInputField(
                    controller: _emailOrPhoneController,
                    hintText: _isEmailSelected ? 'Email address' : 'Phone number',
                    prefixIcon: _isEmailSelected ? Icons.email : Icons.phone,
                    keyboardType: _isEmailSelected
                        ? TextInputType.emailAddress
                        : TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      if (_isEmailSelected) {
                        return Validators.validateEmail(value);
                      } else {
                        return Validators.validatePhoneNumber(value);
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'SEND RESET LINK',
                    onPressed: _resetPassword,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back to login'),
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

  Widget _buildTabSelector() {
    return Row(
      children: [
        Expanded(
          child: _TabOption(
            title: 'Email',
            isSelected: _isEmailSelected,
            onTap: () {
              setState(() {
                _isEmailSelected = true;
              });
            },
          ),
        ),
        Expanded(
          child: _TabOption(
            title: 'Phone',
            isSelected: !_isEmailSelected,
            onTap: () {
              setState(() {
                _isEmailSelected = false;
              });
            },
          ),
        ),
      ],
    );
  }
}

class _TabOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
        ),
      ),
    );
  }
}