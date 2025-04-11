import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app_theme.dart';
import '../../../app/route_config.dart';

class AddPaymentButton extends StatelessWidget {
  const AddPaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );
    return InkWell(
      onTap: () {
        context.push(AppRoute.createPayment);
      },
      child: Material(
        color: AppTheme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SizedBox(
            child: Row(
              children: [
                const Icon(Icons.add),
                const SizedBox(width: 24),
                Text(
                  "Add New Card",
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
