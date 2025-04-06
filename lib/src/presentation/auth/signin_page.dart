import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text("Login"),
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
                      "SignUp",
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
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      try {
        final response = await Supabase.instance.client.auth
            .signInWithPassword(email: email, password: password);

        if (response.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );
          debugPrint('Successfully');
          context.push(AppRoute.home);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Login failed! Please check your credentials.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
}
