import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height,
    this.icon,
  });

  factory AppButton.large({
    Key? key,
    required String label,
    VoidCallback? onTap,
    Widget? icon,
  }) {
    return AppButton(
      key: key,
      label: label,
      onTap: onTap,
      height: 56,
      icon: icon,
    );
  }

  final String label;
  final VoidCallback? onTap;

  final double? height;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onTap,
              label: Text(label),
              icon: icon,
              iconAlignment: IconAlignment.end,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(label),
            ),
    );
  }
}
