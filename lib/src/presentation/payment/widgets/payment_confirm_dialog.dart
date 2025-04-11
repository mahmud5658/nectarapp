import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';
import '../../_common/widgets/app_button.dart';

class PaymentConfirmDialog extends StatelessWidget {
  const PaymentConfirmDialog._({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const PaymentConfirmDialog._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: AspectRatio(
          aspectRatio: 1 / 1.3,
          child: Material(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.primary,
                  size: 135,
                ),
                const SizedBox(height: 24),
                Text(
                  "Payment Done",
                  style: textStyle?.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Successfully",
                  style: textStyle,
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: "Close",
                  onTap: Navigator.of(context).pop,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
