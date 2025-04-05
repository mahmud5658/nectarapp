import 'package:flutter/material.dart';
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
                } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
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
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
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
        SupabaseClient _client = Supabase.instance.client;
        final response = await _client.auth
            .signInWithPassword(email: email, password: password);
        debugPrint('Login Successfull');
        context.pushReplacement(AppRoute.home);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Failed')));
      }
    }
  }
}
