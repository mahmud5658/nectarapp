import 'package:flutter/material.dart';

import '../../infrastructure/infrastructure.dart';
import '../_common/widgets/products_stream_sliver_list.dart';
import 'widgets/discount_card_view.dart';
import 'widgets/home_filter_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShopProvider.of(context).fetchItem(const ProductParam());
    });
    debugPrint("on init");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: 24),
              DiscountCardView(
                discount: 50,
                onTap: () async {},
              ),
              const SizedBox(height: 24),
              const HomeFilterTabs(),
              const SizedBox(height: 24),
            ],
          ),
        ),
        const ProductsStreamSliverList()
      ],
    );
  }
}
