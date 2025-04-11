import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class AuthBackGroundWrapper extends StatelessWidget {
  const AuthBackGroundWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    const path = "assets/images/top_banner_fruits.png";

    const gap = SizedBox(height: 24);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(alignment: Alignment.topCenter, child: AppBar()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppTheme.background,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: Column(
                  children: [
                    gap,
                    FractionallySizedBox(
                      widthFactor: .5,
                      child: Container(
                        height: 4,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    gap,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
