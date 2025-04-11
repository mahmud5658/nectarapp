import 'package:flutter/material.dart';

import '../../app/route_config.dart';
import '../_common/widgets/app_button.dart   ';
import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Reset Password",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const AppTextField(
            hint: "Enter new password",
            icon: Icon(Icons.lock),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          const AppTextField(
            hint: "Confirm password",
            icon: Icon(Icons.lock),
            obscureText: true,
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: AppButton.large(
              label: "Reset Password",
              onTap: () {
                context.push(AppRoute.home);
              },
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
