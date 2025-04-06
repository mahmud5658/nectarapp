import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/utils/input_validator.dart';
import 'package:grocery_app/src/presentation/auth/auth.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

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
                child: ElevatedButton(
                  onPressed: () {
                    _signUp();
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
      ),
    );
  }

  Future<void> _signUp() async {
    if(_formKey.currentState!.validate()){
      final email = _emailController.text;
    final password = _passwordController.text;

    final response = await Supabase.instance.client.auth
        .signUp(email: email, password: password);

    if (response.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful!')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Failed')),
      );
    }
    }
  }
}
