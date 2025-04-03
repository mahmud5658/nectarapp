import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/src/presentation/about/about_page.dart';

import '../infrastructure/infrastructure.dart';
import '../presentation/_common/widgets/bottom_navBar.dart';
import '../presentation/auth/auth.dart';
import '../presentation/cart/cart_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/payment/add_payment_method_page.dart';
import '../presentation/payment/payment_page.dart';
import '../presentation/product_detail/producet_details_page.dart';
import '../presentation/saved/saved_page.dart';
import '../presentation/search/search_page.dart';

export 'package:go_router/go_router.dart';

class AppRoute {
  static const String startPage = "/landing_page";
  static const String loginOption = "/landing_page/login_option";
  static const String signUp = "/landing_page/sign_up";
  static const String signIn = "/landing_page/sign_in";
  static const String resetPassword = "/landing_page/reset_password";
  static const String otp = "/landing_page/reset_password/otp";
  static const String newPassword = "/landing_page/reset_password/new_password";

  static const String home = "/";
  static const String saved = "/saved";
  static const String productDetails = "/product_details";
  static const String cart = "/cart";
  static const String search = "/search";

  static const String payment = "/payment";
  static const String createPayment = "/payment/create";

  static const String author = "/author";

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  ///
  static GoRouter routerConfig(UserModel? user) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: startPage,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            final user = state.extra as UserModel? ?? UserModel.ui;
            return SafeArea(
              child: AppBottomNavbar(model: user, child: child),
            );
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: home,
              pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: saved,
              pageBuilder: (context, state) => const NoTransitionPage(child: SavedPage()),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: cart,
              pageBuilder: (context, state) => const NoTransitionPage(child: CartPage()),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: search,
              pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const SearchPage()),
            )
          ],
        ),
        GoRoute(
          path: productDetails,
          builder: (context, state) {
            final item = (state.extra as Map?)?["product"] ?? ProductModel.ui;
            final repo = (state.extra as Map)["repo"];
            return ShopProvider(
              repo: repo,
              child: ProductDetailsPage(model: item),
            );
          },
        ),
        GoRoute(
          path: startPage,
          builder: (context, state) {
            return const LandingPage();
          },
          routes: [
            GoRoute(
              path: 'login_option',
              builder: (context, state) => const LoginOptionSelectionPage(),
            ),
            GoRoute(
              path: 'sign_up',
              builder: (context, state) => const SignUpPage(),
            ),
            GoRoute(
              path: 'sign_in',
              builder: (context, state) => const SignInPage(),
            ),
            GoRoute(
              path: 'login_option',
              builder: (context, state) => const LoginOptionSelectionPage(),
            ),
            GoRoute(
              path: 'reset_password',
              builder: (context, state) => const ResetPasswordPage(),
              routes: [
                GoRoute(
                  path: 'otp',
                  builder: (context, state) => const OtpPage(),
                ),
                GoRoute(
                  path: 'new_password',
                  builder: (context, state) => const NewPasswordPage(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: payment,
          builder: (context, state) => PaymentPage(total: state.extra as double? ?? 120),
          routes: [
            GoRoute(
              path: "create",
              builder: (context, state) => AddPaymentMethodPage(
                type: state.extra as PaymentMethodEnum? ?? PaymentMethodEnum.masterCard,
              ),
            )
          ],
        ),
        GoRoute(
          path: author,
          builder: (context, state) => const AboutPage(),
        )
      ],
    );
  }
}
