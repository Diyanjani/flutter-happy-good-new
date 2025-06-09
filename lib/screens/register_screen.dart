import 'package:flutter/material.dart';
import '../widgets/form_input_field.dart';
import '../constants/text_styles.dart';
import 'products_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(selectedCategory: 'Vegetables'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Register', style: TextStyles.heading(context)),
              const SizedBox(height: 20),
              FormInputField(
                controller: _nameController,
                hintText: 'Full Name',
              ),
              const SizedBox(height: 12),
              FormInputField(controller: _emailController, hintText: 'Email'),
              const SizedBox(height: 12),
              FormInputField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
