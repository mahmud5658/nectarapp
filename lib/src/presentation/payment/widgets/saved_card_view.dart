import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../infrastructure/models/user_payment_method.dart';

class UserSavedItemView extends StatelessWidget {
  const UserSavedItemView({
    super.key,
    required this.info,
    required this.isSelected,
    this.onTap,
  });

  final UserPaymentMethod info;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected //
              ? AppTheme.primary.withAlpha(75)
              : const Color(0xFFF2ECEC),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(info.type.title),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        info.type.image,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(info.cardNo),
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: isSelected ? AppTheme.primary : Colors.transparent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
