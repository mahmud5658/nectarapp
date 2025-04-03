import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../_common/_common.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const gap = SizedBox(height: 32);

    return BackgroundView.single(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/landing_fruits.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Buy ",
                        children: [
                          TextSpan(
                            text: "Grocery",
                            style: textTheme.headlineLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          const TextSpan(text: " items easily with us")
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(),
                    ),
                    gap,
                    const Text(
                      "If you keep good food in your fridge, you will eat good food",
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    AppButton.large(
                      onTap: () {
                        context.push(AppRoute.loginOption);
                      },
                      label: "Get Started",
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
