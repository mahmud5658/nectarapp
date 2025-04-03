import 'package:flutter/material.dart';

import '../../../app/route_config.dart';
import '../../../infrastructure/enums/page_name.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../_common/widgets/app_button.dart';

class CartSummaryView extends StatelessWidget {
  const CartSummaryView({
    super.key,
    required this.deliveryPrice,
    required this.totalPrice,
  });

  final double totalPrice;
  final double deliveryPrice;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget _buildPriceRow(String title, double value) {
      final textStyle = textTheme.bodyMedium
          ?.copyWith(fontWeight: title.toLowerCase().endsWith("total") ? FontWeight.bold : FontWeight.w400);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Text(
            "\$${value.toStringAsFixed(1)}",
            style: textStyle,
          )
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPriceRow("Total price", totalPrice),
          const SizedBox(height: 8),
          _buildPriceRow("Delivery fee", deliveryPrice),
          const SizedBox(height: 8),
          _buildPriceRow("Total", totalPrice + deliveryPrice),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: "Confirm Order",
              onTap: () async {
                await context.push(
                  AppRoute.payment,
                  extra: totalPrice + deliveryPrice,
                );
                if (context.mounted == false) return;
                ShopProvider.of(context).onTabChange(PageName.home);
                context.go(AppRoute.home);
              },
            ),
          )
        ],
      ),
    );
  }
}
