import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../app/app_theme.dart';
import '../../../infrastructure/infrastructure.dart';
import 'delivery_duration_view.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.model,
  });
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          model.name,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            RatingBarIndicator(
              direction: Axis.horizontal,
              itemSize: 16,
              itemCount: 5,
              rating: model.rating,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            ),
            const Spacer(),
            Text(
              _getKFormat(model.reviewCounter),
              style: const TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(" reviews"),
          ],
        ),
        const SizedBox(height: 24),
        Text(model.description),
        const SizedBox(height: 24),
        DeliveryDurationView(deliveryTime: model.deliveryTime),
      ],
    );
  }
}

String _getKFormat(int value) {
  if (value > 999) {
    return "${(value / 1000).toStringAsFixed(1)}k";
  } else {
    return "$value";
  }
}
