import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import 'package:pinput/pinput.dart';

import '../_common/widgets/app_button.dart';
import 'auth.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 24);
    return AuthBackGroundWrapper(
      title: "Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Enter your verification code here! that we have sent you.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Pinput(
            defaultPinTheme: PinTheme(
              height: 48,
              width: 48,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primary, width: .75),
              ),
              textStyle: const TextStyle(color: AppTheme.primary),
            ),
            validator: (s) {
              return null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: AppButton.large(
              onTap: () {
                context.push(AppRoute.newPassword);
              },
              label: "Verify",
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
