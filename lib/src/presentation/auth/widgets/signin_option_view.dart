import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class SingInOptionView extends StatelessWidget {
  const SingInOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Icons.facebook,
            Icons.g_mobiledata,
            Icons.inbox,
          ]
              .map(
                (e) => Card(
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5C5C5C),
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {},
                    icon: Icon(e),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
