import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../infrastructure/enums/page_name.dart';
import '../../infrastructure/infrastructure.dart';
import 'widgets/cart_summary_view.dart';

import '../_common/_common.dart';
import 'widgets/mycart_stream_sliver_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Stream<double>? price;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = ShopProvider.of(context);
      provider.onTabChange(PageName.cart);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const LabelView(label: "My Cart"),
                centerTitle: true,
                leading: const SizedBox.shrink(),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.history,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const CartStreamSliverList(),
            ],
          ),
        ),
        StreamBuilder(
          stream: ShopProvider.of(context).totalPrice,
          builder: (context, snapshot) {
            final totalPrice = snapshot.data ?? 0;
            if (totalPrice <= 0) return const SizedBox();
            return CartSummaryView(
              key: ObjectKey(snapshot),
              deliveryPrice: 5,
              totalPrice: totalPrice,
            );
          },
        ),
      ],
    );
  }
}
