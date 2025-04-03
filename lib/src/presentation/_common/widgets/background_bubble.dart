import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

///  create bubble for [BackgroundView]
///
class BackgroundBubble extends StatelessWidget {
  const BackgroundBubble({
    super.key,
    this.colors = AppTheme.bubbleColors,
    this.radius = 1,
    this.size = const Size(200, 200),
    required this.alignment,
  });

  final List<Color> colors;
  final double radius;
  final Size size;

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox.fromSize(
        size: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: colors,
              stops: const [0, 1],
            ),
          ),
        ),
      ),
    );
  }
}
