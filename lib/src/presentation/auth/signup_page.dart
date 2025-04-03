import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/widgets/app_text_field.dart';
import 'widgets/signin_option_view.dart';

import 'widgets/background_auth_wrapper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Create an account now",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppTextField(
            hint: "Name",
            icon: Icon(Icons.person),
          ),
          gap,
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email_outlined),
          ),
          gap,
          const AppTextField(
            hint: "Password",
            obscureText: true,
            icon: Icon(Icons.lock),
          ),
          gap,
          const AppTextField(
            hint: "Confirm Password",
            obscureText: true,
            icon: Icon(Icons.lock),
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
                  context.push(AppRoute.otp);
                },
                child: const Text("Sign Up"),
              ),
            ),
          ),
          gap,
          const _AlreadyHaveAnAccountView(),
          gap,
        ],
      ),
    );
  }
}

class _AlreadyHaveAnAccountView extends StatelessWidget {
  const _AlreadyHaveAnAccountView();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        InkWell(
          onTap: () {
            context.pushReplacement(AppRoute.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 4, right: 8, top: 8, bottom: 8),
            child: Text(
              "Login",
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
