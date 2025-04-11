import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../infrastructure/enums/product_filter.dart';
import '../../../infrastructure/repo/app_repo.dart';

class HomeFilterTabs extends StatefulWidget {
  const HomeFilterTabs({super.key});

  @override
  State<HomeFilterTabs> createState() => _HomeFilterTabsState();
}

class _HomeFilterTabsState extends State<HomeFilterTabs> with AutomaticKeepAliveClientMixin {
  ProductType selectedTab = ProductType.all;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(scrollbars: false, dragDevices: PointerDeviceKind.values.toSet()),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ProductType.values
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    selected: selectedTab == e,
                    label: Text(e.title),
                    onSelected: (value) {
                      selectedTab = e;
                      ShopProvider.of(context).productByType(e);
                      setState(() {});
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
