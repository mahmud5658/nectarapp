import 'dart:ui';

import 'package:flutter/material.dart';

import 'background_bubble.dart';

class BackgroundView extends StatelessWidget {
  const BackgroundView({
    super.key,
    required this.child,
    required this.bubble,
  });

  factory BackgroundView.single({required Widget child, Key? key}) {
    return BackgroundView(
      bubble: const [BackgroundBubble(alignment: Alignment(-1.2, -.75))],
      key: key,
      child: child,
    );
  }

  factory BackgroundView.two({required Widget child, Key? key}) {
    return BackgroundView(bubble: const [
      BackgroundBubble(alignment: Alignment(1.2, -1.1)),
      BackgroundBubble(alignment: Alignment(-.5, .95))
    ], key: key, child: child);
  }

  factory BackgroundView.triple({required Widget child, Key? key}) {
    return BackgroundView(
      bubble: const [
        BackgroundBubble(alignment: Alignment(-1.25, -1)),
        BackgroundBubble(alignment: Alignment(1.2, 0)),
        BackgroundBubble(alignment: Alignment(-1.2, .95)),
      ],
      key: key,
      child: child,
    );
  }

  final Widget child;

  final List<BackgroundBubble> bubble;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Stack(
          children: [
            for (final b in bubble) b,
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
