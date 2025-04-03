import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../_common.dart';
import '../../../app/app_theme.dart';
import '../../../infrastructure/infrastructure.dart';

class ItemCardView extends StatelessWidget {
  const ItemCardView({
    super.key,
    required this.model,
    required this.onTap,
  });

  final ProductModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.cardColor,
      ),
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      model.imageUrl,
                      fit: BoxFit.fitHeight, //use cover
                      errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        ShopProvider.of(context).toggleSaveProduct(model);
                      },
                      icon: Icon(
                        model.isSaved ? Icons.favorite : Icons.favorite_border_outlined,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  model.type.title,
                  style: const TextStyle(color: AppTheme.primary),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RatingBarIndicator(
                      direction: Axis.horizontal,
                      itemSize: 12,
                      itemCount: 5,
                      rating: model.rating,
                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    ),
                  ),
                )
              ],
            ),
            Text(
              model.name,
              style: textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "\$${model.price.toStringAsFixed(1)}",
                    children: [
                      TextSpan(
                        text: " per kg", //model.unit
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Material(
                  shape: const CircleBorder(),
                  color: AppTheme.primary,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      ShopProvider.of(context).addToCart(
                        p: model,
                        counter: 1,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
