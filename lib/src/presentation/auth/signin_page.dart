import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
import 'package:grocery_app/src/service/firebase_auth.dart';
import 'package:grocery_app/src/service/shared_pref.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);

    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gap,
            AppTextField(
              controller: _emailController,
              hint: "Email",
              icon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            gap,
            AppTextField(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
              icon: const Icon(Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (!InputValidator.isValidPassword(value)) {
                  return 'Enter a valid password';
                }
                return null;
              },
            ),
            gap,
            TextButton(
              onPressed: () {
                context.push(AppRoute.resetPassword);
              },
              child: const Text("Forgot password?"),
            ),
            gap,
            const SingInOptionView(),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: .75,
              child: SizedBox(
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign In"),
                      ),
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoute.signUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            gap,
          ],
        ),
      ),
    );
  }

  void _login() async {
  final _authService = FirebaseAuthService();
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final error = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sign in failed'),
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        final userEmail = user.email;
        final userName = await _fetchUserNameFromFirestore(user.uid);
        if (userEmail != null) {
          await SharedPrefService.setUserEmail(userEmail);
        }
        if (userName != null) {
          await SharedPrefService.setUserName(userName);
        }
        await SharedPrefService.setLoginStatus(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully!')),
        );
        context.pushReplacement(AppRoute.home);
      }
    }
  }
}
Future<String?> _fetchUserNameFromFirestore(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['name'];
    }
  } catch (e) {
    print("Error fetching user name: $e");
  }
  return null;
}
  
}
