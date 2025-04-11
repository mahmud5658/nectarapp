import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import '../_common/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
                controller: _nameController,
                hint: "Name",
                icon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  } else if (!InputValidator.isValidName(value)) {
                    return "Enter your valid name";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _emailController,
                hint: "Email",
                icon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  } else if (!InputValidator.isValidEmail(value)) {
                    return "Enter your valid Email";
                  }
                  return null;
                }),
            gap,
            AppTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: true,
                icon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  } else if (!InputValidator.isValidPassword(value)) {
                    return "Enter your valid password";
                  }
                  return null;
                }),
            gap,
            AppTextField(
              controller: _cPasswordController,
              hint: "Confirm Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            gap,
            const SingInOptionView(),
            gap,
            gap,
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
              ),
            ),
            gap,
            const AlreadyHaveAnAccountView(),
            gap,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final _authService = FirebaseAuthService();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final error = await _authService.signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Sign up failed'),
          ),
        );
      } else {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed up successfully!')),
        );
        context.push(AppRoute.signIn);
      }
    }
  }
}
