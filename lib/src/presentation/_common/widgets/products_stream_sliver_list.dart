import 'package:flutter/material.dart';

import '../../../app/route_config.dart';
import '../../../infrastructure/infrastructure.dart';
import 'item_card_view.dart';

class ProductsStreamSliverList extends StatelessWidget {
  const ProductsStreamSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductState>(
      stream: ShopProvider.of(context).stream,
      builder: (context, snapshot) {
        debugPrint("refetching the stream ${snapshot.connectionState}");
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("A"),
            ),
          );
        }
        final pState = snapshot.data ?? ProductState.none;

        if (pState.filterData.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text("No product found")),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: pState.filterData.length,
            itemBuilder: (context, index) {
              return ItemCardView(
                model: pState.filterData[index],
                onTap: () {
                  final repo = ShopProvider.of(context);

                  context.push(AppRoute.productDetails, extra: {
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
