import 'package:flutter/material.dart';
import '../_common/widgets/label_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: LabelView(label: "Search")),
          ],
        ),
      ),
    );
  }
}
