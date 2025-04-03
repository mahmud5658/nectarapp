import 'package:flutter/material.dart';
import '../../../app/app_theme.dart';

class ItemCounter extends StatefulWidget {
  const ItemCounter({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
  });

  final int initialValue;
  final ValueChanged<int> onChanged;
  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  late int value = widget.initialValue;

  @override
  void didUpdateWidget(covariant ItemCounter oldWidget) {
    if (widget.initialValue != value) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildButton(
          textStyle,
          false,
          () {
            value--;

            if (value < 0) return;
            widget.onChanged(value);
            setState(() {});
          },
        ),
        SizedBox(
          width: 26,
          child: Text(
            "$value",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        buildButton(
          textStyle,
          true,
          () {
            ///
            value++;

            widget.onChanged(value);
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget buildButton(TextStyle? textStyle, bool isPositive, VoidCallback onTap) {
    return SizedBox.square(
      dimension: 24,
      child: Material(
        color: AppTheme.primary,
        shape: CircleBorder(),
        child: IconButton(
          iconSize: 12,
          padding: EdgeInsets.all(0),
          onPressed: onTap,
          splashRadius: 12,
          icon: Icon(
            isPositive ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
