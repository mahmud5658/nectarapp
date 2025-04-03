import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Welcome back!",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          gap,
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          gap,
          const AppTextField(
            hint: "Password",
            obscureText: true,
            icon: Icon(Icons.lock),
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
                onPressed: () {
                  context.go(AppRoute.home);
                },
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
                  padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
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
    );
  }
}
