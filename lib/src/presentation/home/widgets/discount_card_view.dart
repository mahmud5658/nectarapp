import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';
import '../../_common/widgets/app_button.dart';

class DiscountCardView extends StatelessWidget {
  const DiscountCardView({
    super.key,
    required this.discount,
    this.onTap,
  });

  final int discount;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final color = Color(0x18F1EEEE);

    return AspectRatio(
      aspectRatio: 16 / 8,
      child: Container(
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromARGB(73, 127, 120, 120),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Flat $discount% off",
                      style: textTheme.bodyLarge?.copyWith(color: AppTheme.primary),
                    ),
                    Text(
                      "Discount",
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "on first order",
                      style: textTheme.bodyLarge?.copyWith(),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          fixedSize: const Size.fromHeight(40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("View Offer"),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -20,
                top: -32,
                bottom: 0,
                child: Image.asset(
                  "assets/images/basket_full_vegetables_photoroom.png",
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
