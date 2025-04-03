import 'package:flutter/material.dart';
import 'package:grocery_app/src/app/route_config.dart';
import '../../../app/app_theme.dart';
import '../../../infrastructure/infrastructure.dart';

class UserProfileHeaderView extends StatelessWidget {
  const UserProfileHeaderView({
    super.key,
    required this.model,
  });

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              "Hey ${model.name}!",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_important_rounded),
              color: AppTheme.primary,
            ),
            InkWell(
              onTap: () {
                context.push(AppRoute.author);
              },
              child: Material(
                shape: const CircleBorder(
                  side: BorderSide(color: AppTheme.primary),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  model.avatar,
                  height: 48,
                  width: 48,
                ),
              ),
            )
          ],
        ),
        const Text("What do you like to find?")
      ],
    );
  }
}
