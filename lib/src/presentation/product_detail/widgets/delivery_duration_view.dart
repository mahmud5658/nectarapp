import 'package:flutter/material.dart';

class DeliveryDurationView extends StatelessWidget {
  const DeliveryDurationView({
    super.key,
    required this.deliveryTime,
  });
  final String deliveryTime;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.timer_outlined),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Delivery time",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(deliveryTime),
            ],
          ),
        ),
      ],
    );
  }
}
