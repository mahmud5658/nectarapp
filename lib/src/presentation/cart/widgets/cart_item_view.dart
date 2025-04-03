import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../app/app_theme.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../_common/widgets/item_counter.dart';

class ItemCartView extends StatelessWidget {
  const ItemCartView({super.key, required this.model, this.onTap});

  final ProductModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(216, 242, 236, 236),
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 16 / 12,
                child: Image.network(
                  model.imageUrl,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) => const Placeholder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        model.type.title,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: RatingBarIndicator(
                          direction: Axis.horizontal,
                          itemSize: 8,
                          itemCount: 5,
                          rating: model.rating,
                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.name,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: "\$${model.price.toStringAsFixed(1)} ",
                      children: [
                        TextSpan(
                          text: model.unit,
                          style: textTheme.bodySmall,
                        )
                      ],
                    ),
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ItemCounter(
                    initialValue: model.orderCounter,
                    onChanged: (v) {
                      ShopProvider.of(context).addToCart(p: model, counter: v);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
