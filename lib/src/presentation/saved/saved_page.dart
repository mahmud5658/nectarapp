import 'package:flutter/material.dart';

import '../../infrastructure/enums/page_name.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShopProvider.of(context, listen: false).onTabChange(PageName.favorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuilding _SavedPageState ");
    return const CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(bottom: 16, left: 24, right: 24),
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: LabelView(label: "Favorite"),
              ),
            ),
          ),
        ),
        ProductsStreamSliverList()
      ],
    );
  }
}
