import 'package:flutter/material.dart';

import '../../../app/route_config.dart';
import '../../../infrastructure/infrastructure.dart';
import 'cart_item_view.dart';

class CartStreamSliverList extends StatelessWidget {
  const CartStreamSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductState>(
      stream: ShopProvider.of(context).stream,
      builder: (context, snapshot) {
        debugPrint("refetching the stream  CartStreamSliverList ${snapshot.connectionState}");
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const SliverToBoxAdapter(
            child: Center(),
          );
        }
        final pState = snapshot.data ?? ProductState.none;

        if (pState.filterData.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text("No product found")),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList.separated(
            itemCount: pState.filterData.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ItemCartView(
                model: pState.filterData[index],
                onTap: () async {
                  final repo = ShopProvider.of(context);
                  await context.push(AppRoute.productDetails, extra: {
                    "product": pState.filterData[index],
                    "repo": repo,
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
