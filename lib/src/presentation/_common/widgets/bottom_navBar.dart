import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';
import '../../../app/route_config.dart';
import '../../../infrastructure/enums/page_name.dart';
import '../../../infrastructure/infrastructure.dart';

import '../../home/widgets/user_profile_header_view.dart';
import 'background_view.dart';

class AppBottomNavbar extends StatefulWidget {
  const AppBottomNavbar({
    super.key,
    required this.child,
    required this.model,
  });
  final Widget child;
  final UserModel model;

  @override
  State<AppBottomNavbar> createState() => _AppBottomNavbarState();
}

class _AppBottomNavbarState extends State<AppBottomNavbar> {
  int currentIndex = 0;

  void onTap(int index) {
    currentIndex = index;
    setState(() {});
    if (index == 0) {
      context.go(AppRoute.home);
    } else if (index == 1) {
      context.go(AppRoute.search);
    } else if (index == 2) {
      context.go(AppRoute.saved);
    } else if (index == 3) {
      context.go(AppRoute.cart);
    } else {
      throw UnimplementedError();
    }
  }

  Future<GroceryShopRepository> load() => GroceryShopRepository.create(widget.model);
  late Future<GroceryShopRepository> future = load();

  @override
  Widget build(BuildContext context) {
    return BackgroundView.triple(
      child: FutureBuilder<GroceryShopRepository>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final repo = snapshot.requireData;
            return ShopProvider(
              repo: repo,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (i) {
                    if (i == 0) repo.onTabChange(PageName.values.elementAt(i));

                    onTap(i);
                  },
                  currentIndex: currentIndex,
                  selectedItemColor: AppTheme.primary,
                  unselectedItemColor: AppTheme.borderColor,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: const TextStyle(color: AppTheme.primary),
                  unselectedLabelStyle: const TextStyle(color: AppTheme.background),
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
                    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      if (currentIndex == 0) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          child: UserProfileHeaderView(model: widget.model),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Expanded(
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
