import 'package:flutter/material.dart';
import '../../app/route_config.dart';

import '../_common/widgets/app_text_field.dart';
import 'auth.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

 
          const AppTextField(
            hint: "Email",
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 32),
          FractionallySizedBox(
            widthFactor: .75,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.otp);
                },
                child: const Text("Send Code"),
              ),
            ),
          ),
          gap,
        ],
      ),
    );
  }
}
