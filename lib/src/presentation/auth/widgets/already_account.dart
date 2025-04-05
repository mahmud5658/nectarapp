import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/app_theme.dart';
import 'package:grocery_app/src/app/route_config.dart';

class AlreadyHaveAnAccountView extends StatelessWidget {
  const AlreadyHaveAnAccountView({super.key});

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