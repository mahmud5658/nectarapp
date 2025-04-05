import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/app/route_config.dart';
import 'package:grocery_app/src/presentation/auth/widgets/already_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../_common/widgets/app_text_field.dart';
import 'widgets/signin_option_view.dart';
import 'widgets/background_auth_wrapper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _nameController,
            hint: "Name",
            icon: const Icon(Icons.person),
          ),
          gap,
          AppTextField(
            controller: _emailController,
            hint: "Email",
            icon: const Icon(Icons.email_outlined),
          ),
          gap,
          AppTextField(
            controller: _passwordController,
            hint: "Password",
            obscureText: true,
            icon: const Icon(Icons.lock),
          ),
          gap,
          AppTextField(
            controller: _cPasswordController,
            hint: "Confirm Password",
            obscureText: true,
            icon: const Icon(Icons.lock),
          ),
          gap,
          const SingInOptionView(),
          gap,
          gap,
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _signUp(_emailController.text, _passwordController.text);
                  // context.push(AppRoute.otp);
                },
                child: const Text("Sign Up"),
              ),
            ),
          ),
          gap,
          const AlreadyHaveAnAccountView(),
          gap,
        ],
      ),
    );
  }

  void _signUp(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
          data: {"Name": _nameController.text});
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text('Sign Up Successful')));
        debugPrint('LoggedIn');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black, content: Text('Error')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black, content: Text("error")));
    }
  }
}
