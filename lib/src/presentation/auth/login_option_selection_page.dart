import 'package:flutter/material.dart';
import '../../app/route_config.dart';
import '../_common/widgets/background_view.dart';

import '../_common/widgets/app_button.dart';

class LoginOptionSelectionPage extends StatelessWidget {
  const LoginOptionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.two(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Grocery shopping has never been this much fun ",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signIn);
                            },
                            label: "Login",
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Don't Have an account",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppButton.large(
                            onTap: () {
                              context.push(AppRoute.signUp);
                            },
                            label: "Sign Up",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/bottom_ve.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
